//
//  ProfileProjectsView.m
//  People
//
//  Created by Bruno Koga on 9/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "ProfileProjectsView.h"
#import "PeopleBasicTheme.h"

@interface ProfileProjectsView ()
@property (weak, nonatomic) IBOutlet UILabel *projectsTitle;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *pastLabel;


@end

@implementation ProfileProjectsView

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    [super setup];

    UIFont *projectsTitleFont = [PeopleBasicTheme peopleFontBookWithSize:self.projectsTitle.font.pointSize];
    [self.projectsTitle setFont:projectsTitleFont];
}

#pragma mark - Setter Override

- (void)setPastProjects:(NSArray *)pastProjects
{
    _pastProjects = pastProjects;
    [self redraw];
}

- (void)setCurrentProjects:(NSArray *)currentProjects
{
    _currentProjects = currentProjects;
    [self redraw];
}

- (void)redraw
{
    
}
@end
