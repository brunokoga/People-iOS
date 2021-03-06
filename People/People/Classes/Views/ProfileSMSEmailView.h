//
//  ProfileSMSEmailView.h
//  People
//
//  Created by Bruno Koga on 9/22/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "BKXibView.h"

@interface ProfileSMSEmailView : BKXibView

@property (nonatomic, strong) NSAttributedString *emailAttributedString;

- (void)setSMSTarget:(id)target action:(SEL)action;
- (void)setEmailTarget:(id)target action:(SEL)action;

@end
