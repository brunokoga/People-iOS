//
//  ProfilePhoneNumbersView.h
//  People
//
//  Created by Bruno Koga on 9/9/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "BKXibView.h"
#import "PeoplePhoneButton.h"

@interface ProfilePhoneNumbersView : BKXibView

@property (weak, nonatomic) IBOutlet PeoplePhoneButton *phone1Button;
@property (weak, nonatomic) IBOutlet PeoplePhoneButton *phone2Button;

- (void)animatePhone1ButtonFromFrame:(CGRect)fromFrame
                             toFrame:(CGRect)toFrame
                            duration:(NSTimeInterval)duration;

- (void)animatePhone2ButtonFromFrame:(CGRect)fromFrame
                             toFrame:(CGRect)toFrame
                            duration:(NSTimeInterval)duration;




@end
