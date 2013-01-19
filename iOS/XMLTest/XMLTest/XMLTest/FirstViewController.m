//
//  FirstViewController.m
//  XMLTest
//
//  Created by Javi on 17/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUnknownXML {
    NSString *const URL = @"https://some/HTTPS/url";
    NSURL* url = [NSURL URLWithString:URL];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser parse];
}
@end
