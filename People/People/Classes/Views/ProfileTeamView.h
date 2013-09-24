//
//  PeopleTeamView.h
//  People
//
//  Created by Bruno Koga on 9/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "BKXibView.h"

@interface ProfileTeamView : BKXibView
@property (nonatomic) NSArray *teamMemberNames;

- (void)setImage:(UIImage *)image
        forIndex:(NSInteger)index;

- (void)setAction:(SEL)action target:(id)target forButtonAtIndex:(NSInteger)index;

@end
