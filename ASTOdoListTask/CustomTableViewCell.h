//
//  CustomTableViewCell.h
//  ASTOdoListTask
//
//  Created by Student P_02 on 05/03/17.
//  Copyright © 2017 Afsana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_Date;
@property (strong, nonatomic) IBOutlet UILabel *lbl_TaskName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_TaskDetails;

@end
