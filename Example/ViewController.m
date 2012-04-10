//
//  ViewController.m
//  Example
//
//  Created by Pulkit Singhal on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ESBody.h"
#import "ESResponse.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize protocol;
@synthesize address;
@synthesize port;
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

    [self runTests];
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

    // Map the root object which will be used for parsing the response
    [
     [RKObjectManager sharedManager].mappingProvider
     setMapping:[ESResponse getObjectMapping]
     forKeyPath:@""
    ];

    // Query should always hit the /_search url
    RKObjectRouter *router = [RKObjectManager sharedManager].router;
    [router routeClass:[ESBody class] toResourcePath:@"/bbyopen_index/_search"];

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
