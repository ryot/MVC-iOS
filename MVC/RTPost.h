//
//  RTPost.h
//  MVC
//
//  Created by Ryo Tulman on 2/11/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTPost : NSObject <NSCoding>

- (id)initWithDictionary:(NSDictionary *)postDictionary;

@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UIColor *postColor;

@end
