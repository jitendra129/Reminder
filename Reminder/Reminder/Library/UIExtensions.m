//
//  UIExtensions.m
//  SecureCredentials
//
//  Created by Jitendra Maurya on 01/10/13.
//  Copyright (c) 2013 SecureCredentials. All rights reserved.
//

#import "UIExtensions.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>


BOOL isSave=NO;
UIExtensions *extensionGlobal;


@implementation UIExtensions

@synthesize parentController;
@synthesize activity;

+(UIExtensions *)sharedInstance
{
    if(!extensionGlobal) extensionGlobal=[[UIExtensions alloc]init];
    return extensionGlobal;
}

@end

@implementation UIButton  (Extensions)



-(void)makeCircular
{
    self.layer.cornerRadius = self.frame.size.width/2;
    [self.layer setMasksToBounds:YES];
    
}


-(void)setButtonImage:(NSString *)imageName
{
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

}

-(void)setAttributedButtonTitle:(NSAttributedString *)title
{
    [self setAttributedTitle: title forState:UIControlStateNormal];
}


-(void)setButtonTitle:(NSString *)title
{
   [self setTitle:title forState:UIControlStateNormal];
   [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
}

-(void)setButtonTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

-(void)setButtonBackgroudImage:(NSString *)imageName
{
  [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

-(void)setButtonBackgroundColor:(UIColor *)color
{
    [self setBackgroundColor:color];
    
}

@end




@implementation UITextField  (Extensions)

- (void)setPlaceHolderColor:(UIColor *)color
{
    [self setValue:color
                    forKeyPath:@"_placeholderLabel.textColor"];
}
-(void)setFontHeleveticaNueueBold:(float)size
{
    [self setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:size]];
}

-(void)setFontHeleveticaNueue:(float)size
{
    [self setFont:[UIFont fontWithName:@"HelveticaNeue" size:size]];
}

-(void)setFont_hint_input_text
{
    
   // [self setTextColor:[UIColor colorWithR:102 G:102 B:102]];
    [self setTextColor:[UIColor whiteColor]];
    [self setFontHeleveticaNueueBold:17];
    
    
}
-(void)setFont_input_text
{
   // [self setTextColor:[UIColor colorWithR:102 G:102 B:102]];
    [self setTextColor:[UIColor whiteColor]];
    [self setFontHeleveticaNueue:17];
}

-(void)setNumberKeybord:(UIViewController *)controller
{
    [UIExtensions sharedInstance].parentController= controller;
    [self setNumberKeybord];
}

-(void)setNumberKeybord:(UIViewController *)controller withLeftTitle:(NSString *)left andRightTitle:(NSString *)right
{
    [UIExtensions sharedInstance].parentController= controller;
    [self setNumberKeybordWithLeftTitle:left andRightTitle:right];
}
-(void)setNumberKeybordWithLeftTitle:(NSString *)left andRightTitle:(NSString *)right
{

    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    //toolBar.barStyle = UIBarStyleBlackOpaque;
    if([[UIDevice currentDevice].systemVersion floatValue]>= 7)
    {
        numberToolbar.barTintColor = [UIColor colorWithRed:224.0/255.0f green:225.0f/255.0f blue:226.0f/255.0f alpha:1.0];
    }
    else
        numberToolbar.tintColor = [UIColor colorWithRed:224.0/255.0f green:225.0f/255.0f blue:226.0f/255.0f alpha:1.0];
    
    
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:left style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:right style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    self.inputAccessoryView = numberToolbar;

}
-(void)setNumberKeybordWithDone
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    //toolBar.barStyle = UIBarStyleBlackOpaque;
    if([[UIDevice currentDevice].systemVersion floatValue]>= 7)
    {
        numberToolbar.barTintColor = [UIColor colorWithRed:224.0/255.0f green:225.0f/255.0f blue:226.0f/255.0f alpha:1.0];
    }
    else
        numberToolbar.tintColor = [UIColor colorWithRed:224.0/255.0f green:225.0f/255.0f blue:226.0f/255.0f alpha:1.0];
    
    
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    self.inputAccessoryView = numberToolbar;
}


- (void)enterWithNumberPad{
    [extensionGlobal.parentController performSelector:@selector(clickOnGo:) withObject:nil];
}

-(void)setNumberKeybord
{
    [self setNumberKeybord:nil withLeftTitle:@"Cancel" andRightTitle:@"Done"];
    
}

-(void)cancelNumberPad{

    
    if([[UIExtensions sharedInstance].parentController canPerformAction:@selector(dismissKeyboardDiscardingValue:) withSender:self])
    {
        [[UIExtensions sharedInstance].parentController performSelector:@selector(dismissKeyboardDiscardingValue:) withObject:self];

    }
    else
    {
      [self resignFirstResponder];
      self.text = @"";
    }
}

-(void)doneWithNumberPad{
    
    //dismissKeyboardWithValue
    //dismissKeyboardDiscardingValue
    if([[UIExtensions sharedInstance].parentController canPerformAction:@selector(dismissKeyboardWithValue:) withSender:self])
    {
        [[UIExtensions sharedInstance].parentController performSelector:@selector(dismissKeyboardWithValue:) withObject:self];
    }
    else
    {

    [self resignFirstResponder];
    }
}
- (BOOL)isBlank
{
    if (self.text.length==0) return YES;
    return NO;
    
}


- (void)setPadding
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, self.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewRight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, self.frame.size.height)];
    self.rightView = paddingViewRight;
    self.rightViewMode = UITextFieldViewModeAlways;

}

- (void)setLeftPadding
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, self.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;

}


- (void)setRightPadding
{
    UIView *paddingViewRight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, self.frame.size.height)];
    self.rightView = paddingViewRight;
    self.rightViewMode = UITextFieldViewModeAlways;


}




-(BOOL)isValidEmail
{
    BOOL stricterFilter = YES;
    if(self.text.length == 0) return NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self.text];
}





-(void)changeTextAlignment
{
   if(self.textAlignment == NSTextAlignmentLeft)
      [self setTextAlignment:NSTextAlignmentRight];
   else [self setTextAlignment:NSTextAlignmentLeft];
}

-(void)setGrayBorder
{

    self.layer.borderColor = [[UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1.0f]CGColor];
    self.layer.borderWidth= 1.0f;
    
}
- (void)setDarkGrayColor
{
    [self setValue:[UIColor colorWithRed:123.0/255.0f green:123.0/255.0f blue:123.0/255.0f alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
   
}




@end


@implementation UIPickerView (Extensions)

-(void)setUpPickerViewWithDoneButton
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                          // [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    [self addSubview:numberToolbar];
    

}
-(void)doneWithNumberPad{
    
    [self.superview removeFromSuperview];
}
@end




//@implementation UIDatePicker (Extensions)
//
//-(void)setUpPickerViewWithDoneButton
//{
//    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
//    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
//    numberToolbar.items = [NSArray arrayWithObjects:
//                           // [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
//                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
//                           nil];
//    [numberToolbar sizeToFit];
//    [self addSubview:numberToolbar];
//    [numberToolbar release];
//    
//}
//-(void)doneWithNumberPad{
//    
//    [self.superview removeFromSuperview];
//}
//@end




@implementation UILabel (Extensions)

-(void)setHeaderFont
{
    [self setTextColor:[UIColor colorWithRed:255.0/255.0f green:255.0/255.0f blue:255.0/255.0f alpha:1.0f]];
    [self setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0f]];
}



-(void)setFont_page_title
{
    [self setTextColor:[UIColor colorWithRed:249.0/255.0f green:111.0/255.0f blue:45.0/255.0f alpha:1.0]];
    [self setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]];
}

-(void)setFontHelevetica:(float)size
{
    [self setFont:[UIFont fontWithName:@"Helvetica" size:size]];
}
    
-(void)setFontHeleveticaBold:(float)size
{
    [self setFont:[UIFont fontWithName:@"Helvetica-Bold" size:size]];
}

-(void)setFontHeleveticaNueue:(float)size
{
   [self setFont:[UIFont fontWithName:@"HelveticaNeue" size:size]];
}
-(void)setFontHeleveticaNueueBold:(float)size
{
    [self setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:size]];
}
-(void)setFontHeleveticaNueueMedium:(float)size
{
    [self setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:size]];
}



-(void)setOrangeColor
{

    //249, 111, 45     
    [self setTextColor:[UIColor colorWithRed:249.0/255.0f green:111.0/255.0f blue:45.0/255.0f alpha:1.0]];
}

-(void)setGray42Color
{
    
    [self setTextColor:[UIColor colorWithRed:66.0/255.0f green:66.0/255.0f blue:66.0/255.0f alpha:1.0]];
}

-(void)setHoldColor
{
    
    [self setTextColor:[UIColor colorWithRed:77.0/255.0f green:57.0/255.0f blue:172.0/255.0f alpha:1.0]];
}


-(void)setRedColor
{
   [self setTextColor:[UIColor colorWithRed:251.0/255.0f green:37.0/255.0f blue:26.0/255.0f alpha:1.0]];

}
-(void)setGreenColor
{
  [self setTextColor:[UIColor colorWithRed:19.0/255.0f green:179.0/255.0f blue:95.0/255.0f alpha:1.0]];
}

-(void)setDarkCaptionGreenColor
{
  [self setTextColor:[UIColor colorWithRed:12.0/255.0f green:101.0/255.0f blue:72.0/255.0f alpha:1.0]];
}

-(void)setWhiteColor
{
    [self setTextColor:[UIColor colorWithRed:255.0/255.0f green:255.0/255.0f blue:255.0/255.0f alpha:1.0]];
}


-(void)setFontSideMenuCell
{
    [self setTextColor:[UIColor colorWithRed:66.0/255.0f green:66.0/255.0f blue:66.0/255.0f alpha:1.0]];
    [self setFont:[UIFont fontWithName:@"Helvetica" size:15.0f]];

}
-(void)setFontLeftLabel
{
    [self setFont:[UIFont fontWithName:@"Helvetica" size:16.0f]];
    
}

-(void)setBlueLastColor
{
  [self setTextColor:[UIColor colorWithRed:1.0/255.0f green:120.0/255.0f blue:233.0/255.0f alpha:1.0]];
}


-(void)setLightGreyColor
{
    [self setTextColor:[UIColor colorWithRed:174.0/255.0f green:180.0/255.0f blue:179.0/255.0f alpha:1.0]];
}

-(void)setDarkGreenColor
{
    [self setTextColor:[UIColor colorWithRed:36.0/255.0f green:67.0/255.0f blue:69.0/255.0f alpha:1.0]];
}

-(void)setLightGreenColor{
 
    [self setTextColor:[UIColor colorWithRed:157.0/255.0f green:158.0/255.0f blue:152.0/255.0f alpha:1.0]];
}

-(void)setBlackColor{
    
    [self setTextColor:[UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0]];
    [self setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0f]];
    
}

-(void)SetFontCategory{
    
    [self setTextColor:[UIColor colorWithRed:153.0/255.0f green:153.0/255.0f blue:153.0/255.0f alpha:1.0] ];
    [self setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]];
    
}

// Start TY specific methods

//-(void)setFont_hint_input_text
//{
//
//    [self setTextColor:[UIColor colorWithR:102 G:102 B:102]];
//    [self setFontHeleveticaNueueBold:17];
//
//
//}
//-(void)setFont_input_text
//{
//    [self setTextColor:[UIColor colorWithR:102 G:102 B:102]];
//    [self setFontHeleveticaNueue:17];
//}
//-(void)setFont_header_level_1
//{
//    [self setTextColor:[UIColor colorWithR:238 G:105 B:96]];
//    [self setFontHeleveticaNueueBold:16];
//}
//
//-(void)setFont_header_level_2
//{
//    [self setTextColor:[UIColor colorWithR:51 G:51 B:51]];
//    [self setFontHeleveticaNueueBold:14];
//
//}
//-(void)setFont_header_level_3
//{
//    [self setTextColor:[UIColor whiteColor]];
//    [self setFontHeleveticaNueueBold:13];
//}
//-(void)setFont_header_level_4
//{
//    [self setTextColor:[UIColor colorWithR:238 G:105 B:96]];
//    [self setFontHeleveticaNueueBold:12];
//}
//-(void)setFont_header_level_5
//{
//    [self setTextColor:[UIColor colorWithR:102 G:102 B:102]];
//    [self setFontHeleveticaNueueBold:11];
//}
//-(void)setFont_header_level_6
//{
//    [self setTextColor:[UIColor colorWithR:102 G:102 B:102]];
//    [self setFontHeleveticaNueueBold:10];
//
//}
//-(void)setFont_header_level_7
//{
//    [self setTextColor:[UIColor whiteColor]];
//    [self setFontHeleveticaNueueBold:10];
//
//}
//-(void)setFont_search_1
//{
//    [self setTextColor:[UIColor whiteColor]];
//    [self setFontHeleveticaNueueBold:15];
//
//}
//-(void)setFont_search_2
//{
//    [self setTextColor:[UIColor whiteColor]];
//    [self setFontHeleveticaNueue:14];
//
//}
//-(void)setFont_body_copy
//{
//    [self setTextColor:[UIColor colorWithR:51 G:51 B:51]];
//    [self setFontHeleveticaNueue:14];
//}
//-(void)setFont_timestamp
//{
//    [self setTextColor:[UIColor colorWithR:153 G:153 B:153]];
//    [self setFontHeleveticaNueue:11];
//
//}
//-(void)setFont_descriptor_0
//{
//    [self setTextColor:[UIColor colorWithR:51 G:51 B:51]];
//    [self setFontHeleveticaNueue:11];
//}
//-(void)setFont_descriptor_1
//{
//    [self setTextColor:[UIColor colorWithR:0 G:204 B:102]];
//    [self setFontHeleveticaNueue:11];
//}
//-(void)setFont_descriptor_2
//{
//    [self setTextColor:[UIColor colorWithR:0 G:53 B:102]];
//    [self setFontHeleveticaNueue:11];
//
//}
//-(void)setFont_descriptor_3
//{
//    [self setTextColor:[UIColor colorWithR:255 G:153 B:51]];
//    [self setFontHeleveticaNueue:11];
//}
//-(void)setFont_descriptor_4
//{
//    [self setTextColor:[UIColor colorWithR:51 G:51 B:51]];
//    [self setFontHeleveticaNueue:11];
//
//}
//-(void)setFont_field_label
//{
//    [self setTextColor:[UIColor colorWithR:102 G:102 B:102]];
//    [self setFontHeleveticaNueueBold:14];
//
//}
//-(void)setFont_circle_0
//{
//    [self setTextColor:[UIColor colorWithR:51 G:51 B:51]];
//    [self setFontHeleveticaNueueBold:14];
//}
//-(void)setFont_circle_1
//{
//    [self setTextColor:[UIColor colorWithR:0 G:204 B:102]];
//    [self setFontHeleveticaNueueBold:14];
//}
//-(void)setFont_circle_2
//{
//    [self setTextColor:[UIColor colorWithR:255 G:153 B:51]];
//    [self setFontHeleveticaNueueBold:14];
//}
//
//
//// End TY specific methods


-(void)changeTextAlignment
{
    if(self.textAlignment == NSTextAlignmentLeft)
        [self setTextAlignment:NSTextAlignmentRight];
    else [self setTextAlignment:NSTextAlignmentLeft];
}

- (void)setLabelHeightFit:(NSString *)string
{
    if([string isKindOfClass:[NSNull class]]) return;
    CGSize labelSize = [string sizeWithFont:self.font constrainedToSize:self.frame.size lineBreakMode:NSLineBreakByWordWrapping];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,labelSize.height + 2)];
}

- (void)setLabelToWidthFit:(NSString *)string
{
    if([string isKindOfClass:[NSNull class]]) return;
    CGSize labelSize = [string sizeWithFont:self.font constrainedToSize:self.frame.size lineBreakMode:NSLineBreakByWordWrapping];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, labelSize.width ,self.frame.size.height)];
}

- (float)getLabelHeightFit:(NSString *)string
{
    if([string isKindOfClass:[NSNull class]]) return 0;
    CGSize labelSize = [string sizeWithFont:self.font constrainedToSize:self.frame.size lineBreakMode:NSLineBreakByWordWrapping];
    return labelSize.height+2;


}
- (float)getLabelWidthFit:(NSString *)string
{
    if([string isKindOfClass:[NSNull class]]) return 0;
    CGSize labelSize = [string sizeWithFont:self.font constrainedToSize:self.frame.size lineBreakMode:NSLineBreakByWordWrapping];
    return labelSize.width;


}


- (void)setAttributedLabelHeightFit:(NSAttributedString *)string
{
    if([string isKindOfClass:[NSNull class]]) return;
    CGRect msgRect = [string boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,msgRect.size.height + 2)];
}

- (void)setAttributedLabelToWidthFit:(NSAttributedString *)string
{
    if([string isKindOfClass:[NSNull class]]) return;
    CGRect msgRect = [string boundingRectWithSize:self.frame.size options: NSStringDrawingUsesFontLeading context:nil];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, msgRect.size.width,self.frame.size.height)];
}




@end


@implementation UITextView  (Extensions)

-(void)setNumberKeybord
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.inputAccessoryView = numberToolbar;
    
}

-(void)cancelNumberPad{
    [self resignFirstResponder];
    self.text = @"";
}

-(void)doneWithNumberPad{
    
    [self resignFirstResponder];
}


-(void)setNumberKeybordWithSend
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(SendWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.inputAccessoryView = numberToolbar;
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
}


-(void)SendWithNumberPad{
    
    
    [extensionGlobal.parentController performSelector:@selector(clickOnSend:) withObject:nil];
    [self resignFirstResponder];
}

@end




@implementation UIColor (Extensions)

+ (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
        
        if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)colorWithR:(int)r G:(int)g B:(int)b
{
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}






@end





@implementation UIView (Extensions)

//- (void)setViewColorSoftRedColor
//{
//    [self setBackgroundColor:[UIColor colorWithRed:242.0/255.0f green:181.0/255.0f blue:28.0/255.0f alpha:1.0f]];
//    
//    
//}

@end




@implementation UIImageView (Extensions)



-(void) loadFromPhotoLibrary:(UIViewController *)controller
{
    [self initilizeImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary withController:controller];
    
}

-(void) loadFromCamera:(UIViewController *)controller{
    [self initilizeImagePickerController:UIImagePickerControllerSourceTypeCamera withController:controller];
    
}
-(void)loadFromPhotoAlbum:(UIViewController *)controller
{
    [self initilizeImagePickerController:UIImagePickerControllerSourceTypeSavedPhotosAlbum withController:controller];
}

-(void) loadAndSaveFromPhotoLibrary:(UIViewController *)controller
{
    isSave=YES;
    [self loadFromPhotoLibrary:controller];
    
}
-(void) loadAndSaveFromCamera:(UIViewController *)controller
{
    
    isSave=YES;
    [self loadFromCamera:controller];
    
}
-(void) loadAndSaveFromPhotoAlbum:(UIViewController *)controller
{
    
    isSave=YES;
    [self loadFromPhotoAlbum:controller];
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    if(isSave) UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
    [[UIExtensions sharedInstance].parentController dismissViewControllerAnimated:YES completion:nil];
}


-(void)initilizeImagePickerController:(UIImagePickerControllerSourceType)srctyp withController:(UIViewController *)controller
{
    
    [UIExtensions sharedInstance].parentController=controller;
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = srctyp;
    [controller presentViewController:picker animated:YES completion:nil];
}


-(void)makeCircular
{
    self.layer.cornerRadius = self.frame.size.width/2;
    [self.layer setMasksToBounds:YES];

}

-(void)ecs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self sd_setImageWithURL:url placeholderImage:placeholder];
}


- (void)ecs_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock {
    
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}





@end

@implementation UIImage (Extensions)


+(instancetype)imageWithName:(NSString *)name
{

    NSArray * nameComponent = [name componentsSeparatedByString:@"."];
    NSString * imageType = [nameComponent lastObject];
    NSString * imageName = [name stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",imageType] withString:@""];
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:imageType]];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end



@implementation UITableView (Extensions)

-(void)scrollToTop
{
   self.contentOffset = CGPointMake(0, 0 - self.contentInset.top);
}

-(void)scrollToBottom
{
    self.contentOffset = CGPointMake(0, self.contentSize.height - self.frame.size.height);
}

-(void)scrollToRow:(int)row
{
    NSInteger lastSectionIndex = 0;
    NSInteger lastRowIndex = row;
    [self scrollToRowAtIndexPath: [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];

}


-(void)scrollToLastIndexPath
{
    NSIndexPath *lastIndexPath = [self lastIndexPath];
    if(lastIndexPath != nil)
    [self scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(NSIndexPath *)lastIndexPath
{
    if([self numberOfSections] > 0)
    {
     NSInteger lastSectionIndex = [self numberOfSections]-1;
     NSInteger lastRowIndex = 0;
        if([self numberOfRowsInSection:lastSectionIndex]>0)
        {
          lastRowIndex = [self numberOfRowsInSection:lastSectionIndex]-1;
        }
        else return nil;
        return [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
    }
    else return nil;
   
}






@end




