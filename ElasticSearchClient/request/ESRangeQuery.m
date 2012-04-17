//
//  ESRangeQuery.m
//  ElasticSearchClient
//
//  Created by Pulkit Singhal on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRangeQuery.h"

@implementation ESRangeQuery

@synthesize key_field, from, to, include_lower, include_upper, boost;

+ (RKObjectMapping *) getObjectMapping
{
    RKObjectMapping* objectMapping = [RKObjectMapping mappingForClass:[ESRangeQuery class]];

    [objectMapping mapKeyOfNestedDictionaryToAttribute:@"key_field"];
    [objectMapping mapKeyPath:@"(key_field).from"           toAttribute:@"from"];
    [objectMapping mapKeyPath:@"(key_field).to"             toAttribute:@"to"];
    [objectMapping mapKeyPath:@"(key_field).include_lower"  toAttribute:@"include_lower"];
    [objectMapping mapKeyPath:@"(key_field).include_upper"  toAttribute:@"include_upper"];
    [objectMapping mapKeyPath:@"(key_field).boost"          toAttribute:@"boost"];

    return objectMapping;
}

@end
