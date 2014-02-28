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
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCell:(RTPost *)thisPost {
    self.myPost = thisPost;
    self.textLabel.text = self.myPost.user;
    self.detailTextLabel.text = [self.myPost.title stringByAppendingString:self.myPost.content];
    self.backgroundColor = self.myPost.postColor;
    self.imageView.image = self.myPost.postPic;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    self.imageView.clipsToBounds = YES;
}

@end
