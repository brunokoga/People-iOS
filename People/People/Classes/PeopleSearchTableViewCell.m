//
//  PeopleSearchTableViewCell.m
//  People
//
//  Created by Christian Sampaio on 7/29/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchTableViewCell.h"
#import <PeopleSwipeTableViewCell/MCSwipeTableViewCell.h>

@implementation PeopleSearchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
