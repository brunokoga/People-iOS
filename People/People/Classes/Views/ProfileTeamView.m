//
//  PeopleTeamView.m
//  People
//
//  Created by Bruno Koga on 9/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "ProfileTeamView.h"
#import "PeopleCircularImageView.h"
#import "PeopleCircularButton.h"

@interface ProfileTeamView ()
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UIView *teamView;
@property (strong, nonatomic) NSArray *teamMemberViews;

@end

@implementation ProfileTeamView

- (void)setup
{
}

- (void)setTeamCount:(NSInteger)count
{
    NSString *teamString = NSLocalizedString(@"Team", @"Team title on Profile Screen");
    teamString = [teamString stringByAppendingFormat:@" (%d)", count];
    [self.teamLabel setText:teamString];
    
}

- (void)cleanTeamMembersView
{
    for (UIView *subview in [self.teamView subviews])
    {
        [subview removeFromSuperview];
    }
}

#define kPeopleMaxTeamList 7
#define kPeopleCircularTeamWidth 45
#define kPeopleTeamSpace 16
#define kPeopleTeamListVerticalSpacePercentage 0.15
#define kPeopleTeamMoreButtonWidth 30.0

- (void)createTeamMemberViewsWithCount:(NSInteger)count
{
    [self cleanTeamMembersView];
    
    int numberOfFaces = MIN(count, kPeopleMaxTeamList);
    CGFloat horizontalOffset = self.center.x -(numberOfFaces-1) * (kPeopleTeamSpace) - kPeopleTeamMoreButtonWidth/3 ;
    CGFloat verticalOffset = self.center.y - self.frame.origin.y + kPeopleTeamListVerticalSpacePercentage*self.frame.size.height;
    for (int i = 0; i < numberOfFaces; i++)
    {
        
        CGRect frame = CGRectMake(0, 0, kPeopleCircularTeamWidth, kPeopleCircularTeamWidth);
        CGPoint center = CGPointMake(horizontalOffset, verticalOffset);
        PeopleCircularButton *circularButton = [[PeopleCircularButton alloc] initWithFrame:frame];
        [circularButton setCenter:center];
        [circularButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        circularButton.tag = i;
        [self.teamView addSubview:circularButton];
        horizontalOffset += 2*kPeopleTeamSpace;
    }
    UIButton *moreButton = [self createMoreButton];
    [moreButton setCenter:CGPointMake(horizontalOffset - kPeopleTeamMoreButtonWidth/3, verticalOffset)];
    [self.teamView addSubview:moreButton];
}

- (void)buttonTouched:(id)sender
{
    
}

- (UIButton *)createMoreButton
{
    return [UIButton buttonWithType:UIButtonTypeCustom];
}

- (void)setImage:(UIImage *)image
        forIndex:(NSInteger)index
{
    if ([self.teamMemberNames count] > index)
    {
        PeopleCircularButton *button = (PeopleCircularButton *)[self.teamMemberViews objectAtIndex:index];
        [button setImage:image forState:UIControlStateNormal];
        
    }
    //throw excp
}

- (void)setTeamMemberNames:(NSArray *)teamMemberNames
{
    _teamMemberNames = teamMemberNames;
    NSInteger count = teamMemberNames.count;
    [self setTeamCount:count];
    [self createTeamMemberViewsWithCount:count];
}


@end
