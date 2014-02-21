//
//  UIColor+ColorConjurer.m
//  MVC
//
//  Created by Ryo Tulman on 2/20/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "UIColor+ColorConjurer.h"

@implementation UIColor (ColorConjurer)

-(UIColor *)returnRandomColor {
    float randRed = (float)rand() / RAND_MAX;
    float randGreen = (float)rand() / RAND_MAX;
    float randBlue = (float)rand() / RAND_MAX;
    return [UIColor colorWithRed:randRed green:randGreen blue:randBlue alpha:0.1];
}

-(UIColor *)lightenGivenColor:(UIColor *)givenColor {
    return [givenColor colorWithAlphaComponent:CGColorGetAlpha(givenColor.CGColor)];
}

@end
