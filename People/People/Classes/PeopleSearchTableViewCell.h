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

- (void)updateLabelsWithCollaborator:(PeopleColaborador *)collaborator;

@end
