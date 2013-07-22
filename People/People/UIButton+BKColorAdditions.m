//
//  UIButton+BKColorAdditions.m
//  People
//
//  Created by Bruno Koga on 7/22/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "UIButton+BKColorAdditions.h"
#import "BKUIColorAdditions.h"

@implementation UIButton (BKColorAdditions)

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
    UIImage *backgroundImage = [UIImage imageWithColor:color];
    [self setBackgroundImage:backgroundImage forState:state];
}

@end
