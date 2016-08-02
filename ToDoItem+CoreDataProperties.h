//
//  ToDoItem+CoreDataProperties.h
//  InDueTime
//
//  Created by Gregory Weiss on 8/2/16.
//  Copyright © 2016 Gregory Weiss. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *toDoDescription;
@property (nullable, nonatomic, retain) NSNumber *isDone;
@property (nullable, nonatomic, retain) NSString *extraDetail;
@property (nullable, nonatomic, retain) NSDate *dueDate;
@property (nullable, nonatomic, retain) NSNumber *countOfSomething;
@property (nullable, nonatomic, retain) NSNumber *bonusToggle;
@property (nullable, nonatomic, retain) NSString *misc;

@end

NS_ASSUME_NONNULL_END
