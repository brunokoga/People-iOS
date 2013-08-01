//
//  PeopleSearchTableViewHeader.h
//  People
//
//  Created by Christian Felipe Macedo Sampaio on 30/07/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleSearchTableViewHeader : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;

- (void)updateTitleWithCount:(NSInteger)count;

@end
