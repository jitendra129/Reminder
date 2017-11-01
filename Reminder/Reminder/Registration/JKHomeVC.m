//
//  JKHomeVC.m
//  CarGates
//
//  Created by ASK ONLINE  on 17/06/17.
//  Copyright © 2017 ASK ONLINE . All rights reserved.
//

#import "JKHomeVC.h"
#import "MenuItemObject.h"
#import "ReminderTableCell.h"
#import "AddReminderVC.h"
#import "ECSHelper.h"
#import "HMSegmentedControl.h"
#import "AddToDoVC.h"
#import "ViewAllPush.h"

@interface JKHomeVC ()<addReminderDelegate,addToDoDelegate,updateBgDelegate>
{
    BOOL isSameLocON;
    BOOL isDriverAgeBtnON;
    BOOL isMapOn;
    NSArray *itemArray;

}
- (void)deleteRemainderData: (NSString *)Key;
- (void)UpdateRemainderData: (NSString *)Key;
- (void)getRemainderData: (MenuItemObject *)selectedData;
-(void)getUpdateddata;

//TODO

- (void)getToDoData: (MenuItemObject *)selectedData;
- (void)deleteToDoData: (NSString *)Key;
- (void)UpdateToDoData: (NSString *)Key;
@property (strong, nonatomic) NSMutableArray *arrReminderList;


@property(weak,nonatomic)IBOutlet UITextField *txtPickerStartTime;
@property(weak,nonatomic)IBOutlet UITextField *txtPickerEndTime;
@property(weak,nonatomic)NSString *strPicLocId;
@property(weak,nonatomic)NSString *strDropLocId;
@property(strong,nonatomic)NSMutableArray *arrayRemList;
@property(strong,nonatomic)IBOutlet UITableView *tblRemList;
@property(strong,nonatomic)IBOutlet UITableView *tblToDoList;

@property(strong,nonatomic)NSMutableArray *arrayToDoList;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;

@property (nonatomic) CGFloat lastContentOffset;
@property (nonatomic, strong) UIScrollView *scrollView;

@property(strong,nonatomic)IBOutlet UIView *viewReminder;
@property(strong,nonatomic)IBOutlet UIView *viewPopUp;
@property(weak,nonatomic)IBOutlet UIButton *btnAddRem;
@property(weak,nonatomic)IBOutlet UIButton *btnAddToDo;

@property(strong,nonatomic)IBOutlet UIView *viewToDo;

@end



@implementation JKHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrReminderList=[[NSMutableArray alloc]init];
    self.arrayToDoList=[[NSMutableArray alloc]init];
    self.viewPopUp.frame =  CGRectMake(self.view.frame.size.width-320, self.view.frame.size.height, 320, 200);

    // NSString *strForKey=[NSString stringWithFormat:@"Reminder%ld",(long)nextR];
    NSInteger nextR=[ECSUserDefault getIntFromUserDefaultForKey:@"Count"];
    for (int i=0; i<nextR; i++) {
        NSString *key=[NSString stringWithFormat:@"Reminder%d",i];
        NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
        if (data.length) {
            MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.arrReminderList addObject:obj];
        }
    }
    
    int numElements = (int) self.arrReminderList.count;
    
    [ECSUserDefault saveInt:numElements ToUserDefaultForKey:@"Count"];
    [self.tblRemList reloadData];
    
    //ToDo code
    NSInteger nextToDo=[ECSUserDefault getIntFromUserDefaultForKey:@"CountToDo"];
    for (int i=0; i<nextToDo; i++) {
        NSString *key=[NSString stringWithFormat:@"ToDo%d",i];
        NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
        if (data.length) {
            MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.arrayToDoList addObject:obj];
        }
    }
    
    int numEl = (int) self.arrayToDoList.count;
    
    [ECSUserDefault saveInt:numEl ToUserDefaultForKey:@"CountToDo"];
    [self.tblToDoList reloadData];
    
    [self showSegemntedView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ShowReminderPush:)
                                                 name:@"ShowReminderPush"
                                               object:nil];
}


-(void)getUpdateddata{
    
    self.arrReminderList=[[NSMutableArray alloc]init];
    self.arrayToDoList=[[NSMutableArray alloc]init];
    // NSString *strForKey=[NSString stringWithFormat:@"Reminder%ld",(long)nextR];
    NSInteger nextR=[ECSUserDefault getIntFromUserDefaultForKey:@"Count"];
    for (int i=0; i<nextR; i++) {
        NSString *key=[NSString stringWithFormat:@"Reminder%d",i];
        NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
        if (data.length) {
            MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.arrReminderList addObject:obj];
        }
    }
    
    int numElements = (int) self.arrReminderList.count;
    
    [ECSUserDefault saveInt:numElements ToUserDefaultForKey:@"Count"];
    [self.tblRemList reloadData];
    
    //ToDo code
    NSInteger nextToDo=[ECSUserDefault getIntFromUserDefaultForKey:@"CountToDo"];
    for (int i=0; i<nextToDo; i++) {
        NSString *key=[NSString stringWithFormat:@"ToDo%d",i];
        NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
        if (data.length) {
            MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.arrayToDoList addObject:obj];
        }
    }
    
    int numEl = (int) self.arrayToDoList.count;
    
    [ECSUserDefault saveInt:numEl ToUserDefaultForKey:@"CountToDo"];
    [self.tblToDoList reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    

}

- (void)ShowReminderPush:(NSNotification *) notification
{
    //NSLog(@"fdgfgrf%@",notification.object);
    NSMutableArray *userData=notification.object;
    if (userData.count) {
        ViewAllPush *nav=[[ViewAllPush alloc]initWithNibName:@"ViewAllPush" bundle:nil];
        nav.arrayPushList=userData;
        nav.delegate=self;
        [self.navigationController pushViewController:nav animated:YES];
        NSLog(@"userData =%@",userData);
    }
 
}

-(void)showSegemntedView{
    
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat viewWidth = screenRect.size.width;
    CGFloat viewHeight = screenRect.size.height;
   
    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 70, viewWidth, 60)];
    self.segmentedControl4.sectionTitles = @[@"NOTIFICATION'S LIST", @"TODO'S LIST"];
    self.segmentedControl4.selectedSegmentIndex = 0;
    self.segmentedControl4.backgroundColor = [UIColor clearColor];
    
    [UIColor colorWithRed:255.0f/255.0f green:190.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    self.segmentedControl4.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentedControl4.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:255.0f/255.0f green:190.0f/255.0f blue:0.0f/255.0f alpha:1.0f]};
    self.segmentedControl4.selectionIndicatorColor = [UIColor colorWithRed:255.0f/255.0f green:190.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    self.segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleBox;
    self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl4.tag = 3;
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl4 setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, viewHeight) animated:NO];
    }];
    
    [self.view addSubview:self.segmentedControl4];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 130, viewWidth, viewHeight-130)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(viewWidth * 2, viewHeight-130);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, viewWidth, viewHeight-130) animated:NO];
    [self.view addSubview:self.scrollView];
    
    
    self.viewReminder.frame=CGRectMake(0, 0, viewWidth, viewHeight-130);
    [self.scrollView addSubview:self.viewReminder];
    
    
    self.viewToDo.frame=CGRectMake(viewWidth, 0, viewWidth, viewHeight-130);
    [self.scrollView addSubview:self.viewToDo];
    
    
 
}


- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//
//    if (self.lastContentOffset > scrollView.contentOffset.y)
//    {
//        NSLog(@"Scrolling Up");
//
//    }
//    else if (self.lastContentOffset < scrollView.contentOffset.y)
//    {
//        NSLog(@"Scrolling Down");
//    }else{
//        CGFloat pageWidth = self.view.frame.size.width;
//        NSInteger page = scrollView.contentOffset.x / pageWidth;
//
//        [self.segmentedControl4 setSelectedSegmentIndex:page animated:YES];
//
//    }
//
//    self.lastContentOffset = scrollView.contentOffset.y;
//
//}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.lastContentOffset < scrollView.contentOffset.x) {
        // moved right
        //        CGFloat pageWidth = self.view.frame.size.width;
        //        NSInteger page = scrollView.contentOffset.x / pageWidth;
        //
        //        [self.segmentedControl4 setSelectedSegmentIndex:page animated:NO];
    } else if (self.lastContentOffset > scrollView.contentOffset.x) {
        // moved left
        //        CGFloat pageWidth = self.view.frame.size.width;
        //        NSInteger page = scrollView.contentOffset.x / pageWidth;
        //
        //        [self.segmentedControl4 setSelectedSegmentIndex:page animated:NO];
    }
    
    
    else {
        //        CGFloat pageWidth = self.view.frame.size.width;
        //        NSInteger page = scrollView.contentOffset.x / pageWidth;
        //
        //        [self.segmentedControl4 setSelectedSegmentIndex:page animated:YES];
        // didn't move
    }
    self.lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"Scrollview did scroll");
    if (self.lastContentOffset > scrollView.contentOffset.y)
    {
        NSLog(@"Scrolling Up");
        
    }
    else if (self.lastContentOffset < scrollView.contentOffset.y)
    {
        NSLog(@"Scrolling Down");
    }else{
        CGFloat pageWidth = self.view.frame.size.width;
        NSInteger page = scrollView.contentOffset.x / pageWidth;
        
        [self.segmentedControl4 setSelectedSegmentIndex:page animated:YES];
        
        
    }
    
    self.lastContentOffset = scrollView.contentOffset.y;
    
    
}




-(IBAction)onClickAddReminder:(UIButton *)sender{
    if (sender.selected==YES) {
           sender.selected=NO;
       
      
        
        [UIView animateWithDuration:0.5 animations:^{
         //   [self.btnAddRem setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
            self.viewPopUp.frame =  CGRectMake(self.view.frame.size.width-320, self.view.frame.size.height, 320, 200);
            [self.view addSubview:self.viewPopUp];
            self.viewPopUp.alpha = 1.0f;
            self.btnAddRem.transform = CGAffineTransformMakeRotation(90.0*M_PI/180.0);
            self.btnAddToDo.transform = CGAffineTransformMakeRotation(90.0*M_PI/180.0);

        } completion:^(BOOL finished){
            
             self.viewPopUp.hidden=YES;
        }];


       
    }else{
        sender.selected=YES;
        
        self.viewPopUp.hidden=NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.btnAddRem.transform = CGAffineTransformMakeRotation(45.0*M_PI/180.0);
            self.btnAddToDo.transform = CGAffineTransformMakeRotation(45.0*M_PI/180.0);

             //[self.btnAddRem setImage:[UIImage imageNamed:@"Cross.png"] forState:UIControlStateNormal];
            self.viewPopUp.frame =  CGRectMake(self.view.frame.size.width-320, self.view.frame.size.height-280, 320, 200);
            [self.view addSubview:self.viewPopUp];
            self.viewPopUp.alpha = 1.0f;
        } completion:^(BOOL finished){
           
            
        }];
    }
//    

    
}


-(IBAction)onClickAddRem:(id)sender{
    self.segmentedControl4.selectedSegmentIndex = 0;

        AddReminderVC *nav=[[AddReminderVC alloc]initWithNibName:@"AddReminderVC" bundle:nil];
        nav.delegate=self;
        [self.navigationController pushViewController:nav animated:YES];
    
}
-(IBAction)onClickAddTODO:(id)sender{
    self.segmentedControl4.selectedSegmentIndex = 1;

    
    AddToDoVC *nav=[[AddToDoVC alloc]initWithNibName:@"AddToDoVC" bundle:nil];
    nav.delegate=self;
    [self.navigationController pushViewController:nav animated:YES];
    
}


- (void)deleteRemainderData: (NSString *)Key{
    self.arrReminderList=[[NSMutableArray alloc]init];
    
    
    for (int i=0; i<50; i++) {
        NSString *key=[NSString stringWithFormat:@"Reminder%d",i];
        NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
        if (data.length) {
            MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.arrReminderList addObject:obj];
            
    }
    }
    NSLog(@"Count%lu",(unsigned long)self.arrReminderList.count);
    int numElements = (int) self.arrReminderList.count;
    [ECSUserDefault saveInt:numElements ToUserDefaultForKey:@"Count"];
    [self.tblRemList reloadData];
}

- (void)deleteToDoData: (NSString *)Key{
    self.arrayToDoList=[[NSMutableArray alloc]init];
    
    
    for (int i=0; i<50; i++) {
        NSString *key=[NSString stringWithFormat:@"ToDo%d",i];
        NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
        if (data.length) {
            MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.arrayToDoList addObject:obj];
            
        }
    }
    
    int numEle = (int) self.arrayToDoList.count;
    [ECSUserDefault saveInt:numEle ToUserDefaultForKey:@"CountToDo"];
    [self.tblToDoList reloadData];
}
- (void)UpdateRemainderData: (NSString *)Key
{
    self.arrReminderList=[[NSMutableArray alloc]init];
    for (int i=0; i<50; i++) {
        NSString *key=[NSString stringWithFormat:@"Reminder%d",i];
        NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
        if (data.length) {
            MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.arrReminderList addObject:obj];
        }
    }
  
    [self.tblRemList reloadData];
}

- (void)UpdateToDoData: (NSString *)Key
{
    self.arrayToDoList=[[NSMutableArray alloc]init];
    for (int i=0; i<50; i++) {
        NSString *key=[NSString stringWithFormat:@"ToDo%d",i];
        NSData *data=[ECSUserDefault getObjectFromUserDefaultForKey:key];
        if (data.length) {
            MenuItemObject *obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.arrayToDoList addObject:obj];
        }
    }
    
    [self.tblToDoList reloadData];
}
-(void)getRemainderData:(MenuItemObject *)selectedData{
    [self.arrReminderList addObject:selectedData];
   

    int numElements = (int) self.arrReminderList.count;
   
     numElements = (int) numElements;
    
    [ECSUserDefault saveInt:numElements ToUserDefaultForKey:@"Count"];
    [self.tblRemList reloadData];
}

-(void)getToDoData:(MenuItemObject *)selectedData{
    
    [self.arrayToDoList addObject:selectedData];
    NSLog(@"title=%@",selectedData.title);
    NSLog(@"list=%@",self.arrayToDoList);
    NSLog(@"date=%@",selectedData.dateWithFormat);
    
    int numElements = (int) self.arrayToDoList.count;
    
    numElements = (int) numElements;
    
    [ECSUserDefault saveInt:numElements ToUserDefaultForKey:@"CountToDo"];
    [self.tblToDoList reloadData];
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tblRemList) {
        return self.arrReminderList.count;
    }else{
        return self.arrayToDoList.count;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tblRemList) {
    return 70;
    }else{
        return 70;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      if (tableView==self.tblRemList) {
    static NSString *CellIdentifier = @"ReminderTableCell";
    [self.tblRemList registerNib:[UINib nibWithNibName:@"ReminderTableCell" bundle:nil]forCellReuseIdentifier:@"ReminderTableCell"];
    ReminderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.tblRemList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //cell.backgroundColor = [UIColor clearColor];
    MenuItemObject *obj=[self.arrReminderList objectAtIndex:indexPath.row];
    cell.lblTitle.text=obj.title;
    cell.lblDate.text=obj.date;
    cell.lblTime.text=obj.time;
    
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

          }else{
              cell.lblTitle.textColor=[UIColor whiteColor];
              cell.lblTime.textColor=[UIColor whiteColor];
              cell.lblDate.textColor=[UIColor whiteColor];
          }
          
    NSLog(@"cell Reminder Id=%@",obj.remId);
    
    return cell;
      }else
      {
          static NSString *CellIdentifier = @"ReminderTableCell";
          
          
          [self.tblToDoList registerNib:[UINib nibWithNibName:@"ReminderTableCell" bundle:nil]forCellReuseIdentifier:@"ReminderTableCell"];
          ReminderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
          [self.tblToDoList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
          //cell.backgroundColor = [UIColor clearColor];
          MenuItemObject *obj=[self.arrayToDoList objectAtIndex:indexPath.row];
          cell.lblTitle.text=obj.title;
          cell.lblDate.text=obj.date;
          cell.lblTime.text=obj.time;
          
          
          NSLog(@"cell Reminder Id=%@",obj.remId);
          
          return cell;
      }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView==self.tblRemList) {
    MenuItemObject *obj=[self.arrReminderList objectAtIndex:indexPath.row];

    AddReminderVC *nav=[[AddReminderVC alloc]initWithNibName:@"AddReminderVC" bundle:nil];
    nav.SelectedIndex=[NSString stringWithFormat:@"%@",obj.remId];
    nav.delegate=self;
    [self.navigationController pushViewController:nav animated:YES];
    }else{
        MenuItemObject *obj=[self.arrayToDoList objectAtIndex:indexPath.row];
        
        AddToDoVC *nav=[[AddToDoVC alloc]initWithNibName:@"AddToDoVC" bundle:nil];
        nav.SelectedIndex=[NSString stringWithFormat:@"%@",obj.remId];
        nav.delegate=self;
        [self.navigationController pushViewController:nav animated:YES];
    }
  
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
