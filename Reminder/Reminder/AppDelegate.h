//
//  AppDelegate.h
//  Reminder
//
//  Created by mac on 31/06/1939 Saka.
//  Copyright © 1939 Saka CSI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JKHomeVC.h"
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate : UIResponder

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) id observer;

@property (nonatomic, retain) NSString * appUserCity;
@property (nonatomic, retain) NSString * appUserState;

@property (nonatomic, retain) UINavigationController * navigationController;
@property (strong,nonatomic)  JKHomeVC *ceterViewController;


@end
