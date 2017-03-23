//
//  ViewController.m
//  ASTOdoListTask
//
//  Created by Student P_02 on 05/03/17.
//  Copyright © 2017 Afsana. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "CustomTableViewCell.h"
#import "AddListViewController.h"
@interface ViewController ()

@end

@implementation ViewController
{
    NSManagedObjectContext *context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    employeeId=1;
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    context=appDelegate.persistentContainer.viewContext;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self fetchData];
}
-(void)fetchData
{
    NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:@"Task"];
    NSPredicate *prediCate=[NSPredicate predicateWithFormat:@"emp_id == %ld",employeeId];
    [fetch setPredicate:prediCate];
    NSError *error;
    arrayTask=[context executeFetchRequest:fetch error:&error];
    if(error)
        NSLog(@"%@",error.localizedDescription);
    if(arrayTask.count)
        [_TaskTable reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return arrayTask.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil)
    {
        cell=[[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.lbl_Date.text=[[arrayTask objectAtIndex:indexPath.row] valueForKey:@"assignDate"];
     cell.lbl_TaskName.text=[[arrayTask objectAtIndex:indexPath.row] valueForKey:@"taskName"];
     cell.lbl_TaskDetails.text=[[arrayTask objectAtIndex:indexPath.row] valueForKey:@"taskDetails"];
    return cell;
}
- (IBAction)AddTask:(id)sender {
    [self performSegueWithIdentifier:@"AddListSegue" sender:nil];
}
- (IBAction)segmentChanged:(id)sender {
    UISegmentedControl *segcontrol=(UISegmentedControl *)sender;
    if(segcontrol.selectedSegmentIndex==0)
        employeeId=1;
    
    else if (segcontrol.selectedSegmentIndex==1)
        employeeId=2;
    else
        employeeId=3;
    
    [self fetchData];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
      [self performSegueWithIdentifier:@"updateSegue" sender:nil];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%ld",(long)indexPath.row);
        
        NSManagedObject *obj =[arrayTask objectAtIndex:indexPath.row];
        [context deleteObject:obj];
        NSError *error;
        [context save:nil];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"OK"
                                                                                 message:@"Sucessfully Deleted"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil]; //You can use a block here to handle a press on this button
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        if (error != nil) {
            NSLog(@"%@",error.localizedDescription);
        }
        
        //  [context deleteObject:obj];
        NSMutableArray *array = [[NSMutableArray alloc]init];
        array = [arrayTask mutableCopy];
        [array removeObjectAtIndex:indexPath.row];
        arrayTask = [array copy];
        [_TaskTable reloadData];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"updateSegue"]) {
        NSManagedObject *selectetask = [arrayTask objectAtIndex:[[_TaskTable indexPathForSelectedRow] row]];
       
       AddListViewController *destViewController = segue.destinationViewController;
        destViewController.task1 = selectetask;
    }
}

@end
