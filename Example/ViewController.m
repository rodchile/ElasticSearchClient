//
//  ViewController.m
//  Example
//
//  Created by Pulkit Singhal on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ESBody.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self runTests];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Instance Methods
- (void) runTests
{
    ESBody *body = [[ESBody alloc] init];
    body.fields = [NSArray arrayWithObjects:@"name", @"upc", nil];
    body.query = [[ESQuery alloc] init];
    body.query.queryString = [[ESQueryString alloc] init];
    body.query.queryString.query = @"+camera +laptop";
    body.query.queryString.useDisMax = [NSNumber numberWithBool:true];
    
    // Map the root object inversely for serialization,
    // any nested objects will also get registered properly automagically!
    [
     [RKObjectManager sharedManager].mappingProvider
     setSerializationMapping:[[ESBody getObjectMapping] inverseMapping]
     forClass:[ESBody class]
    ];
    
    // Query should always hit the /_search url
    RKObjectRouter *router = [RKObjectManager sharedManager].router;
    [router routeClass:[ESBody class] toResourcePath:@"/bbyopen_index/_search"];
    
    [[RKObjectManager sharedManager] postObject:body delegate:self];
    //[manager loadObjectsAtResourcePath:@"/_search" delegate:self];
}

#pragma mark - RKObjectLoaderDelegate methods
- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error
{
    NSLog(@"%@", [error localizedDescription]);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
    NSLog(@"%@", objects);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObject:(id)object
{
    NSLog(@"%@", object);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjectDictionary:(NSDictionary*)dictionary
{
    NSLog(@"%@", dictionary);
}

- (void)objectLoaderDidFinishLoading:(RKObjectLoader*)objectLoader
{
    NSLog(@"%@", @"objectLoaderDidFinishLoading");
}

- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader*)objectLoader
{
    NSLog(@"%@", @"objectLoaderDidLoadUnexpectedResponse");
}

- (void)objectLoader:(RKObjectLoader*)loader willMapData:(inout id *)mappableData
{
    NSLog(@"%@", mappableData);
}

@end
