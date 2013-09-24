//
//  PeopleNameView.m
//  People
//
//  Created by Bruno Koga on 9/9/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "ProfileNameView.h"
#import "PeopleBasicTheme.h"

@implementation ProfileNameView

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
    [self configureFonts];
}

- (void)configureFonts
{
    UIFont *baseFont = [PeopleBasicTheme peopleFontBookWithSize:self.baseLabel.font.pointSize];
    [self.baseLabel setFont:baseFont];
    
    UIFont *buildingFont = [PeopleBasicTheme peopleFontBookWithSize:self.buildingLabel.font.pointSize];
    [self.buildingLabel setFont:buildingFont];
    
    UIFont *roleFont = [PeopleBasicTheme peopleFontBookWithSize:self.roleLabel.font.pointSize];
    [self.roleLabel setFont:roleFont];
    
    UIFont *nameFont = [PeopleBasicTheme peopleFontBookWithSize:self.nameLabel.font.pointSize];
    [self.nameLabel setFont:nameFont];
}

@end
