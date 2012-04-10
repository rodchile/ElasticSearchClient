//
//  QueryString.h
//  ShoppinPal
//
//  Created by Pulkit Singhal on 4/7/12.
//  Copyright (c) 2012 Fermyon Inc. All rights reserved.
//

@interface ESQueryString : NSObject

@property (nonatomic, strong) NSString* query;
@property (nonatomic, strong) NSNumber* useDisMax;

+ (RKObjectMapping*) getObjectMapping;

@end