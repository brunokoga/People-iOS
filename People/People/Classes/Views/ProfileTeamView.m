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
#import "PeopleButton.h"
#import "PeopleBasicTheme.h"
@interface ProfileTeamView ()
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UIView *teamView;
@property (strong, nonatomic) NSMutableArray *teamMemberViews;

@end

@implementation ProfileTeamView

- (void)setup
{
    [self configureFonts];
}

- (void)configureFonts
{
    UIFont *teamLabelFont = [PeopleBasicTheme peopleFontBookWithSize:self.teamLabel.font.pointSize];
    [self.teamLabel setFont:teamLabelFont];
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
    self.teamMemberViews = [NSMutableArray array];
}

#define kPeopleMaxTeamList 6
#define kPeopleCircularTeamWidth 45
#define kPeopleTeamSpace 19
#define kPeopleTeamMoreButtonWidth 45.0

- (void)createTeamMemberViewsWithCount:(NSInteger)count
{
    [self cleanTeamMembersView];
    
    int numberOfFaces = MIN(count, kPeopleMaxTeamList);
    CGFloat horizontalOffset = self.center.x -(numberOfFaces - 1) * (kPeopleTeamSpace) - kPeopleTeamMoreButtonWidth/3 ;
    CGFloat verticalOffset = self.teamView.frame.origin.y - 10.0;
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
        
        [self.teamMemberViews addObject:circularButton];
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
    PeopleButton *moreButton = [[PeopleButton alloc] initWithFrame:CGRectMake(0, 0, kPeopleTeamMoreButtonWidth, kPeopleTeamMoreButtonWidth)];
    [moreButton setImageEdgeInsets:UIEdgeInsetsMake(1.0, 1.0, 0, 0)];
    UIImage *moreButtonImage = [UIImage imageNamed:@"btn-viewall-team"];
    //    UIImage *backgroundImage = [UIImage imageWithColor:[PeopleTheme peoplePink]];
    //    [moreButton setBackgroundImage:backgroundImage
    //                          forState:UIControlStateNormal];
    [moreButton setImage:moreButtonImage
                forState:UIControlStateNormal];
    
    [moreButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];

    return moreButton;


}

- (void)setImage:(UIImage *)image
        forIndex:(NSInteger)index
{
    if ([self.teamMemberNames count] > index)
    {
        if ([self.teamMemberViews count] > index) {
        PeopleCircularButton *button = (PeopleCircularButton *)[self.teamMemberViews objectAtIndex:index];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        }
        
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

- (void)setAction:(SEL)action target:(id)target forButtonAtIndex:(NSInteger)index
{
    if ([self.teamMemberViews count] > index)
    {
        PeopleCircularButton *button = (PeopleCircularButton *)[self.teamMemberViews objectAtIndex:index];
        button.tag = index;
        [button addTarget:target
                   action:action
         forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
