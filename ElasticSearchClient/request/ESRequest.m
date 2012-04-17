//
//  ESBody.m
//  ShoppinPal
//
//  Created by Pulkit Singhal on 4/9/12.
//  Copyright (c) 2012 Fermyon Inc. All rights reserved.
//

#import "ESBody.h"

@implementation ESBody

@synthesize from, size, fieldsToQueryFor, query;

+ (RKObjectMapping *) getObjectMapping
{
    RKObjectMapping* objectMapping = [RKObjectMapping mappingForClass:[ESBody class]];

    [objectMapping mapKeyPath:@"from"   toAttribute:@"from"];
    [objectMapping mapKeyPath:@"size"   toAttribute:@"size"];
    [objectMapping mapKeyPath:@"fields" toAttribute:@"fieldsToQueryFor"];

    [objectMapping mapKeyPath:@"query"
               toRelationship:@"query"
                  withMapping:[ESQuery getObjectMapping]];
    
    return objectMapping;
}

@end
