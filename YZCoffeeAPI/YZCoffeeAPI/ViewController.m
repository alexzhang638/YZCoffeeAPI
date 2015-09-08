//
//  ViewController.m
//  YZCoffeeAPI
//
//  Created by Yan Zhang on 9/2/15.
//  Copyright (c) 2015 Yan Zhang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "CoffeeRecord.h"
#import "CoffeeListTableViewController.h"

static NSString * const basicURLString = @"https://coffeeapi.percolate.com/api/coffee/?api_key=WuVbkuUsCXHPx3hsQzus4SE";
@interface ViewController ()
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *logo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.titleLable = [[UILabel alloc] init];
    [self.titleLable setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.titleLable];
    [self.titleLable setText:@"COFFEE"];
    [self.titleLable setTextColor:[UIColor colorWithRed:241.0/255.0 green:100.0/255.0 blue:33.0/255.0 alpha:1.0]];
    [self.titleLable setFont:[UIFont systemFontOfSize:17 weight:1.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.00]];
    
    
    self.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drip-white"]];
    [self.logo setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.logo];
    [self.logo setBackgroundColor:[UIColor whiteColor]];
    self.logo.image = [self.logo.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.logo setTintColor:[UIColor colorWithRed:241.0/255.0 green:100.0/255.0 blue:33.0/255.0 alpha:1.0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:17]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.titleLable attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLable attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:17]];
     
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.activityIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.activityIndicator];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.titleLable attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLable attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20]];
    [self.activityIndicator startAnimating];
    
    
    NSURL *url = [NSURL URLWithString:basicURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSArray *tempArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"show result: %@", tempArray);
        NSMutableArray *coffeeArray = [[NSMutableArray alloc] initWithCapacity:10];
        if (tempArray.count >0) {
            for (NSDictionary *dict in tempArray) {
                NSString *desc = [dict objectForKey:@"desc"];
                NSString *name = [dict objectForKey:@"name"];
                if (![desc isEqualToString:@""] && ![name isEqualToString:@""] ) {
                    CoffeeRecord *coffee = [[CoffeeRecord alloc] init];
                    coffee.desc = [dict objectForKey:@"desc"];
                    coffee.coffeeId = [dict objectForKey:@"id"];
                    coffee.imageURLString = [dict objectForKey:@"image_url"];
                    coffee.name = [dict objectForKey:@"name"];
                    //NSLog(@"url: %@", coffee.imageURL);
                    [coffeeArray addObject:coffee];
                }
            }
        };
        [self.activityIndicator stopAnimating];
        CoffeeListTableViewController *listVC =[[CoffeeListTableViewController alloc] init];
        listVC.coffeeArray = coffeeArray;
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:listVC];
        [self.navigationController presentViewController:naVC animated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"not download");
        [self.activityIndicator stopAnimating];
    }];
    
    [operation start];
    
    
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
