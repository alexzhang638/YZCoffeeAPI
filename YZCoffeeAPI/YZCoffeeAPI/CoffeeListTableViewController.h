//
//  CoffeeListTableViewController.h
//  YZCoffeeAPI
//
//  Created by Yan Zhang on 9/4/15.
//  Copyright (c) 2015 Yan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kCellIdentifier = @"cellCoffee";

@interface CoffeeListTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *coffeeArray;
@end
