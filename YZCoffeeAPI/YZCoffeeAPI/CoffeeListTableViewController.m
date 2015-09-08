//
//  CoffeeListTableViewController.m
//  YZCoffeeAPI
//
//  Created by Yan Zhang on 9/4/15.
//  Copyright (c) 2015 Yan Zhang. All rights reserved.
//

#import "CoffeeListTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "CoffeeTableViewCell.h"
#import "CoffeeDetailViewController.h"
#import "AFNetworking.h"

static NSString * const basicDetailCoffeeURLString = @"https://coffeeapi.percolate.com/api/coffee/";
static NSString * const apiKey = @"?api_key=WuVbkuUsCXHPx3hsQzus4SE";
@interface CoffeeListTableViewController ()

@end

@implementation CoffeeListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[CoffeeTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:241.0/255.0 green:100.0/255.0 blue:33.0/255.0 alpha:1.0];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
    [logoImageView setContentMode:UIViewContentModeScaleAspectFit];
    [logoImageView setImage:[UIImage imageNamed:@"drip-white"]];
    
    self.navigationItem.titleView = logoImageView;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.coffeeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoffeeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    CoffeeRecord *coffeeObject = [self.coffeeArray objectAtIndex:indexPath.row];
    [cell.nameLabel setText:coffeeObject.name];
    [cell.descLabel setPreferredMaxLayoutWidth:(self.tableView.frame.size.width - 50)];
    [cell.descLabel setText:coffeeObject.desc];
    
    if (coffeeObject.image == nil) {
        NSURL *url = [NSURL URLWithString:coffeeObject.imageURLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        __weak CoffeeTableViewCell *weakCell = cell;
        __weak CoffeeRecord *weakCoffeeObject = coffeeObject;
        [cell.coffeeImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * request, NSHTTPURLResponse * response, UIImage * image) {
            CGSize size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.4, 0.4));
            UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
            [image drawInRect:CGRectMake(0.0, 0.0, size.width, size.height)];
            UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            weakCoffeeObject.image = scaleImage;
            //weakCell.coffeeImageView.image =image;
            [weakCell setNeedsLayout];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:NO];
        } failure:nil];
    } else {
        cell.coffeeImageView.image = coffeeObject.image;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoffeeRecord *coffeeObject = [self.coffeeArray objectAtIndex:indexPath.row];
    if (coffeeObject.image == nil) {
        return 75.0;
    } else {
        return coffeeObject.image.size.height + 90.0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoffeeRecord *coffeeObject = [self.coffeeArray objectAtIndex:indexPath.row];
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:basicDetailCoffeeURLString];
    [urlString appendString:coffeeObject.coffeeId];
    [urlString appendString:apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary *detailCoffeeDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"show result: %@", detailCoffeeDict);
        
        CoffeeRecord *detailCoffeeObject = [[CoffeeRecord alloc] init];
        [detailCoffeeObject setDesc:[detailCoffeeDict objectForKey:@"desc"]];
        [detailCoffeeObject setCoffeeId:[detailCoffeeDict objectForKey:@"id"]];
        [detailCoffeeObject setImageURLString:[detailCoffeeDict objectForKey:@"image_url"]];
        [detailCoffeeObject setLast_updated_at:[detailCoffeeDict objectForKey:@"last_updated_at"]];
        [detailCoffeeObject setName:[detailCoffeeDict objectForKey:@"name"]];
        CoffeeDetailViewController *coffeeDetailVC = [[CoffeeDetailViewController alloc] init];
        [coffeeDetailVC setCoffeeObject:detailCoffeeObject];
        [self.navigationController pushViewController:coffeeDetailVC animated:NO];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"not download");
    }];
    
    [operation start];
    
    
}


@end
