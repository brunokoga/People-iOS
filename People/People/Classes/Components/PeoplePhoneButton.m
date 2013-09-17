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
    self.titleLabel.text = [@"  " stringByAppendingString:[phoneNumber formattedPhoneNumberString]];
}



@end
