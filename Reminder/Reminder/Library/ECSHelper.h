//
//  ECSHelper.h
//  TME
//
//  Created by Jitendra Maurya on 03/12/13.
//  Copyright (c) 2013 Jitendra Maurya. All rights reserved.
//




#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UserObject;





@interface ECSHelper : NSObject
+(void)setRootViewController:(UIViewController *)controller withLeftController:(UIViewController *)leftController;

@end


@interface ECSAlert : NSObject

+(void)showAlert:(NSString *)message;
+(void)showApiError:(NSDictionary *)rootDictionary respString:(NSString *)respString error:(NSError *)error;
+(void)showAlert:(NSString *)message withDelegate:(UIViewController *)ctrl andTag:(int)tag;

@end


@interface ECSToast : NSObject

+(void)showToast:(NSString *)message view:(UIView *)view;
@end




@interface ECSUserDefault: NSObject

+(BOOL)getBoolFromUserDefaultForKey:(NSString *)string;
+(NSInteger)getIntFromUserDefaultForKey:(NSString *)string;
+(NSString *)getStringFromUserDefaultForKey:(NSString *)string;
+(float)getFloatFromUserDefaultForKey:(NSString *)string;
+(id)getObjectFromUserDefaultForKey:(NSString *)string;


+(void)saveBool:(BOOL)val ToUserDefaultForKey:(NSString *)string;
+(void)saveInt:(int)val ToUserDefaultForKey:(NSString *)string;
+(void)saveString:(NSString *)val ToUserDefaultForKey:(NSString *)string;
+(void)saveFloat :(float)val ToUserDefaultForKey:(NSString *)string;
+(void)saveObject:(id)val ToUserDefaultForKey:(NSString *)string;

+(void)RemoveObjectFromUserDefaultForKey:(NSString *)string;

@end



@interface ECSDate : NSObject

+(NSDate *)dateAfterYear:(int)y month:(int)m day:(int)d fromDate:(NSDate *)date;
+ (NSDate *) dateByAddingDays:(int)days;
+(NSString *)getFormattedDateString:(NSDate *)date;
+(NSString *)getFormattedTimeString:(NSDate *)date;
+(NSString *)getStringFromDate:(NSDate *)date inFormat:(NSString *)formString;
+(NSString *)getFormattedDateString:(NSString *)string inFormat:(NSString *)formString;
+(NSString *)getFormattedTimeString:(NSString *)string inFormat:(NSString *)formString;
+(NSString *)getTheTimeDiffrenceString:(NSString *)createdAt;
+(NSString *)getTheTimeDiffrenceStringForComment:(NSString *)createdAt;
+(NSString *)getFormattedScrapDateString:(NSString *)string inFormat:(NSString *)formString;
+(NSDate *)dateAfterHours:(int)min fromDate:(NSDate *)date;
+(NSDate *)dateAfterMins:(int)min fromDate:(NSDate *)date;


+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
+(NSString *)getMonth:(NSDate *)date;
+(NSString *)getYear:(NSDate *)date;
+(NSString *)getDay:(NSDate *)date;
+(NSString *)getHour:(NSDate *)date;
+(NSString *)getMinuts:(NSDate *)date;


@end





@interface ECSDevice : NSObject

+(BOOL)isiOS8;
+(BOOL)isiOS7;
+(BOOL)isiOS6;
+(BOOL)isiOS5;
+(float)iOSVersion;
@end


@interface JKSColor : NSObject
+(UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;


@end
@interface InternetConnectionStatus : NSObject
+ (BOOL) isInternetConnectionAvailable;
@end




