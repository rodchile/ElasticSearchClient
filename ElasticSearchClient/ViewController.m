//
//  ViewController.m
//  Example
//
//  Created by Pulkit Singhal on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ESRequest.h"
#import "ESResponse.h"
#import "ESWrapper.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize protocol;
@synthesize address;
@synthesize port;
@synthesize index;
@synthesize request;
@synthesize response;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"config.plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];

    self.protocol.text  = [plistData objectForKey:@"protocol"];
    self.address.text   = [plistData objectForKey:@"address"];
    self.port.text      = [plistData objectForKey:@"port"];
    self.index.text     = [plistData objectForKey:@"index"];
}

- (void)viewDidUnload
{
    [self setProtocol:nil];
    [self setAddress:nil];
    [self setPort:nil];
    [self setRequest:nil];
    [self setResponse:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Instance Methods
- (IBAction) testQueryStringQuery : (id) sender
{
    ESRequest *body = [[ESRequest alloc] init];
    body.from = [NSNumber numberWithInt:0];
    body.size = [NSNumber numberWithInt:2];
    body.fieldsToQueryFor = [NSArray arrayWithObjects:@"name", @"upc", nil];
    body.query = [[ESQuery alloc] init];

    ESQueryString *queryString = [[ESQueryString alloc] init];
    queryString.fieldsToQueryOn = [NSArray arrayWithObjects:@"name", nil];
    queryString.query = @"+camera +laptop";
    queryString.use_dis_max = [NSNumber numberWithBool:true];

    body.query.query_string = queryString;

    // Map the root object inversely for serialization,
    // any nested objects will also get registered properly automagically!
    [
     [RKObjectManager sharedManager].mappingProvider
     setSerializationMapping:[[ESRequest getObjectMapping] inverseMapping]
     forClass:[ESRequest class]
    ];

    // Map the root object which will be used for parsing the response
    [
     [RKObjectManager sharedManager].mappingProvider
     setMapping:[ESResponse getObjectMapping]
     forKeyPath:@""
    ];

    [[RKObjectManager sharedManager] postObject:body
                                     usingBlock:^ (RKObjectLoader *loader) {
                                         loader.targetObject = nil;
                                         loader.delegate = self;
                                     }];
}

- (IBAction) testRangeQuery : (id) sender
{
    ESRequest *body = [[ESRequest alloc] init];
    body.from = [NSNumber numberWithInt:0];
    body.size = [NSNumber numberWithInt:2];
    body.fieldsToQueryFor = [NSArray arrayWithObjects:@"name", @"upc", nil];
    body.query = [[ESQuery alloc] init];

    ESRangeQuery *range = [[ESRangeQuery alloc] init];
    range.key_field = @"salePrice";
    range.from = [NSNumber numberWithInt:10];
    range.to = [NSNumber numberWithInt:20];
    range.include_lower = [NSNumber numberWithBool:true];
    range.include_upper = [NSNumber numberWithBool:false];
    range.boost = [NSNumber numberWithInt:2];

    body.query.rangeQuery = range;

    // Map the root object inversely for serialization,
    // any nested objects will also get registered properly automagically!
    [
     [RKObjectManager sharedManager].mappingProvider
     setSerializationMapping:[[ESRequest getObjectMapping] inverseMapping]
     forClass:[ESRequest class]
    ];

    // Map the root object which will be used for parsing the response
    [
     [RKObjectManager sharedManager].mappingProvider
     setMapping:[ESResponse getObjectMapping]
     forKeyPath:@""
    ];

    //[[RKObjectManager sharedManager] postObject:body delegate:self];
    [[RKObjectManager sharedManager] postObject:body
                                     usingBlock:^ (RKObjectLoader *loader) {
                                         loader.targetObject = nil;
                                         loader.delegate = self;
                                     }];
}

- (IBAction) testBoolQueryWithNestedQueryStringQuery : (id) sender
{
    ESRequest *body = [[ESRequest alloc] init];
    body.from = [NSNumber numberWithInt:0];
    body.size = [NSNumber numberWithInt:2];
    body.fieldsToQueryFor = [NSArray arrayWithObjects:@"name", @"upc", nil];
    body.query = [[ESQuery alloc] init];

    ESQueryString *queryString = [[ESQueryString alloc] init];
    queryString.fieldsToQueryOn = [NSArray arrayWithObjects:@"name", nil];
    queryString.query = @"+camera +laptop";
    queryString.use_dis_max = [NSNumber numberWithBool:true];

    body.query.boolQuery = [[ESBoolQuery alloc] init];

    ESWrapper *wrapper = [[ESWrapper alloc] init];
    wrapper.query_string = queryString;

    body.query.boolQuery.must = [NSArray arrayWithObjects:wrapper, nil];

    // Map the root object inversely for serialization,
    // any nested objects will also get registered properly automagically!
    [
     [RKObjectManager sharedManager].mappingProvider
     setSerializationMapping:[[ESRequest getObjectMapping] inverseMapping]
     forClass:[ESRequest class]
    ];

    // Map the root object which will be used for parsing the response
    [
     [RKObjectManager sharedManager].mappingProvider
     setMapping:[ESResponse getObjectMapping]
     forKeyPath:@""
    ];

    [[RKObjectManager sharedManager] postObject:body
                                     usingBlock:^ (RKObjectLoader *loader) {
                                         loader.targetObject = nil;
                                         loader.delegate = self;
                                     }];
}

- (IBAction) testBoolQueryWithNestedRangeQuery : (id) sender
{
    ESRequest *body = [[ESRequest alloc] init];
    body.from = [NSNumber numberWithInt:0];
    body.size = [NSNumber numberWithInt:2];
    body.fieldsToQueryFor = [NSArray arrayWithObjects:@"name", @"upc", nil];
    body.query = [[ESQuery alloc] init];

    body.query.boolQuery = [[ESBoolQuery alloc] init];

    ESRangeQuery *range = [[ESRangeQuery alloc] init];
    range.key_field = @"salePrice";
    range.from = [NSNumber numberWithInt:10];
    range.to = [NSNumber numberWithInt:20];
    range.include_lower = [NSNumber numberWithBool:true];
    range.include_upper = [NSNumber numberWithBool:false];
    range.boost = [NSNumber numberWithInt:2];

    ESWrapper *wrapper = [[ESWrapper alloc] init];
    wrapper.range = range;
    body.query.boolQuery.must = [NSArray arrayWithObjects:wrapper, nil];

    // Map the root object inversely for serialization,
    // any nested objects will also get registered properly automagically!
    [
     [RKObjectManager sharedManager].mappingProvider
     setSerializationMapping:[[ESRequest getObjectMapping] inverseMapping]
     forClass:[ESRequest class]
    ];

    // Map the root object which will be used for parsing the response
    [
     [RKObjectManager sharedManager].mappingProvider
     setMapping:[ESResponse getObjectMapping]
     forKeyPath:@""
    ];

    //[[RKObjectManager sharedManager] postObject:body delegate:self];
    [[RKObjectManager sharedManager] postObject:body
                                     usingBlock:^ (RKObjectLoader *loader) {
                                         loader.targetObject = nil;
                                         loader.delegate = self;
                                     }];
}

#pragma mark - RKObjectLoaderDelegate methods
- (void) objectLoader : (RKObjectLoader*)objectLoader
     didFailWithError : (NSError*)error
{
    NSLog(@"%@", [error localizedDescription]);
}

- (void) objectLoader : (RKObjectLoader*)objectLoader
       didLoadObjects : (NSArray*)objects
{
    NSLog(@"%@", objects);
}

- (void) objectLoader : (RKObjectLoader*)objectLoader
        didLoadObject : (id)object
{
    NSLog(@"%@", object);
}

- (void)    objectLoader : (RKObjectLoader*)objectLoader
 didLoadObjectDictionary : (NSDictionary*)dictionary
{
    NSLog(@"%@", dictionary);
    ESResponse *esResponse = [dictionary objectForKey:@""];
    self.response.text = [esResponse description];
    /*NSArray *hits = esResponse.hitMetrics.hits;
    NSLog(@"%@", hits);
    NSLog(@"%@", ((ESHit*)[hits objectAtIndex:0]).identifier);*/
}

- (void) objectLoaderDidFinishLoading : (RKObjectLoader*)objectLoader
{
    NSLog(@"%@", @"objectLoaderDidFinishLoading");
}

- (void) objectLoaderDidLoadUnexpectedResponse : (RKObjectLoader*)objectLoader
{
    NSLog(@"%@", @"objectLoaderDidLoadUnexpectedResponse");
}

/*- (void) objectLoader : (RKObjectLoader*)loader
          willMapData : (inout id *)mappableData
{
    NSLog(@"%@", mappableData);
}*/

@end
