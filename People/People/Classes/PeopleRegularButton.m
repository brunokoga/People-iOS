//
//  PeopleRegularButton.m
//  People
//
//  Created by Bruno Koga on 7/22/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleRegularButton.h"
#import <BKUIAdditions/BKUIColorAdditions.h>
#import "UIButton+BKColorAdditions.h"
#import "PeopleBasicTheme.h"

@implementation PeopleRegularButton

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.layer.cornerRadius = 12.0;
    [self setClipsToBounds:YES];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)applyPrimaryColor
{
    UIControlState state;
    UIColor *color;
    state = UIControlStateNormal;
    color = [PeopleBasicTheme primaryButtonColorForState:state];
    [self setBackgroundColor:color forState:state];
    
    state = UIControlStateHighlighted;
    color = [PeopleBasicTheme primaryButtonColorForState:state];
    [self setBackgroundColor:color forState:state];
}

- (void)applyNormalTitleColorForPrimaryColor
{
    [self setTitleColor:[PeopleBasicTheme peopleColor1Primary] forState:UIControlStateNormal];
}

- (void)applyErrorTitleColorForPrimaryColor
{
    [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}



@end
