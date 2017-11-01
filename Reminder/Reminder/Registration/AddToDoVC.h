//
//  AddToDoVC.h
//  Reminder
//
//  Created by mac on 05/07/1939 Saka.
//  Copyright © 1939 Saka CSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemObject.h"
@protocol addToDoDelegate
- (void)getToDoData: (MenuItemObject *)selectedData;
- (void)deleteToDoData: (NSString *)Key;
- (void)UpdateToDoData: (NSString *)Key;
@end
@interface AddToDoVC : UIViewController
@property(strong,nonatomic)NSString *SelectedIndex;
@property (assign) id<addToDoDelegate> delegate;
- (void)getToDoData: (MenuItemObject *)selectedData;
- (void)deleteToDoData: (NSString *)Key;
- (void)UpdateToDoData: (NSString *)Key;


@end
