//
//  AddListViewController.h
//  ASTOdoListTask
//
//  Created by Student P_02 on 05/03/17.
//  Copyright © 2017 Afsana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddListViewController : UIViewController<UITextFieldDelegate>
{
    UIDatePicker *datePicker;
    NSInteger employeeId;
    
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btn_save;

- (IBAction)CancelAction:(id)sender;
- (IBAction)AddnewTask:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txt_TaskDate;
@property (strong, nonatomic) IBOutlet UITextField *txt_TaskName;
@property (strong, nonatomic) IBOutlet UITextField *txt_TaskDetails;
@property (strong) NSManagedObjectModel *task1;

- (IBAction)segmentChangeAction:(id)sender;

@end
