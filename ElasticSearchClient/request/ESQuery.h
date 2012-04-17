//
//  ESQuery.h
//  ShoppinPal
//
//  Created by Pulkit Singhal on 4/7/12.
//  Copyright (c) 2012 Fermyon Inc. All rights reserved.
//

#import "ESQueryString.h"
#import "ESBoolQuery.h"

@interface ESQuery : NSObject

@property (nonatomic, strong) ESQueryString* query_string;
@property (nonatomic, strong) ESBoolQuery* boolQuery;

+ (RKObjectMapping*) getObjectMapping;

@end
