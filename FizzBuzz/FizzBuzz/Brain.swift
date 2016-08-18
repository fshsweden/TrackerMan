//
//  Brain.swift
//  FizzBuzz
//
//  Created by Peter Andersson on 14/08/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import Foundation

public class Brain : NSObject {
    
    func isDivisibleBy(number: Int, divisor: Int) -> Bool {
        if number % divisor  == 0 {
            return true
        } else {
            return false
        }
    }
    
    func check(number: Int) -> String {
        if (
            isDivisibleBy(number, divisor: 5) &&
            isDivisibleBy(number, divisor: 3)
        )
        {
           return "FizzBuzz"
        }
        
        if (isDivisibleBy(number, divisor: 3))
        {
            return "Fizz"
        }
        
        if (isDivisibleBy(number, divisor: 5))
        {
            return "Buzz"
        }
        
        return ""
        
    }
}
