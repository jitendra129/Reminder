//
//  JKHomeVC.h
//  CarGates
//
//  Created by ASK ONLINE  on 17/06/17.
//  Copyright © 2017 ASK ONLINE . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectLocDelegate
- (void)locData: (NSString *)selectedLoc;
@end
@interface JKHomeVC : UIViewController
-(void)openSideMenuButtonClicked:(UIButton *)sender;
@property (assign) id<selectLocDelegate> delegate;
- (void)locData: (NSString *)selectedLoc;
@end
