//
//  ViewAllPush.h
//  Reminder
//
//  Created by mac on 06/07/1939 Saka.
//  Copyright © 1939 Saka CSI. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol updateBgDelegate
-(void)getUpdateddata;
@end

@interface ViewAllPush : UIViewController
@property (assign) id<updateBgDelegate> delegate;

-(void)getUpdateddata;
@property(strong,nonatomic)NSMutableArray *arrayPushList;
@end
