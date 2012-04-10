//
//  QueryString.m
//  ShoppinPal
//
//  Created by Pulkit Singhal on 4/7/12.
//  Copyright (c) 2012 Fermyon Inc. All rights reserved.
//

#import "ESQueryString.h"

@implementation ESQueryString

@synthesize query, useDisMax;

+ (RKObjectMapping *) getObjectMapping
{
    RKObjectMapping* objectMapping = [RKObjectMapping mappingForClass:[ESQueryString class]];
    [objectMapping mapKeyPath:@"query"          toAttribute:@"query"];
    [objectMapping mapKeyPath:@"use_dis_max"    toAttribute:@"useDisMax"];
    return objectMapping;
}

@end
