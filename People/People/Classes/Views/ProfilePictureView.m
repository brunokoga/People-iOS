//
//  ProfilePictureView.m
//  People
//
//  Created by Bruno Koga on 9/9/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "ProfilePictureView.h"
#import <BKUIAdditions/UIButton+CircularFrame.h>

@interface ProfilePictureView ()
@property (weak, nonatomic) IBOutlet UIButton *pictureView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteView;

@end
@implementation ProfilePictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setup
{
    [super setup];
    [self.pictureView makeCircular];
    [self.pictureView makeCircular];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
