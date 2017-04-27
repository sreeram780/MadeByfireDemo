//
//  HorizontalCell.m
//  MadeByFireDemo
//
//  Created by SreenivasulaReddy on 27/04/17.
//  Copyright © 2017 SreenivasulaReddy. All rights reserved.
//

#import "HorizontalCell.h"

@implementation HorizontalCell

static CGSize onLoadSize;


//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(CGSizeZero.width==onLoadSize.width && CGSizeZero.height==onLoadSize.height)
    {
        onLoadSize=self.contentView.bounds.size;
    }
    self.textLabel.frame = CGRectMake(0, 0, onLoadSize.width, onLoadSize.height);
    self.selectedBackgroundView.frame=self.textLabel.frame;
}

@end
