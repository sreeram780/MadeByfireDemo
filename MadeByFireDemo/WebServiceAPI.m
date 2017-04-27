//
//  WebServiceAPI.m
//  MadeByFireDemo
//
//  Created by SreenivasulaReddy on 26/04/17.
//  Copyright © 2017 SreenivasulaReddy. All rights reserved.
//

#import "WebServiceAPI.h"

@implementation WebServiceAPI

+ (id)websharedInstance
{
    static WebServiceAPI * restObj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        restObj = [WebServiceAPI new];
    });
    return restObj;
}

#pragma mark Create Request URL
- (NSMutableURLRequest *)requestWithURL:(NSString *)baseURL parameters:(NSDictionary *)params
{
    NSMutableArray * postData = [NSMutableArray new];
    
    NSArray * keys = [params allKeys];
    
    for (NSString * key in keys) {
        [postData addObject:[NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
   // NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    NSString *encodedUrl = [NSString stringWithFormat:@"%@?%@",baseURL,[postData componentsJoinedByString:@"&"]] ;
//stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURL * url = [NSURL URLWithString:encodedUrl];
    
    NSLog(@"Rest URL : %@",url);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    
    return request;
}

- (NSMutableURLRequest *)mutableRequestWithURL:(NSString *)baseURL parameters:(NSDictionary *)params {
    
    NSError * serializeError;
    
    NSData *jsonParmametrsData=[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&serializeError];
    
    NSURL * url =[NSURL URLWithString:baseURL];
    
    NSLog(@"Rest URL : %@",url);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonParmametrsData];
    
    return request;
    
}

-(void)callusersAPI:(NSDictionary *)param WithCompletion:(void (^)(NSMutableArray *resultDict, NSError *error, BOOL status))completion
{
    __block NSError * standarderror;
    __block BOOL status;
    __block    NSMutableArray*result;
    
    NSMutableURLRequest * request = [self requestWithURL:@"https://jsonplaceholder.typicode.com/users" parameters:param];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
        if (!error)
        {
            if (completion)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&standarderror];
                    if (!standarderror)
                    {
                            status=YES;
                    }
                    completion(result, error, status);
                });
            }
        }
        else
        {
            if (completion)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(result, error, status);
                });
            }
        }
        
    }] resume];
}

@end
