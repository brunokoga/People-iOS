//
//  PeopleCircularImageView.m
//  People
//
//  Created by Bruno Koga on 5/1/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import "PeopleCircularImageView.h"
#import "UIView+CircularFrame.h"

@implementation PeopleCircularImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    CGFloat percentage = 92.0/100.0;
    CGFloat reducedWidth = self.frame.size.width * percentage;
    CGFloat reducedHeight = self.frame.size.height * percentage;
    CGRect imageViewFrame = CGRectMake((self.frame.size.width - reducedWidth)/2, (self.frame.size.height - reducedHeight)/2, reducedWidth, reducedHeight);
   _imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [self addSubview:_imageView];
    self.backgroundColor = [UIColor clearColor];
    [self setDiameter:self.frame.size.width];
    
    [self makeCircular];
    [[self imageView] makeCircular];
}

@end
