//
//  PeopleSearchTableViewCell.h
//  People
//
//  Created by Christian Sampaio on 7/29/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <PeopleSwipeTableViewCell/MCSwipeTableViewCell.h>

@class PeopleColaborador;

@interface PeopleSearchTableViewCell : MCSwipeTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *collaboratorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorRoleLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorLoginLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorCellphoneLabel;

@property (nonatomic, strong) UIImage *image;

- (void)updateLabelsWithCollaborator:(PeopleColaborador *)collaborator;

@end
