//
//  RTPostTableViewCell.m
//  MVC
//
//  Created by Ryo Tulman on 2/11/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTPostTableViewCell.h"

@implementation RTPostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
