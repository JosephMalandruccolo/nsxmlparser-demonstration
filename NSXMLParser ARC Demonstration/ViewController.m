//
//  ViewController.m
//  NSXMLParser ARC Demonstration
//
//  Created by Robert Ryan on 12/20/12.
//  Copyright (c) 2012 Robert M. Ryan. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "ViewController.h"

// if you use the Users Parser, you need these two:

#import "UsersParser.h"
#import "User.h"

// if you use the generic parser, you need this one:

#import "XmlArrayParser.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)pressedUserParser:(id)sender
{
    NSString *filename = [[NSBundle mainBundle] pathForResource:@"users" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:filename];

    // create and init NSXMLParser object
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    // create and init our delegate
    UsersParser *usersParser = [[UsersParser alloc] init];
    
    // set delegate
    [parser setDelegate:usersParser];
    
    // parsing...
    BOOL success = [parser parse];
    
    // test the result
    if (success)
    {
        NSMutableArray *users = [usersParser users];
        self.textView.text = [NSString stringWithFormat:
                                      @"This is an array of User objects:\n\n%@",
                                      [users description]];
        
        // User *user = [users objectAtIndex:0]; // this retrieves first user
        // NSString *userName = user.userName;   // this retrieves that user's username
        // NSLog(@"%@",userName);

        [[[UIAlertView alloc] initWithTitle:nil
                                    message:[NSString stringWithFormat:@"No errors - user count : %i", [[usersParser users] count]]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    else
    {
        NSLog(@"Error parsing document!");

        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"Error parsing document!"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (IBAction)pressedGenericParser:(id)sender
{
    NSString *filename = [[NSBundle mainBundle] pathForResource:@"users" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    
    // create and init NSXMLParser object
    XmlArrayParser *parser = [[XmlArrayParser alloc] initWithData:data];
    parser.rowElementName = @"user";
    parser.elementNames = [NSArray arrayWithObjects:@"userName", @"firstName", @"lastName", nil];
    parser.attributeNames = [NSArray arrayWithObjects:@"userId", nil];
    
    // parsing...
    BOOL success = [parser parse];
    
    // test the result
    if (success)
    {
        NSMutableArray *users = [parser items];
        
        self.textView.text = [NSString stringWithFormat:
                                      @"This is an array of dictionaries, one dictionary for each user:\n\n%@",
                                      [users description]];

        // NSDictionary *user = [users objectAtIndex:0];         // this retrieves the first user
        // NSString *userName = user[@"userName"];               // this retrieves that user's username in Xcode 4.5 and greater
        // NSString *userName = [user objectForKey:@"userName"]; // this retrieves that user's username in older versions of Xcode
        // NSLog(@"%@",userName);
        
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:[NSString stringWithFormat:@"No errors - user count : %i", [[parser items] count]]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    else
    {
        NSLog(@"Error parsing document!");

        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"Error parsing document!"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

@end
