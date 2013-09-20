//
//  PeopleButton.m
//  People
//
//  Created by Rafael Oda on 5/13/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import "PeopleButton.h"
#import <QuartzCore/QuartzCore.h>
#import "BKUIColorAdditions.h"
#import "PeopleBasicTheme.h"

@implementation PeopleButton

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
    [self.titleLabel setFont:[PeopleBasicTheme peopleFontBoldWithSize:self.titleLabel.font.pointSize]];
    [self.layer setCornerRadius:2.0];
    [self setClipsToBounds:YES];
    [self.titleLabel setFont:[PeopleBasicTheme peopleFontLightWithSize:self.titleLabel.font.pointSize]];
    [self setTitleColor:[UIColor whiteColor]
               forState:UIControlStateNormal];
    
    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(6.0, 0, 0, 0)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 2.0)];
}


- (void)setBackgroundColor:(UIColor *)backgroundColor
                  forState:(UIControlState)controlState
{
    UIImage *backgroundImage = [UIImage imageWithColor:backgroundColor];
    [self setBackgroundImage:backgroundImage
                    forState:controlState];
}

- (void)setImageNamed:(NSString *)imageName
{
    [self setImage:[UIImage imageNamed:imageName]
          forState:UIControlStateNormal];
}

@end