//
//  CoffeeTableViewCell.h
//  YZCoffeeAPI
//
//  Created by Yan Zhang on 9/6/15.
//  Copyright (c) 2015 Yan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeeRecord.h"

@interface CoffeeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *coffeeImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@end
