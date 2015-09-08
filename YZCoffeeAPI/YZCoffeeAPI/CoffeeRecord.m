//
//  CoffeeRecord.m
//  YZCoffeeAPI
//
//  Created by Yan Zhang on 9/4/15.
//  Copyright (c) 2015 Yan Zhang. All rights reserved.
//

#import "CoffeeRecord.h"

@implementation CoffeeRecord

- (BOOL)hasImage{
    return _image != nil;
}

- (BOOL)isFailed{
    return _failed;
}

@end
