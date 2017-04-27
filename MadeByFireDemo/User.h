//
//  User.h
//  MadeByFireDemo
//
//  Created by SreenivasulaReddy on 26/04/17.
//  Copyright © 2017 SreenivasulaReddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong,nonatomic) NSString *userid;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *street;
@property (strong,nonatomic) NSString *suite;
@property (strong,nonatomic) NSString *city;
@property (strong,nonatomic) NSString *zipcode;
@property (strong,nonatomic) NSString *lat;
@property (strong,nonatomic) NSString *lng;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *website;
@property (strong,nonatomic) NSString *companyName;
@property (strong,nonatomic) NSString *catchPhrase;
@property (strong,nonatomic) NSString *bs;

+(NSMutableArray*)parserUserData:(NSMutableArray*)jsonObj;

@end
