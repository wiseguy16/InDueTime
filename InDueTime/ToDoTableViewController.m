//
//  ToDoTableViewController.m
//  InDueTime
//
//  Created by Gregory Weiss on 8/2/16.
//  Copyright © 2016 Gregory Weiss. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "AppDelegate.h"
#import "ToDoCell.h"

#import "ToDoItem.h"
#import <CoreData/CoreData.h>

@interface ToDoTableViewController () <UITextViewDelegate>

@property (strong, nonatomic) NSMutableArray *toDoItems;
@property (strong, nonatomic) NSManagedObjectContext *moc;



@end

@implementation ToDoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MY TODO ITEMS";
    self.toDoItems = [[NSMutableArray alloc] init];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;
    

    // This block will fetch our counter objects from Core Data and load them in the tableView
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([ToDoItem class])];
    NSError *error = nil;
    NSArray *toDoItemsFromCoreData = [self.moc executeFetchRequest:fetchRequest error:&error];
    if (error)
    {
        NSLog(@"Could not fetch from moc: %@", [error localizedDescription]);
    }
    else
    {
        [self.toDoItems addObjectsFromArray:toDoItemsFromCoreData];
    }
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToDoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    ToDoItem *aToDoItem = self.toDoItems[indexPath.row];
    
    if (aToDoItem.toDoDescription &&![aToDoItem.toDoDescription isEqualToString:@""])
    {
        [cell.toDoTextField setText:aToDoItem.toDoDescription];
        //[cell.toDoSwitch setOn:aToDoItem.isDone];
        [cell.toDoSwitch setOn:[aToDoItem.isDone boolValue]];
       // cell.toDoSwitch.on = [[self.toDoItems valueForKey:@"isDone"] boolValue];
        
    }
    else
    {
        [cell.toDoTextField becomeFirstResponder];
    }
    //cell.toDo.text = [NSString stringWithFormat:@"%d", [aCounter.count intValue]];
    
    return cell;
}


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }






// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        ToDoItem *toDoItemToDelete = self.toDoItems[indexPath.row];
//        if (toDoItemToDelete.isDone == [NSNumber numberWithBool:YES])
        if ([toDoItemToDelete.isDone boolValue])
        {
            NSManagedObject *managedObject = self.toDoItems[indexPath.row];
            [self.moc deleteObject:managedObject];
           // [self.managedObjectContext save:nil];
            // Delete the row from the data source
           // UIView *contentView = [UITableView superview];
    //        ToDoCell *cell = (ToDoCell *)[contentView superview];
    //        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //        ToDoItem *aToDoItem = self.toDoItems[indexPath.row];
            [self.toDoItems removeObjectAtIndex:indexPath.row];
            [self saveContext];
            
            [tableView reloadData];
        }
        
       // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert)
//    {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}

/*
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToDoItem *toDoItemToDelete = self.toDoItems[indexPath.row];
    return  [toDoItemToDelete.isDone boolValue];

}
 */

/*
 
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) 
 {
 //remove the deleted object from your data source.
 //If your data source is an NSMutableArray, do this
 [self.dataArray removeObjectAtIndex:indexPath.row];
 [tableView reloadData]; // tell table to refresh now
 }
 }
 
 
 
 */

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    if (![textField.text isEqualToString:@""])
    {
        UIView *contentView = [textField superview];
        ToDoCell *cell = (ToDoCell *)[contentView superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        ToDoItem *aToDoItem = self.toDoItems[indexPath.row];
        aToDoItem.toDoDescription = textField.text;
        [textField resignFirstResponder];
        
        [self saveContext];
    }
    
    return rc;  // rc stands for ReturnCode
}


- (IBAction)toDoSwitch:(UISwitch *)sender
{
    UIView *contentView = [sender superview];
    ToDoCell *cell = (ToDoCell *)[contentView superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ToDoItem *aToDoItem = self.toDoItems[indexPath.row];
    //UISwitch *mySwitch = (UISwitch *)sender;
    if ([sender isOn])
    {
        aToDoItem.isDone = [NSNumber numberWithBool:YES];
        NSLog(@"its on!");
    }
    else if (![sender isOn])
    {
        aToDoItem.isDone = [NSNumber numberWithBool:NO];
        NSLog(@"its off!");
    }
    [self saveContext];
    
}

#pragma mark - Action Handlers

- (IBAction)addToDoItem:(UIBarButtonItem *)sender
{
    
    ToDoItem *aToDoItem = [NSEntityDescription insertNewObjectForEntityForName: NSStringFromClass([ToDoItem class]) inManagedObjectContext:self.moc];
    [self.toDoItems addObject:aToDoItem];
    [self.tableView reloadData];
    
}


#pragma mark - misc

- (void)saveContext
{
    NSError *error = nil;
    [self.moc save:&error];
    if (error)
    {
        NSLog(@"Error saving moc: %@", [error localizedDescription]);
    }
    
}

@end


