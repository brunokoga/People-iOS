//
//  PeoplePhoneButton.m
//  People
//
//  Created by Bruno Koga on 9/17/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeoplePhoneButton.h"
#import "PeopleBasicTheme.h"
#import "NSNumber+PhoneNumberFormatter.h"

@interface PeoplePhoneButton ()

@end

@implementation PeoplePhoneButton

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
    UIFont *titleFont = [PeopleBasicTheme peopleFontBookWithSize:self.titleLabel.font.pointSize];
    [self.titleLabel setFont:titleFont];
    
    UIImage *image = [UIImage imageNamed:@"ico-btn-phone-normal-1"];
    [self.imageView setImage:image];
}

#pragma mark - Setter Override

- (void)setPhoneNumber:(NSNumber *)phoneNumber
{
    _phoneNumber = phoneNumber;
    [self setTitle:[@"  " stringByAppendingString:[phoneNumber formattedPhoneNumberString]]
                                         forState:UIControlStateNormal];

}

- (void)animateFromFrame:(CGRect)fromFrame
                 toFrame:(CGRect)toFrame
                duration:(NSTimeInterval)duration
{
    /*
    [CATransaction begin];
    
    NSString *animationKeyPath = @"frame";
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:animationKeyPath];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    anim.fromValue =  [NSValue valueWithCGRect:fromFrame];
    anim.toValue = [NSValue valueWithCGRect:toFrame];
    anim.duration = duration;
    
    [self.layer addAnimation:anim forKey:animationKeyPath];
    
    self.frame = toFrame;
    
    [CATransaction commit];*/
    
//    [UIView animateWithDuration:duration animations:^{
                self.frame = toFrame;
//    }];


}




@end
