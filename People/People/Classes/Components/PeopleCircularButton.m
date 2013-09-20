//
//  PeopleCircularButton.m
//  People
//
//  Created by Bruno Koga on 5/24/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import "PeopleCircularButton.h"
#import "UIView+CircularFrame.h"
#import "UIButton+CircularFrame.h"
#import "PeopleTheme.h"
@implementation PeopleCircularButton

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
   _buttonImageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [_buttonImageView setUserInteractionEnabled:NO];
    [_buttonImageView setExclusiveTouch:NO];
    [self addSubview:self.buttonImageView];
    [self setDiameter:self.frame.size.width];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self makeCircular];
    [self.buttonImageView makeCircular];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self.buttonImageView setAlpha:highlighted?0.8:1.0];
}
@end
