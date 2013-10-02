//
//  PeopleContactServices.h
//  People
//
//  Created by Christian Sampaio on 10/2/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleContactServices : NSObject

+ (instancetype)sharedServices;

- (void)presentEmailComposerOnViewController:(UIViewController *)controller
                              withRecipients:(NSArray *)recipients;

- (void)presentSMSComposerOnViewController:(UIViewController *)controller
                            withRecipients:(NSArray *)recipients;

- (void)callPhoneNumber:(NSNumber *)phoneNumber;

@end
