//
//  AddListViewController.m
//  ASTOdoListTask
//
//  Created by Student P_02 on 05/03/17.
//  Copyright © 2017 Afsana. All rights reserved.
//

#import "AddListViewController.h"
#import "AppDelegate.h"
@interface AddListViewController ()

@end

@implementation AddListViewController
{
    NSManagedObjectContext *context;
}
@synthesize task1;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    employeeId=1;
    [self addicons];
    [self AddDate];
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    context=appDelegate.persistentContainer.viewContext;
    if (self.task1) {
        [_txt_TaskDate setText:[self.task1 valueForKey:@"assignDate"]];
        [_txt_TaskName setText:[self.task1 valueForKey:@"taskName"]];
        [_txt_TaskDetails setText:[self.task1 valueForKey:@"taskDetails"]];

    }

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
-(void)addicons
{
    UIImageView *assigndate = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"date-from-xl"]];
    assigndate.frame = CGRectMake(0.0, 0.0, assigndate.image.size.width+10.0, assigndate.image.size.height);
    _txt_TaskDate.clipsToBounds=YES;
    [_txt_TaskDate  setRightView:assigndate];
    [_txt_TaskDate  setRightViewMode:UITextFieldViewModeAlways];
    [_txt_TaskDate setKeyboardType:UIKeyboardTypeDefault];
    
    UIImageView *taskName= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"serial-tasks-xl"]];
    taskName.frame = CGRectMake(0.0, 0.0, taskName.image.size.width+10.0, taskName.image.size.height);
    _txt_TaskName.clipsToBounds=YES;
    [ _txt_TaskName setRightView:taskName];
    [_txt_TaskName setKeyboardType:UIKeyboardTypeDefault];
    [_txt_TaskName  setRightViewMode:UITextFieldViewModeAlways];
    
    UIImageView *taskDetails= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"view-details-xl"]];
    taskDetails.frame = CGRectMake(0.0, 0.0, taskName.image.size.width+10.0, taskDetails.image.size.height);
    _txt_TaskDetails.clipsToBounds=YES;
    [ _txt_TaskDetails setRightView:taskDetails];
    [_txt_TaskDetails setKeyboardType:UIKeyboardTypeDefault];
    [_txt_TaskDetails  setRightViewMode:UITextFieldViewModeAlways];

}
//AddDate
-(void)AddDate
{
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.txt_TaskDate setInputView:datePicker];
    
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor blackColor]];
    UIBarButtonItem *btnDone=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(showDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,btnDone,nil]];
    [self.txt_TaskDate setInputAccessoryView:toolBar];
}
-(void)showDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/mm/yyyy"];
    self.txt_TaskDate.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.txt_TaskDate resignFirstResponder];
}

- (IBAction)CancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)AddnewTask:(id)sender {
    if ([self emptyCheck]) {
    NSEntityDescription *taskEntity=[NSEntityDescription entityForName:@"Task" inManagedObjectContext:context];
    NSManagedObject *task=[[NSManagedObject alloc]initWithEntity:taskEntity insertIntoManagedObjectContext:context];
    
        if (self.task1) {
           
            [self.task1 setValue:self.txt_TaskDate.text forKey:@"assignDate"];
            [self.task1 setValue:self.txt_TaskName.text forKey:@"taskName"];
            [self.task1 setValue:self.txt_TaskDetails.text forKey:@"taskDetails"];
        }
        else
        {
        int TaskID=arc4random();
        [task setValue:[NSNumber numberWithInt:TaskID] forKey:@"id"];
        [task setValue:[NSNumber numberWithInteger:employeeId] forKey:@"emp_id"];
    [task setValue:_txt_TaskName.text forKey:@"taskName"];
    [task setValue:_txt_TaskDetails.text forKey:@"taskDetails"];
    [task setValue:_txt_TaskDate.text forKey:@"assignDate"];
        }
    NSError *error;
    NSString *msg,*title;
    if(error)
    {
        title=@"Error";
        msg=error.localizedDescription;
        NSLog(@"%@",error.localizedDescription);
    }
    else
    {
        if(self.task1)
        {
        title=@"Data updated Successfully...";
        msg=@"You can continue......";
        }
        else
        {
            title=@"Data saved Successfully...";
            msg=@"You can continue......";
        }
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
}
-(void)alertwithTitle:(NSString *)title andMessage:(NSString *)msg
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
-(BOOL)emptyCheck
{
    if ([_txt_TaskDate.text isEqualToString:@""]) {
        [self alertwithTitle:@"Error" andMessage:@"Please enter Date."];
        [_txt_TaskDate becomeFirstResponder];
        return NO;
    }
    else if ([_txt_TaskName.text isEqualToString:@""])
    {
        [self alertwithTitle:@"Error" andMessage:@"Please enter Task."];
        [_txt_TaskName becomeFirstResponder];
        return NO;
    }
    if ([_txt_TaskDetails.text isEqualToString:@""]) {
        [self alertwithTitle:@"Error" andMessage:@"Please enter Details."];
        [_txt_TaskDetails becomeFirstResponder];
        return NO;
    }
        else
        return YES;
}

- (IBAction)segmentChangeAction:(id)sender {
    UISegmentedControl *segcontrol=(UISegmentedControl *)sender;
    if(segcontrol.selectedSegmentIndex==0)
        employeeId=1;
    
    else if (segcontrol.selectedSegmentIndex==1)
        employeeId=2;
    else
        employeeId=3;
}
@end
