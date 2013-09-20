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

- (void)animatePhone1ButtonFromFrame:(CGRect)fromFrame
                             toFrame:(CGRect)toFrame
                            duration:(NSTimeInterval)duration;
{
    [self.phone1Button animateFromFrame:fromFrame
                                toFrame:toFrame
                               duration:duration];
}

- (void)animatePhone2ButtonFromFrame:(CGRect)fromFrame
                             toFrame:(CGRect)toFrame
                            duration:(NSTimeInterval)duration
{
    [self.phone2Button animateFromFrame:fromFrame
                                toFrame:toFrame
                               duration:duration];
}


@end
