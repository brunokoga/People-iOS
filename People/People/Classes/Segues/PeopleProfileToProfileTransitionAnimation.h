//
//  PeopleProfileToProfileTransitionAnimation.h
//  People
//
//  Created by Bruno Koga on 9/24/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleProfileToProfileTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

- (id)initForOperation:(UINavigationControllerOperation)operation;
@end
