//
//  RTStartingPosts.m
//  MVC
//
//  Created by Ryo Tulman on 2/13/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTStartingPosts.h"
#import "RTPost.h"

@implementation RTStartingPosts

- (id)init {
    self = [super init];
    if (self) {
        for (NSInteger i = 0; i < 10; i++) {
            NSArray *postKeyArray = [[NSArray alloc] initWithObjects:@"user",@"title",@"content", nil];
            NSArray *postValueArray = [[NSArray alloc] initWithObjects:[self randomName],[self randomTitle],[self randomContent], nil];
            NSDictionary *postDict = [[NSDictionary alloc] initWithObjects:postValueArray forKeys:postKeyArray];
            RTPost *newPost = [[RTPost alloc] initWithDictionary:postDict];
            [self.generatedPosts addObject:newPost];
        }
    }
    return self;
}

- (NSString *)randomName {
    NSString *content;
    NSUInteger r = arc4random_uniform(10);
    if (r > 7) {
        content = @"Adam";
    } else if(r > 5) {
        content = @"Eve";
    } else if (r > 3) {
        content = @"John";
    } else {
        content = @"Jane";
    }
    return content;
}

- (NSString *)randomTitle {
    NSString *content;
    NSUInteger r = arc4random_uniform(10);
    if (r > 7) {
        content = @"LOL";
    } else if(r > 5) {
        content = @"WTF";
    } else if (r > 3) {
        content = @"OMG";
    } else {
        content = @"FTW";
    }
    return content;
}

- (NSString *)randomContent {
    NSString *content;
    NSUInteger r = arc4random_uniform(10);
    if (r > 7) {
        content = @"I am confused O_O";
    } else if(r > 5) {
        content = @"I am superior -_-";
    } else if (r > 3) {
        content = @"I am hungry >_<";
    } else {
        content = @"Yo dawg ^_^";
    }
    return content;
}

@end
