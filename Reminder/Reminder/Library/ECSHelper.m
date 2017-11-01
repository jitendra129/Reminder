//
//  ECSHelper.m
//  TME
//
//  Created by Jitendra Maurya on 03/12/13.
//  Copyright (c) 2013 Jitendra Maurya. All rights reserved.
//

//#import "ECSConfig.h"
#import "ECSHelper.h"
#import "UIExtensions.h"
#import <MessageUI/MessageUI.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
//#import "ECSConfig.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
//#import "MVYSideMenuController.h"
//#import "iToast.h"
//#import "Reachability.h"
//#import "MBProgressHUD.h"

@interface ECSHelper ()<MFMailComposeViewControllerDelegate>
@property (nonatomic, retain) UIViewController * controller;
@end

@implementation ECSHelper


+(void)setRootViewController:(UIViewController *)controller
{
    AppDelegate * appDelegate = [[UIApplication sharedApplication]delegate];
    NSMutableArray * controllersArray = [[[appDelegate navigationController] viewControllers]mutableCopy];
    [controllersArray removeAllObjects];
    [controllersArray addObject:controller];
    [[appDelegate navigationController]setViewControllers:controllersArray];



}

//
//
//+(void)setRootViewController:(UIViewController *)controller withLeftController:(UIViewController *)leftController
//{
//    
//    
//    
//    AppDelegate * appDelegate = [[UIApplication sharedApplication]delegate];
//    NSMutableArray * controllersArray = [[[appDelegate navigationController] viewControllers]mutableCopy];
//    [controllersArray removeAllObjects];
//    
//    appDelegate.sideMenuController = nil;
//    
//    
//    UINavigationController *contentNavigationController = [[UINavigationController alloc] initWithRootViewController:controller];
//    [contentNavigationController setNavigationBarHidden:YES];
//    MVYSideMenuOptions *options = [[MVYSideMenuOptions alloc] init];
//    options.contentViewScale = 1.0;
//    options.contentViewOpacity = 0.05;
//    options.shadowOpacity = 0.0;
//    appDelegate.sideMenuController = [[MVYSideMenuController alloc] initWithMenuViewController:leftController
//                                                                                    contentViewController:controller
//                                                                                                  options:options];
//    appDelegate.sideMenuController.menuFrame = CGRectMake(0, 0, 290.0, appDelegate.window.bounds.size.height);
//    
//    [controllersArray addObject:appDelegate.sideMenuController];
//    [[appDelegate navigationController]setViewControllers:controllersArray];
//    
//}
//




@end

@implementation ECSToast
//+(void)showToast:(NSString *)message view:(UIView *)view
//{
//    
//    if(!message) return;
//    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    
//    // Configure for text only and offset down
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = message;
//    hud.margin = 10.f;
//    hud.yOffset = 150.f;
//    hud.removeFromSuperViewOnHide = YES;
//    
//    [hud hide:YES afterDelay:4.0];
//
//
//
//
//}
@end




@implementation ECSAlert



+(void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    
        //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //    [alert show];
//        [[[[iToast makeText:message]
//           setGravity:iToastGravityBottom] setDuration:iToastDurationNormal] show];
   
}

+(void)showApiError:(NSDictionary *)rootDictionary respString:(NSString *)respString error:(NSError *)error
{
    if(respString.length == 0)
    {
       [ECSAlert showAlert:error.localizedDescription];
    }
    else
    {
    NSArray * errorArray = [rootDictionary objectForKey:@"error"];
    if((errorArray) && [errorArray isKindOfClass:[NSArray class]])
    {
        if(errorArray.count > 0)
        {
        NSString * erroString = [NSString stringWithFormat:@"ERROR_%@",[errorArray objectAtIndex:0]];
        [ECSAlert showAlert:erroString];
        }
        else [ECSAlert showAlert:respString];
    }
    else if([errorArray isKindOfClass:[NSString class]])
    {
         NSString * errorMessage = (NSString *)errorArray;
         [ECSAlert showAlert:errorMessage];
    }
    else [ECSAlert showAlert:respString];
    }
}


+(void)showAlert:(NSString *)message withDelegate:(UIViewController *)ctrl andTag:(int)tag
{

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:ctrl cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
  
    [alert setTag:tag];
    [alert show];

}

@end


@implementation ECSUserDefault


// get the values from user defaults

+(BOOL)getBoolFromUserDefaultForKey:(NSString *)string
{
    return [[NSUserDefaults standardUserDefaults]boolForKey:string];

}

+(NSInteger)getIntFromUserDefaultForKey:(NSString *)string{
    
    return [[NSUserDefaults standardUserDefaults]integerForKey:string];

}
+(NSString *)getStringFromUserDefaultForKey:(NSString *)string{

    return [[NSUserDefaults standardUserDefaults]stringForKey:string];

}
+(float)getFloatFromUserDefaultForKey:(NSString *)string{
 
    return [[NSUserDefaults standardUserDefaults]floatForKey:string];

}
+(id)getObjectFromUserDefaultForKey:(NSString *)string{

   return [[NSUserDefaults standardUserDefaults]objectForKey:string];
    
}

// svae the values to user defaults 


+(void)saveBool:(BOOL)val ToUserDefaultForKey:(NSString *)string{
    
    [[NSUserDefaults standardUserDefaults]setBool:val forKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

+(void)saveInt:(int)val ToUserDefaultForKey:(NSString *)string
{
    [[NSUserDefaults standardUserDefaults]setInteger:val forKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+(void)saveString:(NSString *)val ToUserDefaultForKey:(NSString *)string
{
    [[NSUserDefaults standardUserDefaults]setObject:val forKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+(void)saveFloat :(float)val ToUserDefaultForKey:(NSString *)string
{
    [[NSUserDefaults standardUserDefaults]setFloat:val forKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+(void)saveObject:(id)val ToUserDefaultForKey:(NSString *)string
{
    [[NSUserDefaults standardUserDefaults]setObject:val forKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(void)RemoveObjectFromUserDefaultForKey:(NSString *)string{
    
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:string];
    [[NSUserDefaults standardUserDefaults]synchronize];
}



@end


// Implementation of ecsdate helper



@implementation ECSDate

+(NSString *)getFormattedDateString:(NSString *)string inFormat:(NSString *)formString
{
    NSDateFormatter *formatter = nil;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * olddate  = [formatter dateFromString:string];formatter = nil;
    NSDateFormatter *formatterN = [[NSDateFormatter alloc]init];
    [formatterN setDateFormat:formString];
    return [formatterN stringFromDate:olddate];

}


+(NSString *)getFormattedScrapDateString:(NSString *)string inFormat:(NSString *)formString
{
    NSDateFormatter *formatter = nil;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * olddate  = [formatter dateFromString:string];formatter = nil;
    NSDateFormatter *formatterN = [[NSDateFormatter alloc]init];
    [formatterN setDateFormat:formString];
    return [formatterN stringFromDate:olddate];
    
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}



+(NSString *)getFormattedTimeString:(NSString *)string inFormat:(NSString *)formString
{
    NSDateFormatter *formatter = nil;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate * olddate  = [formatter dateFromString:string];formatter = nil;
    NSDateFormatter *formatterN = [[NSDateFormatter alloc]init];
    [formatterN setDateFormat:formString];
    return [formatterN stringFromDate:olddate];
    
}

+(NSString *)getTheTimeDiffrenceString:(NSString *)createdAt
{
    NSString * string = nil;
    int value = 0;
    NSString * unit = @"";
    
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
     NSDate * parsedDate = [formatter dateFromString:createdAt];
    
    //secondsFromGMTForDate
    int epochTime = (int)[[NSDate date] timeIntervalSinceDate:parsedDate];
    
    if(epochTime < 60)
    {
        string = [NSString stringWithFormat:@"%is ago",epochTime];
    }
    else if (epochTime < 60*60)
    {
        value = epochTime/60;
        if(value == 1) unit = @"min";
        else unit = @"mins";
        string = [NSString stringWithFormat:@"%i %@ ago",value,unit];
    }
    else if (epochTime < 60 * 60 * 24)
    {
        value = epochTime/(60 * 60);
        if(value == 1) unit = @"hour";
        else unit = @"hours";
        string = [NSString stringWithFormat:@"%i %@ ago",value,unit];
    }
    else if (epochTime < 60 * 60 * 24 * 30)
    {
        value = epochTime/(60 * 60 * 24);
        if(value == 1) unit = @"day";
        else unit = @"days";
        string = [NSString stringWithFormat:@"%i %@ ago",value,unit];
    }
    else if (epochTime < 60 * 60 * 24 * 30 * 12)
    {
        value = epochTime/(60 * 60 * 24 * 30);
        if(value == 1) unit = @"month";
        else unit = @"months";
        string = [NSString stringWithFormat:@"%i %@ ago",value,unit];
    }
    else
    {
        int epochYear = epochTime / (60 * 60 * 24 * 30 * 12);
        int monthSecond = (int)epochTime % epochYear;
        int epochMonth = monthSecond / (60 * 60 * 24 * 30 * 12);
//        NSString * yearString = ;
//        NSString * monthString = @"months";
        NSString * yearString = epochYear== 1?@"year":@"years";
        NSString * monthString = epochMonth== 1?@"month":@"months";
        
        if(epochMonth > 0)
        {
            
            string = [NSString stringWithFormat:@"%i %@ %i %@ ago",epochYear,yearString,epochMonth,monthString];
        }
        else
            string = [NSString stringWithFormat:@"%i %@ ago",epochYear,yearString];
        
    }
    return string;
}



+(NSString *)getTheTimeDiffrenceStringForComment:(NSString *)createdAt
{
    NSString * string = nil;
    int value = 0;
    NSString * unit = @"";
    
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSDate * parsedDate = [formatter dateFromString:createdAt];
    
    //secondsFromGMTForDate
    int epochTime = (int)[[NSDate date] timeIntervalSinceDate:parsedDate];
    
    if(epochTime < 60)
    {
        string = [NSString stringWithFormat:@"%is",epochTime];
    }
    else if (epochTime < 60*60)
    {
        value = epochTime/60;
        string = [NSString stringWithFormat:@"%i m",value];
    }
    else if (epochTime < 60 * 60 * 24)
    {
        value = epochTime/(60 * 60);
        string = [NSString stringWithFormat:@"%i h",value];
    }
    else if (epochTime < 60 * 60 * 24 * 30)
    {
        value = epochTime/(60 * 60 * 24);
        string = [NSString stringWithFormat:@"%i d",value];
    }
    else if (epochTime < 60 * 60 * 24 * 30 * 12)
    {
        value = epochTime/(60 * 60 * 24 * 30);
        if(value == 1) unit = @"month";
        else unit = @"months";
        string = [NSString stringWithFormat:@"%i %@",value,unit];
    }
    else
    {
        int epochYear = epochTime / (60 * 60 * 24 * 30 * 12);
        int monthSecond = (int)epochTime % epochYear;
        int epochMonth = monthSecond / (60 * 60 * 24 * 30 * 12);
        //        NSString * yearString = ;
        //        NSString * monthString = @"months";
        NSString * yearString = epochYear== 1?@"year":@"years";
        NSString * monthString = epochMonth== 1?@"month":@"months";
        
        if(epochMonth > 0)
        {
            
            string = [NSString stringWithFormat:@"%i %@ %i %@",epochYear,yearString,epochMonth,monthString];
        }
        else
            string = [NSString stringWithFormat:@"%i %@",epochYear,yearString];
        
    }
    return string;
}


+(NSDate *)dateAfterYear:(int)y month:(int)m day:(int)d fromDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:y];
    [offsetComponents setMonth:m];
    [offsetComponents setDay:d];
    NSDate *calculatedDate = [gregorian dateByAddingComponents:offsetComponents toDate:date options:0];
    return calculatedDate;
    
    
}
+(NSDate *)dateAfterMins:(int)min fromDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMinute:min];
    NSDate *calculatedDate = [gregorian dateByAddingComponents:offsetComponents toDate:date options:0];
    return calculatedDate;
    
    
}

+(NSDate *)dateAfterHours:(int)min fromDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:min];
    NSDate *calculatedDate = [gregorian dateByAddingComponents:offsetComponents toDate:date options:0];
    return calculatedDate;
    
    
}


+ (NSDate *) dateByAddingDays:(int)days {
    
    NSDate *calculatedDate;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    
    NSCalendar *gregorian = [[NSCalendar alloc]    initWithCalendarIdentifier:NSGregorianCalendar];
    calculatedDate= [gregorian dateByAddingComponents:components toDate:[NSDate date] options:0];
    
    return calculatedDate;
    
}



+(NSString *)getFormattedDateString:(NSDate *)date
{
     NSDateFormatter *formatter = nil;
     formatter = [[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"yyyy-MM-dd"];
     NSString *string = [formatter stringFromDate:date];formatter = nil;
     return string;
}

+(NSString *)getFormattedTimeString:(NSDate *)date
{
    NSDateFormatter *formatter = nil;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *string = [formatter stringFromDate:date];formatter = nil;
    return string;
}


+(NSString *)getStringFromDate:(NSDate *)date inFormat:(NSString *)formString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formString];
    NSString *string = [formatter stringFromDate:date];
    return string;
}


+(NSString *)getMonth:(NSDate *)date
{
    NSDateFormatter *formatter = nil;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    NSString *string = [formatter stringFromDate:date];formatter = nil;
    return string;
}
+(NSString *)getYear:(NSDate *)date
{
    NSDateFormatter *formatter = nil;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString *string = [formatter stringFromDate:date];formatter = nil;
    return string;
}
+(NSString *)getDay:(NSDate *)date
{
    NSDateFormatter *formatter = nil;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd"];
    NSString *string = [formatter stringFromDate:date];formatter = nil;
    return string;

}

+(NSString *)getHour:(NSDate *)date
{
    NSDateFormatter *formatter = nil;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"H"];
    NSString *string = [formatter stringFromDate:date];formatter = nil;
    return string;
}

+(NSString *)getMinuts:(NSDate *)date
{
    NSDateFormatter *formatter = nil;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"mm"];
    NSString *string = [formatter stringFromDate:date];formatter = nil;
    return string;
}


@end








@implementation ECSDevice

+(BOOL)isiOS8
{
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
        return YES;
    else return NO;
}

+(BOOL)isiOS7
{
  if([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
      return YES;
  else return NO;
}
+(BOOL)isiOS6
{
    if([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        return YES;
    else return NO;
}
+(BOOL)isiOS5
{
    if([[UIDevice currentDevice].systemVersion floatValue] >= 5.0)
        return YES;
    else return NO;
}
+(float)iOSVersion
{
    return [[UIDevice currentDevice].systemVersion floatValue];
}
@end

@implementation JKSColor

+(UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha{
    
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}



@end

@implementation InternetConnectionStatus : NSObject 

//+ (BOOL) isInternetConnectionAvailable
//{
//    Reachability *internet = [Reachability reachabilityWithHostName: @"www.google.com"];
//    NetworkStatus netStatus = [internet currentReachabilityStatus];
//    bool netConnection = false;
//    switch (netStatus)
//    {
//            case NotReachable:
//        {
//            NSLog(@"Access Not Available");
//            netConnection = false;
//            break;
//        }
//            case ReachableViaWWAN:
//        {
//            netConnection = true;
//            break;
//        }
//            case ReachableViaWiFi:
//        {
//            netConnection = true;
//            break;
//        }
//    }
//    return netConnection;
//}

@end







