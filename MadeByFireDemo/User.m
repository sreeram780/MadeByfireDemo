//
//  User.m
//  MadeByFireDemo
//
//  Created by SreenivasulaReddy on 26/04/17.
//  Copyright © 2017 SreenivasulaReddy. All rights reserved.
//

#import "User.h"

@implementation User

- (NSString *)emptyStringIfNil:(NSString *)string
{
    
    NSString *myString = @"";
    
    myString =[string isEqual:[NSNull null]] ? @"" : string;
    
    return myString;
}
-(NSString *)convertNSNumberToNSString:(id )number{
    
    NSString *numToStr = @"";
    if ([number isKindOfClass:[NSNumber class]]) {
        
        numToStr = ![number isEqual:[NSNull null]] ? [number stringValue] :@"" ;
    }else
        numToStr = [number isEqual:[NSNull null]] ? @"" : number;
    
    return numToStr;
}


-(id)initWithInfo :(NSDictionary*)dic
{
    self =[super init];
    
    if (self)
    {
        _userid =  [self convertNSNumberToNSString: dic[@"id"]].length > 0 ?  [self convertNSNumberToNSString: dic[@"id"]] : @"";
        
        _name = [self emptyStringIfNil:dic[@"name"]].length > 0 ?  dic[@"name"] : @"";
        
        _username = [self emptyStringIfNil:dic[@"username"]].length > 0 ?  dic[@"username"] : @"";
        
        _email = [self emptyStringIfNil:dic[@"email"]].length > 0 ?  dic[@"email"] : @"";
        
        NSDictionary *address = dic[@"address"];
        
        _street = [self emptyStringIfNil:address[@"street"]].length > 0 ?  address[@"street"] : @"";
        
        _suite = [self emptyStringIfNil:address[@"suite"]].length > 0 ?  address[@"suite"] : @"";
        
        _city = [self emptyStringIfNil:address[@"city"]].length > 0 ?  address[@"city"] : @"";
        
        _zipcode = [self emptyStringIfNil:address[@"zipcode"]].length > 0 ?  address[@"zipcode"] : @"";
        
         NSDictionary *geoaddress = address[@"geo"];
        
        _lat = [self emptyStringIfNil:geoaddress[@"lat"]].length > 0 ?  geoaddress[@"lat"] : @"";
        
        _lng = [self emptyStringIfNil:geoaddress[@"lng"]].length > 0 ?  geoaddress[@"lng"] : @"";
        
        _phone = [self emptyStringIfNil:dic[@"phone"]].length > 0 ?  dic[@"phone"] : @"";
        
        _website = [self emptyStringIfNil:dic[@"website"]].length > 0 ?  dic[@"website"] : @"";
        
        NSDictionary *companyaddress = dic[@"company"];

        _companyName = [self emptyStringIfNil:companyaddress[@"name"]].length > 0 ?  companyaddress[@"name"] : @"";
        
        _catchPhrase = [self emptyStringIfNil:companyaddress[@"catchPhrase"]].length > 0 ?  companyaddress[@"catchPhrase"] : @"";
        
        _bs = [self emptyStringIfNil:companyaddress[@"bs"]].length > 0 ?  companyaddress[@"bs"] : @"";
        
    }
    return self;
}

+(NSMutableArray*)parserUserData:(NSMutableArray*)jsonObj
{
    NSMutableArray * returnArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic  in jsonObj)
    {
        User * testUser = [[User alloc]initWithInfo:dic];
        [returnArray addObject:testUser];
    }
    return returnArray;
}

@end

/*id: 1,
name: "Leanne Graham",
username: "Bret",
email: "Sincere@april.biz",
address: {
street: "Kulas Light",
suite: "Apt. 556",
city: "Gwenborough",
zipcode: "92998-3874",
geo: {
lat: "-37.3159",
lng: "81.1496"
}
},
phone: "1-770-736-8031 x56442",
website: "hildegard.org",
company: {
name: "Romaguera-Crona",
catchPhrase: "Multi-layered client-server neural-net",
bs:*/


