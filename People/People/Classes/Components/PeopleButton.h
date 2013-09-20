//
//  PeopleButton.h
//  People
//
//  Created by Rafael Oda on 5/13/13.
//  Copyright (c) 2013 Ci&T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleButton : UIButton

- (void)setBackgroundColor:(UIColor *)backgroundColor
                  forState:(UIControlState)controlState;

/*
 it's here to be called by children
 */
- (void)setup;

- (void)setImageNamed:(NSString *)imageName;

@end