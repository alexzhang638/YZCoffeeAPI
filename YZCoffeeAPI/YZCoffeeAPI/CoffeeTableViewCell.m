//
//  CoffeeTableViewCell.m
//  YZCoffeeAPI
//
//  Created by Yan Zhang on 9/6/15.
//  Copyright (c) 2015 Yan Zhang. All rights reserved.
//

#import "CoffeeTableViewCell.h"

@implementation CoffeeTableViewCell

+ (BOOL) requiresConstraintBasedLayout
{
    return YES;
}

- (void) updateConstraints
{
    [super updateConstraints];
    NSArray *constraints = [self.contentView constraints];
    [self.contentView removeConstraints:constraints];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-40.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.descLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.descLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-40.0]];
    NSLayoutConstraint *constraint =[NSLayoutConstraint constraintWithItem:self.descLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0];
    [constraint setPriority:UILayoutPriorityDefaultLow];
    [self.contentView addConstraint:constraint];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.descLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
    
    if (self.coffeeImageView.image == nil) {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.descLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
    } else {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.coffeeImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.coffeeImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.nameLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.coffeeImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.descLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.coffeeImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
        
    }

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return self;
    }
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.nameLabel setFont:[UIFont systemFontOfSize:13.0]];
    [self.nameLabel setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.contentView addSubview:self.nameLabel];
    
    self.descLabel = [[UILabel alloc] init];
    [self.descLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.descLabel setNumberOfLines:0];
    [self.descLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.descLabel setTextAlignment:NSTextAlignmentLeft];
    [self.descLabel setTextColor:[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.descLabel setFont:[UIFont systemFontOfSize:12.0]];
    [self.contentView addSubview:self.descLabel];
    
    self.coffeeImageView = [[UIImageView alloc] init];
    [self.coffeeImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.coffeeImageView];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.accessoryView.frame;
    rect.origin.y = 15.0;
    self.accessoryView.frame = rect;
    
}

@end
