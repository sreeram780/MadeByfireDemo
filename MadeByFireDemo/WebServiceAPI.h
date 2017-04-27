//
//  WebServiceAPI.h
//  MadeByFireDemo
//
//  Created by SreenivasulaReddy on 26/04/17.
//  Copyright © 2017 SreenivasulaReddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceAPI : NSObject

/*
 * Shared instance
 * returns the singleton object of the current class
 */

+ (id)websharedInstance;

/* user Api
 * returns the list of All Users
 */
-(void)callusersAPI:(NSDictionary *)param WithCompletion:(void (^)(NSMutableArray *resultDict, NSError *error, BOOL status))completion;

@end
