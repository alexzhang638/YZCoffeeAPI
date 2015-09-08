//
//  CoffeeRecord.h
//  YZCoffeeAPI
//
//  Created by Yan Zhang on 9/4/15.
//  Copyright (c) 2015 Yan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CoffeeRecord : NSObject
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *coffeeId;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *last_updated_at;
@property (nonatomic, readonly) BOOL hasImage;
@property (nonatomic, getter=isFailed) BOOL failed;

@end
