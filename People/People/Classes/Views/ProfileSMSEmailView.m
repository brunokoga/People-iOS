//
//  ProfileSMSEmailView.m
//  People
//
//  Created by Bruno Koga on 9/22/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "ProfileSMSEmailView.h"
@interface ProfileSMSEmailView ()
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *smsButton;

@end

@implementation ProfileSMSEmailView

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
    [super setup];
    [self.smsButton setTitle:NSLocalizedString(@"Send iMessage/SMS", @"Send iMessage/SMS button on Profile Screen")
                    forState:UIControlStateNormal];
}

- (IBAction)smsButtonTouched:(id)sender {

}

- (IBAction)emailButtonTouched:(id)sender {
}

- (void)setEmailAttributedString:(NSAttributedString *)emailAttributedString
{
    _emailAttributedString = emailAttributedString;
    [self.emailButton setAttributedTitle:emailAttributedString
                                forState:UIControlStateNormal];
}

@end
