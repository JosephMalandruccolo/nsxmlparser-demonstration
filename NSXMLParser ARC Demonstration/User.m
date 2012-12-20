//
//  User.m
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

#import "User.h"

@implementation User

// this isn't needed, but it's useful for NSLogging the user

- (NSString *)description
{
    NSMutableArray *results = [NSMutableArray array];
    
    if (self.userName)
        [results addObject:[NSString stringWithFormat:@"userName: %@", self.userName]];
    if (self.firstName)
        [results addObject:[NSString stringWithFormat:@"firstName: %@", self.firstName]];
    if (self.lastName)
        [results addObject:[NSString stringWithFormat:@"lastName: %@", self.lastName]];
    
    return [NSString stringWithFormat:@"<User: %p; %@>", self, [results componentsJoinedByString:@"; "]];
}

@end
