//
//  ProfileProjectsView.h
//  People
//
//  Created by Bruno Koga on 9/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "BKXibView.h"

@interface ProfileProjectsView : BKXibView



@property (nonatomic, strong) NSArray *pastProjects;
@property (nonatomic, strong) NSArray *currentProjects;

//it's prefered to use this instead of properties
- (void)setPastProjects:(NSArray *)pastProjects currentProjects:(NSArray *)currentProjects;

- (CGFloat)totalHeight;

@end
