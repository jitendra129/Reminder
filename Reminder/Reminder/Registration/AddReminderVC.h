//
//  AddReminderVC.h
//  Reminder
//
//  Created by mac on 31/06/1939 Saka.
//  Copyright © 1939 Saka CSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemObject.h"
@protocol addReminderDelegate
- (void)getRemainderData: (MenuItemObject *)selectedData;
- (void)deleteRemainderData: (NSString *)Key;
- (void)UpdateRemainderData: (NSString *)Key;
@end
@interface AddReminderVC : UIViewController
@property(strong,nonatomic)NSString *SelectedIndex;
@property(strong,nonatomic)MenuItemObject *objectData;

@property (assign) id<addReminderDelegate> delegate;
- (void)getRemainderData: (MenuItemObject *)selectedData;
- (void)deleteRemainderData: (NSString *)Key;
- (void)UpdateRemainderData: (NSString *)Key;


@end
