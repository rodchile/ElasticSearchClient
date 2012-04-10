//
//  ESBody.h
//  ShoppinPal
//
//  Created by Pulkit Singhal on 4/9/12.
//  Copyright (c) 2012 Fermyon Inc. All rights reserved.
//

#import "ESQuery.h"

@interface ESBody : NSObject

@property (nonatomic, strong) NSArray* fields;
@property (nonatomic, strong) ESQuery* query;

+ (RKObjectMapping *) getObjectMapping;

@end
