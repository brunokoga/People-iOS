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
#import "PeopleCircularImageView.h"

@interface PeopleSearchTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *collaboratorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorRoleLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorLoginLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorCellphoneLabel;
@property (weak, nonatomic) IBOutlet PeopleCircularImageView *collaboratorImageView;
@end

@implementation PeopleSearchTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.collaboratorNameLabel.font = [PeopleBasicTheme peopleFontBookWithSize:self.collaboratorNameLabel.font.pointSize];
    self.collaboratorRoleLabel.font = [PeopleBasicTheme peopleFontBookWithSize:self.collaboratorRoleLabel.font.pointSize];
    self.collaboratorPhoneLabel.font = [PeopleBasicTheme peopleFontBookWithSize:self.collaboratorPhoneLabel.font.pointSize];
    self.collaboratorLoginLabel.font = [PeopleBasicTheme peopleFontBookWithSize:self.collaboratorLoginLabel.font.pointSize];
    self.collaboratorCellphoneLabel.font = [PeopleBasicTheme peopleFontBookWithSize:self.collaboratorCellphoneLabel.font.pointSize];
    
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    self.layer.borderWidth = 1.0f;
    
    self.imageView.backgroundColor = [UIColor clearColor];
}

- (void)updateLabelsWithCollaborator:(PeopleColaborador *)collaborator
{
    self.collaboratorNameLabel.text = collaborator.name;
    self.collaboratorRoleLabel.text = collaborator.role;
    self.collaboratorPhoneLabel.text = collaborator.phone;
    self.collaboratorLoginLabel.text = collaborator.login;
    self.collaboratorCellphoneLabel.text = collaborator.mobile;
    
    //    [self addButtonsWithCollaborator:collaborator];
}

- (void)addButtonsWithCollaborator:(PeopleColaborador *)collaborator
{
    self.leftMenuColor = [PeopleBasicTheme peopleColor2Secondary];
    if (self.collaboratorPhoneLabel.text.length)
    {
        [self addButton:[self buttonForMenuWithImageName:@"ico-swipe-phone-normal"] toCellSide:MCSwipeTableViewCellSideLeft];
    }
    
    if (self.collaboratorCellphoneLabel.text.length)
    {
        [self addButton:[self buttonForMenuWithImageName:@"ico-swipe-mobile-normal"] toCellSide:MCSwipeTableViewCellSideLeft];
        [self addButton:[self buttonForMenuWithImageName:@"ico-swipe-sms-normal"] toCellSide:MCSwipeTableViewCellSideLeft];
    }
    
    if (collaborator.email.length)
    {
        [self addButton:[self buttonForMenuWithImageName:@"ico-swipe-mail-normal"] toCellSide:MCSwipeTableViewCellSideLeft];
    }
    
}

- (UIButton *)buttonForMenuWithImageName:(NSString *)imageName
{
    UIImage *buttonImage = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    button.frame = (CGRect){CGPointZero, buttonImage.size};
    return button;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.collaboratorImageView.imageView.image = image;
    UIColor *backgroundColor = [UIColor clearColor];
    if (image)
    {
        backgroundColor = [UIColor grayColor];
    }
    self.collaboratorImageView.backgroundColor = backgroundColor;
    
}



@end
