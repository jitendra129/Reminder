//
//  UIExtensions.h
//  SecureCredentials
//
//  Created by Jitendra Maurya on 01/10/13.
//  Copyright (c) 2013 SecureCredentials. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "SDWebImageManager.h"



@interface UIExtensions : NSObject

@property (nonatomic, retain) UIViewController *parentController;
@property (nonatomic, retain) UIActivityIndicatorView *activity;
+(UIExtensions *)sharedInstance;


@end



@interface UIButton  (Extensions)


-(void)makeCircular;
-(void)setButtonImage:(NSString *)imageName;
-(void)setButtonBackgroudImage:(NSString *)imageName;
-(void)setButtonTitle:(NSString *)title;
-(void)setAttributedButtonTitle:(NSAttributedString *)title;
-(void)setButtonTitleColor:(UIColor *)color;
-(void)setButtonBackgroundColor:(UIColor *)color;



@end



@interface UITextField  (Extensions)

-(void)setNumberKeybordWithDone;
- (void)setNumberKeybord;
- (void)setNumberKeybord:(UIViewController *)controller withLeftTitle:(NSString *)left andRightTitle:(NSString *)right;
- (void)setNumberKeybord:(UIViewController *)controller;
- (BOOL)isBlank;
- (void)setPadding;
- (void)setLeftPadding;
- (void)setRightPadding;
- (void)changeTextAlignment;
- (void)setGrayBorder;

- (BOOL)isValidEmail;
- (void)setDarkGrayColor;
- (void)setPlaceHolderColor:(UIColor *)color;
-(void)setFont_hint_input_text;
-(void)setFont_input_text;



@end


@interface UITextView  (Extensions)

- (void)setNumberKeybord;
- (void)setNumberKeybordWithSend;

@end


@interface UIPickerView  (Extensions) 

-(void)setUpPickerViewWithDoneButton;
-(void)doneWithNumberPad;

@end


//@interface UIDatePicker  (Extensions)
//
//-(void)setUpPickerViewWithDoneButton;
//-(void)doneWithNumberPad;
//
//@end



@interface UILabel  (Extensions)

// These name conventions are based on Erika's HTML

- (void)changeTextAlignment;

- (void)setAttributedLabelHeightFit:(NSAttributedString *)string;
- (void)setAttributedLabelToWidthFit:(NSAttributedString *)string;

- (void)setLabelHeightFit:(NSString *)string;
- (void)setLabelToWidthFit:(NSString *)string;
- (float)getLabelHeightFit:(NSString *)string;
- (float)getLabelWidthFit:(NSString *)string;

-(void)setFontKalra:(float)size;
-(void)setFontHelevetica:(float)size;
-(void)setFontHeleveticaBold:(float)size;
-(void)setFontHeleveticaNueue:(float)size;
-(void)setFontHeleveticaNueueBold:(float)size;
-(void)setFontHeleveticaNueueMedium:(float)size;

@end




@interface UIColor (Extensions)
+ (UIColor *)colorWithHexString:(NSString *)string;
+ (UIColor *)colorWithR:(int)r G:(int)g B:(int)b;

@end

@interface UIView (Extensions)
//- (void)setViewColorSoftRedColor;

@end

@interface UIImageView (Extensions)<UIImagePickerControllerDelegate, UINavigationControllerDelegate>


-(void) loadFromPhotoLibrary:(UIViewController *)controller;
-(void) loadFromCamera:(UIViewController *)controller;
-(void) loadFromPhotoAlbum:(UIViewController *)controller;

-(void) loadAndSaveFromPhotoLibrary:(UIViewController *)controller;
-(void) loadAndSaveFromCamera:(UIViewController *)controller;
-(void) loadAndSaveFromPhotoAlbum:(UIViewController *)controller;

- (void)makeCircular;
- (void)ecs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)ecs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock;


@end


@interface UIImage (Extensions)
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (instancetype)imageWithName:(NSString *)name;
@end



@interface UITableView (Extensions)

-(void)scrollToTop;
-(void)scrollToBottom;
-(void)scrollToLastIndexPath;
-(void)scrollToRow:(int)row;

@end












