//
//  MenuItemObject.h
//  TABQY MENU
//
//  Created by ASK ONLINE  on 05/04/17.
//  Copyright © 2017 ASK ONLINE . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MenuItemObject : NSObject {

    
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *msg;
@property(nonatomic,copy)  NSString *dateWithFormat;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *remId;

+ (MenuItemObject *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end

