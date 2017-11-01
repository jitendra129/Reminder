//
//  ViewAllPush.m
//  Reminder
//
//  Created by mac on 06/07/1939 Saka.
//  Copyright © 1939 Saka CSI. All rights reserved.
//

#import "ViewAllPush.h"
#import "ViewPushTableCell.h"
#import "MenuItemObject.h"
#import "AddReminderVC.h"
#import "ECSHelper.h"
@interface ViewAllPush ()<addReminderDelegate,updateBgDelegate>
@property(strong,nonatomic)IBOutlet UITableView *tblPushList;
- (void)deleteRemainderData: (NSString *)Key;
- (void)UpdateRemainderData: (NSString *)Key;

- (void)getRemainderData: (MenuItemObject *)selectedData;

@end

@implementation ViewAllPush

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        return self.arrayPushList.count;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        return 150;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *CellIdentifier = @"ViewPushTableCell";
        
        
        [self.tblPushList registerNib:[UINib nibWithNibName:@"ViewPushTableCell" bundle:nil]forCellReuseIdentifier:@"ViewPushTableCell"];
        ViewPushTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.tblPushList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //cell.backgroundColor = [UIColor clearColor];
        MenuItemObject *obj=[self.arrayPushList objectAtIndex:indexPath.row];
        cell.lblTitle.text=obj.title;
        cell.lblDate.text=obj.date;
        cell.lblTime.text=obj.time;
        cell.lblMsg.text=obj.msg;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *stringDate = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"Date from%@",obj.dateWithFormat);
    NSDate *date = [dateFormatter dateFromString:obj.dateWithFormat];
    NSDate *currentDate=[dateFormatter dateFromString:stringDate];
    
    NSTimeInterval timeDifference = [currentDate timeIntervalSinceDate:date];
    if (timeDifference>0) {
        cell.lblTitle.textColor=[UIColor grayColor];
        cell.lblTime.textColor=[UIColor grayColor];
        cell.lblDate.textColor=[UIColor grayColor];
        cell.lblMsg.textColor=[UIColor grayColor];
        
    }else{
        cell.lblTitle.textColor=[UIColor whiteColor];
        cell.lblTime.textColor=[UIColor whiteColor];
        cell.lblDate.textColor=[UIColor whiteColor];
        cell.lblMsg.textColor=[UIColor whiteColor];
    }
    

    
        NSLog(@"cell Reminder Id=%@",obj.remId);
    
        return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
        MenuItemObject *obj=[self.arrayPushList objectAtIndex:indexPath.row];
        
        AddReminderVC *nav=[[AddReminderVC alloc]initWithNibName:@"AddReminderVC" bundle:nil];
        nav.SelectedIndex=[NSString stringWithFormat:@"%@",obj.remId];
        nav.delegate=self;
        [self.navigationController pushViewController:nav animated:YES];
    
}

- (void)UpdateRemainderData: (NSString *)Key
{
    self.arrayPushList=[[NSMutableArray alloc]init];
    for (int i=0; i<50; i++) {
        NSString *key=[NSString stringWithFormat:@"Reminder%d",i];
        NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
        if (data.length) {
            MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.arrayPushList addObject:obj];
        }
    }
    
    [self.tblPushList reloadData];
}

- (void)deleteRemainderData: (NSString *)Key{
    self.arrayPushList=[[NSMutableArray alloc]init];
    for (int i=0; i<100; i++) {
        NSString *key=[NSString stringWithFormat:@"Reminder%d",i];
        NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
        if (data.length) {
            MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.arrayPushList addObject:obj];
            
        }
    }
    
//    int numElements = (int) self.arrayPushList.count;
//    [ECSUserDefault saveInt:numElements ToUserDefaultForKey:@"Count"];
    [self.tblPushList reloadData];
}

-(IBAction)onClickClose:(id)sender{
    [self.delegate getUpdateddata];
    [self.navigationController popViewControllerAnimated:YES];
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
