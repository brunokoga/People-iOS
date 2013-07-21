//
//  PeopleLoginViewController.h
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleBaseViewController.h"

@interface PeopleLoginViewController : PeopleBaseViewController <UITextFieldDelegate>

- (void)performTransitionWithSegueIdentifier:(NSString *)identifier
                                  completion:(void (^)(void))completion;

@end
