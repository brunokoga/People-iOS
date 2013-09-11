//
//  PeopleCoachView.m
//  People
//
//  Created by Bruno Koga on 9/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "ProfileCoachView.h"
#import "PeopleCircularImageView.h"


@interface ProfileCoachView ()
@property (weak, nonatomic) IBOutlet PeopleCircularImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *coachLabel;
@property (weak, nonatomic) IBOutlet UILabel *coachNameLabel;


@end
@implementation ProfileCoachView

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
    [super setup];
    
}

#pragma mark - Setter overrides
- (void)setCoachPicture:(UIImage *)coachPicture
{
    _coachPicture = coachPicture;
    [self.pictureView.imageView setImage:coachPicture];
}

- (void)setCoachName:(NSString *)coachName
{
    _coachName = coachName;
    [self.coachNameLabel setText:coachName];
}
@end
