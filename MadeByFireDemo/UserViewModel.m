//
//  UserViewModel.m
//  MadeByFireDemo
//
//  Created by SreenivasulaReddy on 26/04/17.
//  Copyright © 2017 SreenivasulaReddy. All rights reserved.
//

#import "UserViewModel.h"
#import "WebServiceAPI.h"
@import UIKit;
@implementation UserViewModel

-(id)init:(User*)user
{
    if ( self = [super init] )
    {
        self.modelUser = user;
        _modeluserid = user.userid;
        _modelname = user.name;
        _modelusername = user.username;
        _modelemail = user.email;
        _modelstreet= user.street;
        _modelsuite = user.suite;
        _modelcity = user.city;
        _modelzipcode = user.zipcode;
        _modellng = user.lng;
        _modellat = user.lat;
        _modelphone = user.phone;
        _modelwebsite= user.website;
        _modelcompanyName = user.companyName;
        _modelcatchPhrase = user.catchPhrase;
        _modelbs = user.bs;
        
    }
    return self;
}


-(void)getWebData:(void (^)(NSMutableArray *resultArr))completion

{
    __block NSMutableArray *userArray;
    
    [[WebServiceAPI websharedInstance] callusersAPI:@{} WithCompletion:^(NSMutableArray *resultDict, NSError *error, BOOL status)
     {
         NSMutableArray *array = [NSMutableArray array];
         userArray = [NSMutableArray array];
         if (status)
         {
             if (resultDict.count>0)
             {
                 array = [User parserUserData:resultDict];
                 
                 for (User *obj in array)
                 {
                     UserViewModel *ubmodel = [[UserViewModel alloc]init:obj];
                     [userArray addObject:ubmodel];
                 }
             }
             else
             {
                 [self showAlert:@"No User data Found"];
             }
         }
         completion(userArray);

     }];
}

-(void)showAlert:(NSString*)mesaage
{
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    UIViewController *mainController = [keyWindow rootViewController];
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Demo"
                                          message:@"NoData"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       
                                       NSLog(@"Cancel action");
                                      
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [mainController presentViewController:alertController animated:YES completion:nil];
}
@end
