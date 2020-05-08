//
//  DispatchQueue+Extension.swift
//  MotoShop
//
//  Created by AmrAngry on 4/21/20.
//  Copyright © 2020 ADKA Tech. All rights reserved.
//

import Foundation

///
///  ` iOS Dev Techies ` 🔥
///
///  Video 1 : ` Singletone and dispatch_once `
///

// ==================== Objective C ==================== //

//  @interface SingletonClass : NSObject
//  @end
//
//  @implementation SingletonClass
//
//  + (instancetype)sharedInstance {
//      static SingletonClass *sharedInstance = nil;
//      static dispatch_once_t onceToken;
//
//      dispatch_once(&onceToken, ^{
//          sharedInstance = [[SingletonClass alloc] init];
//      });
//      return sharedInstance;
//  }
//
//  @end

// ==================== Swift ==================== //

final public class Singleton {

    ///shared varible
    public static let sharedInstance: Singleton = Singleton()

    private init() { }

}

public func runMe() {
    struct InnerScope {
        static let closure: Void = {
            print("Once")
        }()
    }
    InnerScope.closure
}

//runMe() // Once
//runMe()
//runMe()
//runMe()
//runMe()

// ==================== Dispatch Extension ==================== //

public extension DispatchQueue {
    
    // OnceTokens should be Unique Keys, So please use UUIDs insted of Ints
    // Thanks to AbuZeid Ibrahim for mention this point :)
    ///UUID stands for Universally Unique Identifier
    /// Chance of generating the same identifier twice, on any device on the planet, is basically zero!
    /// initializer generates 128 random bits.
    
    private static var onceTokens = [Int]()
    private static var internalQueue = DispatchQueue(label: "iosdevtechies.once")
    
    class func once(token: Int, closure: () -> Void) {
        internalQueue.sync {
            if onceTokens.contains(token) {
                return
            }
            onceTokens.append(token)
            closure()
        }
    }
    
}

//let token = 1
//DispatchQueue.once(token: token) {
//    print("Once")
//}
//
//let anotherToken = 2
//DispatchQueue.once(token: anotherToken) {
//    print("Two")
//}
//
//DispatchQueue.once(token: token) {
//    print("Three")
//}
