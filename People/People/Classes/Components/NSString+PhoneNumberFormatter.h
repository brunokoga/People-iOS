//
//  NSString+PhoneNumberFormatter.h
//  People
//
//  Created by Bruno Koga on 9/17/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PhoneNumberFormatter)

- (NSString *)phoneNumberFormat;

- (NSAttributedString *)ciandtEmailWithFocusOnLogin;
- (NSString *)ciandtEmail;
@end
