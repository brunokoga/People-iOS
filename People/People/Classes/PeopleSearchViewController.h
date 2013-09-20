//
//  PeopleSearchViewController.h
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleBaseViewController.h"
#import "PeopleSearchTableViewCell.h"

@interface PeopleSearchViewController : PeopleBaseViewController

@property (nonatomic, readonly) PeopleSearchTableViewCell *selectedCell;
@property(nonatomic, strong, readonly) UIView *containerView;
@property(nonatomic, strong, readonly) UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *searchView;

- (CGRect)frameForContainerView;
- (CGRect)selectedCellRelativeFrame;

@end
