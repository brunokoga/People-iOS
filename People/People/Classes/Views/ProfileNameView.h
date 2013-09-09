//
//  PeopleNameView.h
//  People
//
//  Created by Bruno Koga on 9/9/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKXibView.h"

@interface ProfileNameView : BKXibView
@property (weak, nonatomic) IBOutlet UILabel *baseLabel;
@property (weak, nonatomic) IBOutlet UILabel *buildingLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;

@end
