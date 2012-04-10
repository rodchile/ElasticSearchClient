//
//  Query.h
//  ShoppinPal
//
//  Created by Pulkit Singhal on 4/7/12.
//  Copyright (c) 2012 Fermyon Inc. All rights reserved.
//

#import "ESQueryString.h"

@interface ESQuery : NSObject

@property (nonatomic, strong) ESQueryString* queryString;

+ (RKObjectMapping*) getObjectMapping;

@end
