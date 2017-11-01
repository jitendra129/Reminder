//
//  AddReminderVC.m
//  Reminder
//
//  Created by mac on 31/06/1939 Saka.
//  Copyright © 1939 Saka CSI. All rights reserved.
//

#import "AddReminderVC.h"
#import "UIExtensions.h"
#import "ECSHelper.h"
#import "MenuItemObject.h"
@interface AddReminderVC ()
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerSetTime;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerSetDate;

@property(weak,nonatomic)IBOutlet UITextField *txtTitle;
@property(weak,nonatomic)IBOutlet UITextView *txtmessage;
@property(weak,nonatomic)IBOutlet UITextField *txtDate;
@property(weak,nonatomic)IBOutlet UITextField *txtTime;
@property(strong,nonatomic)NSString *txtDateWithTime;
@property(weak,nonatomic)IBOutlet UILabel *lblDate;
@property(weak,nonatomic)IBOutlet UILabel *lblTime;
@property(weak,nonatomic)IBOutlet UIButton *btnDelete;
@property(weak,nonatomic)IBOutlet UIButton *btnSave;
@property(weak,nonatomic)IBOutlet UIButton *btnCancel;


@property(weak,nonatomic)IBOutlet UILabel *lblAddReminder;

@property(weak,nonatomic)IBOutlet UIView *view1;
@property(weak,nonatomic)IBOutlet UIView *view2;
@property(weak,nonatomic)IBOutlet UIView *view3;
@end

@implementation AddReminderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *key=[NSString stringWithFormat:@"Reminder%@",self.SelectedIndex];
    NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
    
    self.btnSave.layer.cornerRadius = 5.0f;
    //self.viewUserName.layer.masksToBounds = YES;
    self.btnSave.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:190/255.0 blue:0/255.0 alpha:1]CGColor ];
    self.btnSave.layer.borderWidth = 2.0f;
    
    self.btnCancel.layer.cornerRadius = 5.0f;
    //self.viewUserName.layer.masksToBounds = YES;
    self.btnCancel.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:190/255.0 blue:0/255.0 alpha:1]CGColor ];
    self.btnCancel.layer.borderWidth = 2.0f;
    
    if (data.length) {
        MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        self.btnDelete.hidden=NO;
        self.txtTitle.text=obj.title;
       self.txtmessage.text= obj.msg;
        self.lblTime.text=obj.time;
        self.lblDate.text=obj.date;
         self.lblAddReminder.text=@"UPDATE REMINDER";
        [self.btnSave setTitle:@"Update" forState:UIControlStateNormal];

        //[self.arrReminderList addObject:obj];
    }else{
        //[self clickToSetDate:nil];
        [self clickToSetTime:nil];
        self.lblAddReminder.text=@"ADD REMINDER";
        self.btnDelete.hidden=YES;
        [self.btnSave setTitle:@"Add" forState:UIControlStateNormal];

    }

    self.view1.layer.cornerRadius = 5.0f;
    self.view1.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:190/255.0 blue:0/255.0 alpha:1]CGColor ];
    
    self.view2.layer.cornerRadius = 5.0f;
    self.view2.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:190/255.0 blue:0/255.0 alpha:1]CGColor ];
    
    self.view3.layer.cornerRadius = 5.0f;
    self.view3.layer.borderColor = [[UIColor colorWithRed:255/255.0 green:190/255.0 blue:0/255.0 alpha:1]CGColor ];
    
    [self.txtDate setNumberKeybord:self withLeftTitle:@"" andRightTitle:@"Done"];
    [self.txtTime setNumberKeybord:self withLeftTitle:@"" andRightTitle:@"Done"];
    
    self.pickerSetDate.date = [ECSDate dateAfterHours:0 fromDate:[NSDate date]];
    self.pickerSetTime.date = [ECSDate dateAfterMins:0 fromDate:self.pickerSetDate.date];
   // self.txtmessage.
    
    [self.txtTime setInputView:self.pickerSetTime];
    [self.txtDate setInputView:self.pickerSetDate];
   
    // Do any additional setup after loading the view from its nib.
}


-(IBAction)onClickDelete:(id)sender{
    NSString *key=[NSString stringWithFormat:@"Reminder%@",self.SelectedIndex];

    [ECSUserDefault RemoveObjectFromUserDefaultForKey:key];
    [self.delegate deleteRemainderData:key];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([self.txtDate isFirstResponder]||[self.txtTime isFirstResponder]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
        }];
    }
    return [super canPerformAction:action withSender:sender];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}




- (IBAction)clickToAdd:(id)sender {
     NSInteger nextR=[ECSUserDefault getIntFromUserDefaultForKey:@"Count"];
    if (self.SelectedIndex) {
        NSInteger myInt = [self.SelectedIndex intValue];

        nextR=myInt;
        
        MenuItemObject *object=[MenuItemObject alloc];
        object.title=self.txtTitle.text;
        object.msg=self.txtmessage.text;
        object.time=self.lblTime.text;
        object.date=self.lblDate.text;
        object.dateWithFormat=self.txtDateWithTime;
        object.remId=[NSString stringWithFormat:@"%ld",(long)nextR];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:object];
        
        NSString *strForKey=[NSString stringWithFormat:@"Reminder%ld",(long)nextR];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:strForKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.delegate UpdateRemainderData:strForKey];
    }else{
        MenuItemObject *object=[MenuItemObject alloc];
        object.title=self.txtTitle.text;
        object.msg=self.txtmessage.text;
        object.time=self.lblTime.text;
        object.date=self.lblDate.text;
        object.dateWithFormat=self.txtDateWithTime;
        
        NSLog(@"dateWithTime%@",self.txtDateWithTime);
        object.remId=[NSString stringWithFormat:@"%ld",(long)nextR];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:object];
        NSString *strForKey=[NSString stringWithFormat:@"Reminder%ld",(long)nextR];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:strForKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
       [self.delegate getRemainderData:object];
        }
   
       [self.navigationController popViewControllerAnimated:YES];
    

}

- (IBAction)clickToSetTime:(id)sender {
    
    [self.lblTime setText:[NSString stringWithFormat:@"%@",[ECSDate getStringFromDate:self.pickerSetTime.date inFormat:@"h:mm:ss a"]]];
    
    [self.lblDate setText:[NSString stringWithFormat:@"%@",[ECSDate getStringFromDate:self.pickerSetTime.date inFormat:@"yyyy-MM-dd"]]];
    
    self.txtDateWithTime=[NSString stringWithFormat:@"%@",[ECSDate getStringFromDate:self.pickerSetTime.date inFormat:@"yyyy-MM-dd HH:mm:ss"]];
//    NSLog(@"date=%@",[NSDate date]);
//    NSLog(@"txtDateWithTime=%@",self.txtDateWithTime);
    
}



- (IBAction)clickToCancel:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
   

    
}

-(IBAction)onClickBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // NSLog(@"REPlace %@ %d",text,range.location);
    if([self.txtmessage.text isEqualToString:@"Message for your notification"])
    {
        self.txtmessage.text=@"";
    }
    else if(range.location==0)
    {
        // self.txtmessage.text=@"Message for your notificationn";
       // placeholderlbl.hidden = NO;
    }
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
