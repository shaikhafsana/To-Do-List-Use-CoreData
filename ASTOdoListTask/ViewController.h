//
//  ViewController.h
//  ASTOdoListTask
//
//  Created by Student P_02 on 05/03/17.
//  Copyright © 2017 Afsana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arrayTask;
    NSInteger employeeId;
}
- (IBAction)AddTask:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *TaskTable;
- (IBAction)segmentChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *employeeSegment;

@end

