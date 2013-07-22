//
//  PeopleBaseViewController.h
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleBaseViewController : UIViewController

- (void)performTransitionWithSegueIdentifier:(NSString *)identifier
                                  completion:(void (^)(void))completion;

@end
