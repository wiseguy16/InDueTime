//
//  ToDoCell.h
//  InDueTime
//
//  Created by Gregory Weiss on 8/2/16.
//  Copyright © 2016 Gregory Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *toDoTextField;
@property (weak, nonatomic) IBOutlet UISwitch *toDoSwitch;


@end
