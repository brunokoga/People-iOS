//
//  ProfilePhoneNumbersView.m
//  People
//
//  Created by Bruno Koga on 9/9/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "ProfilePhoneNumbersView.h"

@interface ProfilePhoneNumbersView ()

@end

@implementation ProfilePhoneNumbersView

- (id)init
{
    self = [super init];
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
    [self.phone1Button setTitle:@"" forState:UIControlStateNormal];
    [self.phone2Button setTitle:@"" forState:UIControlStateNormal];
}
@end
