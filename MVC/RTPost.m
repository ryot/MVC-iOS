//
//  RTPost.m
//  MVC
//
//  Created by Ryo Tulman on 2/11/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTPost.h"
#import "UIColor+ColorConjurer.h"

@implementation RTPost

- (id) init {
    self = [super init];
    if (self) {
        self.date = [NSDate date];
        self.postColor = [UIColor returnRandomColor];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)postDictionary {
    self = [super init];
    if (self) {
        self.user = [postDictionary objectForKey:@"user"];
        self.title = [postDictionary objectForKey:@"title"];
        self.content = [postDictionary objectForKey:@"content"];
        self.date = [NSDate date];
        self.postColor = [UIColor returnRandomColor];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.postColor forKey:@"color"];

}
-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.user = [aDecoder decodeObjectForKey:@"user"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.postColor = [aDecoder decodeObjectForKey:@"color"];
    }
    return self;
}

@end
