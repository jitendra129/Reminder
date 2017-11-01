//
//  MenuItemObject.m
//  TABQY MENU
//
//  Created by ASK ONLINE  on 05/04/17.
//  Copyright © 2017 ASK ONLINE . All rights reserved.
//

#import "MenuItemObject.h"

@implementation MenuItemObject
+ (MenuItemObject *)instanceFromDictionary:(NSDictionary *)aDictionary {
    
    MenuItemObject *instance = [[MenuItemObject alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
    
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {
    
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.title = [aDictionary objectForKey:@"title"];
    self.msg = [aDictionary objectForKey:@"msg"];
    self.date = [aDictionary objectForKey:@"date"];
    self.time = [aDictionary objectForKey:@"time"];
    self.remId = [aDictionary objectForKey:@"remId"];
    self.dateWithFormat=[aDictionary objectForKey:@"datewithTime"];

    
}


- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        
    
self.dateWithFormat = [decoder decodeObjectForKey:@"datewithTime"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.msg = [decoder decodeObjectForKey:@"msg"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.time = [decoder decodeObjectForKey:@"time"];
        
        self.remId = [decoder decodeObjectForKey:@"remId"];
        
       
        
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //appLogicId
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.msg forKey:@"msg"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.time forKey:@"time"];
    [encoder encodeObject:self.remId forKey:@"remId"];
    [encoder encodeObject:self.dateWithFormat forKey:@"datewithTime"];
    
  
    
}





@end
