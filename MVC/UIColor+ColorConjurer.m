//
//  UIColor+ColorConjurer.m
//  MVC
//
//  Created by Ryo Tulman on 2/20/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "UIColor+ColorConjurer.h"

@implementation UIColor (ColorConjurer)

+(UIColor *)returnRandomColor {
    float randRed = (float)rand() / RAND_MAX;
    float randGreen = (float)rand() / RAND_MAX;
    float randBlue = (float)rand() / RAND_MAX;
    NSLog(@"%f, %f, %f", randRed, randGreen, randBlue);
    return [UIColor colorWithRed:randRed green:randGreen blue:randBlue alpha:1.0];
}

+(UIColor *)lightenGivenColor:(UIColor *)givenColor {
    //return [UIColor blueColor];
    CGFloat r,g,b,a;
    [givenColor getRed:&r green:&g blue:&b alpha:&a];
    
    return [UIColor colorWithRed:r*1.1 green:g*1.1 blue:b*1.1 alpha:1.0];
//    return [givenColor colorWithAlphaComponent:CGColorGetAlpha(givenColor.CGColor)*0.6];
}

@end
