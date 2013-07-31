//
//  PeopleSearchTableViewHeader.m
//  People
//
//  Created by Christian Felipe Macedo Sampaio on 30/07/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchTableViewHeader.h"

@implementation PeopleSearchTableViewHeader

- (void)updateTitleWithCount:(NSInteger)count
{
    NSString *titleString = @"";
    NSString *singularString = [NSString stringWithFormat:NSLocalizedString(@"%d result", @""), count];
    NSString *pluralString = [NSString stringWithFormat:NSLocalizedString(@"%d results", @""), count];
    titleString = count > 1 ? pluralString : singularString;
    self.headerTitleLabel.text = titleString;
}

@end
