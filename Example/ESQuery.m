//
//  Query.m
//  ShoppinPal
//
//  Created by Pulkit Singhal on 4/7/12.
//  Copyright (c) 2012 Fermyon Inc. All rights reserved.
//

#import "ESQuery.h"

@implementation ESQuery

@synthesize queryString;

+ (RKObjectMapping *) getObjectMapping
{
    RKObjectMapping* objectMapping = [RKObjectMapping mappingForClass:[ESQuery class]];

    [objectMapping mapKeyPath:@"query_string"
               toRelationship:@"queryString"
                  withMapping:[ESQueryString getObjectMapping]];

    return objectMapping;
}

@end
