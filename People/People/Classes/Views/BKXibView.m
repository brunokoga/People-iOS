//
//  BKXibView.m
//  People
//
//  Created by Bruno Koga on 9/9/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "BKXibView.h"

@implementation BKXibView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSString *xibName = NSStringFromClass([self class]);
        UIView* xibView = [[[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil] objectAtIndex:0];
        // now add the view to ourselves...
        [xibView setFrame:[self bounds]];
        [self addSubview:xibView]; //
        [self setup];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    self.backgroundColor = [UIColor clearColor];
    /*
     NSString *xibName = NSStringFromClass([self class]);
     UIView* xibView = [[[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil] objectAtIndex:0];
     // now add the view to ourselves...
     [xibView setFrame:[self bounds]];
     [self addSubview:xibView]; //
     */
}


@end
