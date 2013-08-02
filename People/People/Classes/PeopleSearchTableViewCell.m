//
//  PeopleSearchTableViewCell.m
//  People
//
//  Created by Christian Sampaio on 7/29/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchTableViewCell.h"
#import "PeopleColaborador.h"
#import "PeopleBasicTheme.h"
#import <PeopleSwipeTableViewCell/MCSwipeTableViewCell.h>

@interface PeopleSearchTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *collaboratorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorRoleLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorLoginLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorCellphoneLabel;

@end

@implementation PeopleSearchTableViewCell

- (void)updateLabelsWithCollaborator:(PeopleColaborador *)collaborator
{
    self.collaboratorNameLabel.text = collaborator.name;
    self.collaboratorRoleLabel.text = collaborator.role;
    self.collaboratorPhoneLabel.text = collaborator.phone;
    self.collaboratorLoginLabel.text = collaborator.login;
    self.collaboratorCellphoneLabel.text = collaborator.mobile;
    
    [self addButtons];
}

- (void)addButtons
{
    self.leftMenuColor = [PeopleBasicTheme peopleColor2Secondary];
    [self addButton:[self buttonForMenuWithImageName:@"ico-swipe-phone-normal"] toCellSide:MCSwipeTableViewCellSideLeft];
    [self addButton:[self buttonForMenuWithImageName:@"ico-swipe-mobile-normal"] toCellSide:MCSwipeTableViewCellSideLeft];
    [self addButton:[self buttonForMenuWithImageName:@"ico-swipe-mail-normal"] toCellSide:MCSwipeTableViewCellSideLeft];
    [self addButton:[self buttonForMenuWithImageName:@"ico-swipe-sms-normal"] toCellSide:MCSwipeTableViewCellSideLeft];
}

- (UIButton *)buttonForMenuWithImageName:(NSString *)imageName
{
    UIImage *buttonImage = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    button.frame = (CGRect){CGPointZero, buttonImage.size};
    return button;
}

@end
