//
//  AppDelegate.m
//  CarGates
//
//  Created by ASK ONLINE  on 17/06/17.
//  Copyright © 2017 ASK ONLINE . All rights reserved.
//

#import "AppDelegate.h"

#import "JKHomeVC.h"
#import "ECSHelper.h"
#import "MenuItemObject.h"
#import "AddReminderVC.h"
@interface AppDelegate ()
{
    MenuItemObject *object;
    NSMutableArray *arryObjects;
    
    NSTimer *oneSecondTimer ;

}
@property (nonatomic, retain) UIViewController * baseController;
@property (nonatomic, retain) UIViewController * splashScreenViewController;
@property (nonatomic, retain) NSString * launchUrl;
@property (strong, nonatomic) NSMutableArray *arrReminderList;

@property (assign) SEL callback;
@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.launchUrl = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }

    UIViewController *contentVC;
    
    
    contentVC=[[JKHomeVC alloc]initWithNibName:@"JKHomeVC" bundle:nil];
    
    
   // UIViewController *menuVC=[[DS_SideMenuVC alloc]initWithNibName:@"DS_SideMenuVC" bundle:nil];
    UINavigationController *contentNavigationController = [[UINavigationController alloc] initWithRootViewController:contentVC];
    [contentNavigationController setNavigationBarHidden:YES];
    [self.window setRootViewController:contentNavigationController];
    self.window.rootViewController = contentNavigationController;
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.window  makeKeyAndVisible];
    
    return YES;
    
}

- (void) createLocalNotification :(NSString *)msg{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate date];
    localNotification.alertBody = msg;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    localNotification.soundName=@"Ping.aiff";
    //localNotification.s
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // Request to reload table view data
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
     //application.undoManager=
   
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [self startTimedTask];
    
    arryObjects=[[NSMutableArray alloc]init];
    

}

- (void)startTimedTask
{
    oneSecondTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(performBackgroundTask) userInfo:nil repeats:YES];
    
    
    [oneSecondTimer fire];
    
}

- (void)performBackgroundTask
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Do background work
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"hello");
            
            self.arrReminderList=[[NSMutableArray alloc]init];
            // NSString *strForKey=[NSString stringWithFormat:@"Reminder%ld",(long)nextR];
            NSInteger nextR=[ECSUserDefault getIntFromUserDefaultForKey:@"Count"];
            for (int i=0; i<=nextR; i++) {
                NSString *key=[NSString stringWithFormat:@"Reminder%d",i];
                NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
                if (data.length) {
                    MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *stringDate = [dateFormatter stringFromDate:[NSDate date]];
                    

                    NSDate *date = [dateFormatter dateFromString:obj.dateWithFormat];
                     NSDate *currentDate=[dateFormatter dateFromString:stringDate];
                      NSTimeInterval timeDifference = [currentDate timeIntervalSinceDate:date];
                    NSLog(@"timeDifference=%f", timeDifference);

                    if (timeDifference==0) {
                        [self createLocalNotification:obj.msg];
                        [arryObjects addObject:obj];
                        object=obj;
                        sleep(1.0);
                        return ;
                    }
                   // [self.arrReminderList addObject:obj];
                }
            }
            
           // int numElements = (int) self.arrReminderList.count;
            
           // [ECSUserDefault saveInt:numElements ToUserDefaultForKey:@"Count"];
            //Update UI
        });
    });
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Do something
    NSLog(@"hello get  notification from  push tab");
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ShowReminderPush"
     object:arryObjects];
    [oneSecondTimer invalidate];
//    AddReminderVC *contentVC=[[AddReminderVC alloc]initWithNibName:@"AddReminderVC" bundle:nil];
//    contentVC.SelectedIndex=object.remId;
//    [self.navigationController pushViewController:contentVC animated:NO];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
