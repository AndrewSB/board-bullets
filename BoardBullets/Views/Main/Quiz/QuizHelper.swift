//
//  QuizHelper.swift
//  Board-Bullets
//
//  Created by Andrew Breckenridge on 1/22/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import Foundation
import Parse

class QuizHelper {
    
    class func questionQuery() -> PFQuery {
        let questionQuery = PFQuery(className: "Questions")
        questionQuery.whereKey("approved", equalTo: true)
        return questionQuery
    }
    
    class func genRandom(count: Int, limit: Int) -> [Int] {
        var a = [Int]()
        while a.count != count {
            let i = Int(arc4random_uniform(UInt32(limit)))
            if !a.contains(i) {
                a.append(i)
            }
        }
        print("random is \(a)")
        return a
    }
    
    class func genQuiz(numberOfQuestions: Int, vc: UIViewController) -> [Question] {
        var questions = [Question]()
        
        let questionQuery = PFQuery(className: "Questions")
        questionQuery.whereKey("approved", equalTo: true)
        
        var queries: [PFQuery]
        if InAppPurchase.bought {
            queries = genRandom(numberOfQuestions, limit: cachedQuestionCount()).map {
                let qq = QuizHelper.questionQuery()
                return qq.whereKey("index", equalTo: $0)
            }
        } else {
            let indx = (0...(numberOfQuestions-1)).map { $0 }
            queries = indx.map {
                let qq = QuizHelper.questionQuery()
                return qq.whereKey("index", equalTo: $0)
            }
        }
        
        
        var errPointer: NSError?
        let objects = PFQuery.orQueryWithSubqueries(queries.dropLast(10).map {$0}).findObjects(&errPointer)
        let otherObjects = PFQuery.orQueryWithSubqueries(queries.dropFirst(10).map {$0}).findObjects(&errPointer)
        
        if let err = errPointer {
            print("no internet")
            
            let alert = UIAlertController(title: "Uh oh", message: err.localizedDescription, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            vc.presentViewController(alert, animated: true, completion: nil)
        } else if let objects = objects, let otherObjects = otherObjects {
            questions = objects.map { Question(parseObject: $0 as! PFObject) }
            otherObjects.forEach {
                questions.append(Question(parseObject: $0 as! PFObject))
            }
        }
        
        return questions
    }
    
    class func cachedQuestionCount() -> Int {
        let epoc = NSUserDefaults.standardUserDefaults().objectForKey("lastCachedDate")
        
        if let epoc = epoc as? Double {
            let lastCachedDate = NSDate(timeIntervalSince1970: epoc)
            if abs(lastCachedDate.timeIntervalSinceNow) > (60*60*60*24*3) { // 3 days
                let c = questionQuery().countObjects()
                NSUserDefaults.standardUserDefaults().setObject(c, forKey: "lastCachedValue")
                NSUserDefaults.standardUserDefaults().setObject(abs(NSDate().timeIntervalSince1970), forKey: "lastCachedDate")
                return c
            } else {
                return NSUserDefaults.standardUserDefaults().objectForKey("lastCachedValue") as! Int
            }
        } else {
            let c = questionQuery().countObjects()
            NSUserDefaults.standardUserDefaults().setObject(c, forKey: "lastCachedValue")
            NSUserDefaults.standardUserDefaults().setObject(abs(NSDate().timeIntervalSince1970), forKey: "lastCachedDate")
            return c
        }
    }
}
