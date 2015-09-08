//
//  CoffeeDetailViewController.m
//  YZCoffeeAPI
//
//  Created by Yan Zhang on 9/7/15.
//  Copyright (c) 2015 Yan Zhang. All rights reserved.
//

#import "CoffeeDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@interface CoffeeDetailViewController ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *pictImageView;
@property (nonatomic, strong) UILabel *updatedLable;

@end

@implementation CoffeeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
    [logoImageView setContentMode:UIViewContentModeScaleAspectFit];
    [logoImageView setImage:[UIImage imageNamed:@"drip-white"]];
    self.navigationItem.titleView = logoImageView;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightButton.frame = CGRectMake(0.0, 0.0, 60.0, 25.0);
    [rightButton setTitle:@"SHARE" forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [rightButton.layer setBorderWidth:1.0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.nameLabel setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
    [self.nameLabel setFont:[UIFont systemFontOfSize:30.0]];
    [self.nameLabel setText:self.coffeeObject.name];
    [self.view addSubview:self.nameLabel];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:54.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width - 20.0, 1.0)];
    [lineView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [lineView setBackgroundColor:[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.view addSubview:lineView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:2.0]];
    
    
    self.descLabel = [[UILabel alloc] init];
    [self.descLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.descLabel setNumberOfLines:0];
    [self.descLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.descLabel setTextAlignment:NSTextAlignmentLeft];
    [self.descLabel setTextColor:[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.descLabel setFont:[UIFont systemFontOfSize:12.0]];
    [self.descLabel setText:self.coffeeObject.desc];
    [self.view addSubview:self.descLabel];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.descLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.descLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.descLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:lineView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0]];
    UIFont *systemFont = [UIFont systemFontOfSize:12.0];
    CGRect r = [self.coffeeObject.desc boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 20.0, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : systemFont} context:nil];
    CGFloat heightOfText = r.size.height + 5.0;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.descLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:heightOfText]];
    
    self.updatedLable = [[UILabel alloc] init];
    [self.updatedLable setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.updatedLable setTextAlignment:NSTextAlignmentLeft];
    [self.updatedLable setTextColor:[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]];
    [self.updatedLable setFont:[UIFont italicSystemFontOfSize:10.0]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd' 'HH:mms:ss.SSSSSS"];
    NSDate *updatedDate = [dateFormatter dateFromString:self.coffeeObject.last_updated_at];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval secondsBetween = [currentDate timeIntervalSinceDate:updatedDate];
    int numberOfDays = secondsBetween/86400;
    int numberOfWeeks = numberOfDays/7;
    NSString *updatedString;
    if (numberOfWeeks >= 1) {
        updatedString = [NSString stringWithFormat:@"Updated %d weeks ago", numberOfWeeks];
    } else {
        updatedString = [NSString stringWithFormat:@"Updated %d days ago", numberOfDays];
    }
    
    [self.updatedLable setText:updatedString];
    [self.view addSubview:self.updatedLable];
    
    if ([self.coffeeObject.imageURLString isEqualToString:@""]) {
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.updatedLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.updatedLable attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.updatedLable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.descLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.updatedLable attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15.0]];
    } else {
        if (self.coffeeObject.image == nil) {

            self.pictImageView = [[UIImageView alloc] init];
            [self.pictImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
            //[self.pictImageView setContentMode:UIViewContentModeScaleToFill];
            //[self.pictImageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            //[self.pictImageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
            [self.view addSubview:self.pictImageView];
            NSURL *url = [NSURL URLWithString:self.coffeeObject.imageURLString];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            __weak UIView *weakView = self.view;
            __weak __block UIImageView *weakImageView = self.pictImageView;
            __weak UILabel *weakDescLable = self.descLabel;
            __weak UILabel *weakUpdatedLabel = self.updatedLable;
            __weak CoffeeRecord *weakCoffeeObject = self.coffeeObject;
            [self.pictImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * request, NSHTTPURLResponse * response, UIImage * image) {
                [weakImageView setImage:image];
                CGFloat naturalAspect = image.size.width / image.size.height;
                NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:weakImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:weakImageView attribute:NSLayoutAttributeHeight multiplier:naturalAspect constant:0.0];
                [constraint setPriority:UILayoutPriorityRequired];
                [weakImageView addConstraint:constraint];
                
                [weakView addConstraint:[NSLayoutConstraint constraintWithItem:weakImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:weakView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
                [weakView addConstraint:[NSLayoutConstraint constraintWithItem:weakImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:weakView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
                [weakView addConstraint:[NSLayoutConstraint constraintWithItem:weakImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:weakDescLable attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0]];
                
                [weakView addConstraint:[NSLayoutConstraint constraintWithItem:weakUpdatedLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:weakView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0]];
                [weakView addConstraint:[NSLayoutConstraint constraintWithItem:weakUpdatedLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:weakView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.0]];
                [weakView addConstraint:[NSLayoutConstraint constraintWithItem:weakUpdatedLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:weakImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0]];
                [weakView addConstraint:[NSLayoutConstraint constraintWithItem:weakUpdatedLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15.0]];
                
                weakCoffeeObject.image = image;
            } failure:nil];
        }
    }
    
    
    
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
