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
    
/*
    // This block will fetch our counter objects from Core Data and load them in the tableView
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Counter class])];
    NSError *error = nil;
    NSArray *countersFromCoreData = [self.moc executeFetchRequest:fetchRequest error:&error];
    if (error)
    {
        NSLog(@"Could not fetch from moc: %@", [error localizedDescription]);
    }
    else
    {
        [self.counters addObjectsFromArray:countersFromCoreData];
    }
*/    
   
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
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

#pragma mark - Action Handlers

- (IBAction)addToDoItem:(UIBarButtonItem *)sender
{
    
    ToDoItem *aToDoItem = [NSEntityDescription insertNewObjectForEntityForName: NSStringFromClass([ToDoItem class]) inManagedObjectContext:self.moc];
    [self.toDoItems addObject:aToDoItem];
    [self.tableView reloadData];
    
}

@end


