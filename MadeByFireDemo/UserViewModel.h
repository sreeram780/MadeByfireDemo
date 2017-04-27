//
//  UserViewModel.h
//  MadeByFireDemo
//
//  Created by SreenivasulaReddy on 26/04/17.
//  Copyright © 2017 SreenivasulaReddy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserViewModel : NSObject

@property(nonatomic) User *modelUser;

@property (strong,nonatomic) NSString *modeluserid;
@property (strong,nonatomic) NSString *modelname;
@property (strong,nonatomic) NSString *modelusername;
@property (strong,nonatomic) NSString *modelemail;
@property (strong,nonatomic) NSString *modelstreet;
@property (strong,nonatomic) NSString *modelsuite;
@property (strong,nonatomic) NSString *modelcity;
@property (strong,nonatomic) NSString *modelzipcode;
@property (strong,nonatomic) NSString *modellat;
@property (strong,nonatomic) NSString *modellng;
@property (strong,nonatomic) NSString *modelphone;
@property (strong,nonatomic) NSString *modelwebsite;
@property (strong,nonatomic) NSString *modelcompanyName;
@property (strong,nonatomic) NSString *modelcatchPhrase;
@property (strong,nonatomic) NSString *modelbs;

-(void)getWebData:(void (^)(NSMutableArray *resultArr))completion;

@end
