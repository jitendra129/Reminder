//
//  ViewPushTableCell.h
//  Reminder
//
//  Created by mac on 06/07/1939 Saka.
//  Copyright © 1939 Saka CSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewPushTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@end
