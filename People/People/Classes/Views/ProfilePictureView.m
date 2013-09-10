//
//  ProfilePictureView.m
//  People
//
//  Created by Bruno Koga on 9/9/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "ProfilePictureView.h"
#import <BKUIAdditions/UIButton+CircularFrame.h>
#import <BKUIAdditions/UIView+CircularFrame.h>

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
    [self makeCircular];
    [self.pictureView makeCircular];
    self.backgroundColor = [UIColor grayColor];
}

- (UIImage *)image;
{
    return [self.pictureView imageForState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)image
{
    [self.pictureView setImage:image forState:UIControlStateNormal];
}

//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    [_pictureView setFrame:rect];
//    
//}

- (void)hideFavoritos:(BOOL)hide
{
    CGFloat alpha = 1.0f;
    if (hide) {
        alpha = 0.0f;
    }
    [self.favoriteView setAlpha:alpha];
}

- (void)animateCornerRadiusFromFrame:(CGRect)fromFrame
                             toFrame:(CGRect)toFrame
                            duration:(NSTimeInterval)duration
{
    [CATransaction begin];
    NSString *animationKeyPath = @"cornerRadius";
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:animationKeyPath];
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim1.fromValue = @(fromFrame.size.width/2);
    anim1.toValue = @(toFrame.size.width/2);
    anim1.duration = duration;
    [self.layer addAnimation:anim1 forKey:animationKeyPath];
    
    
    CABasicAnimation *anim3 = [CABasicAnimation animationWithKeyPath:animationKeyPath];
    anim3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim3.fromValue = @((fromFrame.size.width-2.0f)/2);
    anim3.toValue = @((toFrame.size.width-2.0f)/2);
    anim3.duration = duration;
    [self.pictureView.layer addAnimation:anim3 forKey:animationKeyPath];
    
    animationKeyPath = @"frame";
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:animationKeyPath];
    anim2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim2.fromValue =  [NSValue valueWithCGRect:fromFrame];
    anim2.toValue = [NSValue valueWithCGRect:toFrame];
    anim2.duration = duration;
    
    [self.layer addAnimation:anim2 forKey:animationKeyPath];
    [self.pictureView.layer addAnimation:anim2 forKey:animationKeyPath];
    
    self.frame = toFrame;
    
    [CATransaction commit];

    
}

@end
