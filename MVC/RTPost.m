//
//  RTPost.m
//  MVC
//
//  Created by Ryo Tulman on 2/11/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTPost.h"

@implementation RTPost

- (id)initWithDictionary:(NSDictionary *)postDictionary {
    self = [super init];
    if (self) {
        self.user = [postDictionary objectForKey:@"user"];
        self.title = [postDictionary objectForKey:@"title"];
        self.content = [postDictionary objectForKey:@"content"];
        self.date = [NSDate date];
    }
    return self;
}

@end
