//
//  RTPostTableViewCell.h
//  MVC
//
//  Created by Ryo Tulman on 2/11/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTPost.h"

@interface RTPostTableViewCell : UITableViewCell

- (void)updateText;

@property (nonatomic, strong) RTPost *myPost;

@end
