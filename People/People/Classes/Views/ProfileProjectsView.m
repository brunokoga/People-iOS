//
//  ProfileProjectsView.m
//  People
//
//  Created by Bruno Koga on 9/11/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "ProfileProjectsView.h"
#import "PeopleBasicTheme.h"

@interface ProfileProjectsView ()
@property (weak, nonatomic) IBOutlet UILabel *projectsTitle;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *pastLabel;


@end

@implementation ProfileProjectsView

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

    UIFont *projectsTitleFont = [PeopleBasicTheme peopleFontBookWithSize:self.projectsTitle.font.pointSize];
    [self.projectsTitle setFont:projectsTitleFont];
}

#pragma mark - Setter Override

- (void)setPastProjects:(NSArray *)pastProjects
{
    _pastProjects = pastProjects;
    [self redraw];
}

- (void)setCurrentProjects:(NSArray *)currentProjects
{
    _currentProjects = currentProjects;
    [self redraw];
}
- (void)setPastProjects:(NSArray *)pastProjects currentProjects:(NSArray *)currentProjects
{
    _currentProjects = currentProjects;
    _pastProjects = pastProjects;
    [self redraw];
}

- (void)redraw
{
    NSString *currentText = NSLocalizedString(@"Current:", @"Current Projects Label on Profile Screen");
    currentText = [currentText stringByAppendingString:@" "];
    NSString *pastText = NSLocalizedString(@"Past:", @"Past Projects Label on Profile Screen");
    pastText = [pastText stringByAppendingString:@" "];
    
    // build Attributed Text Mechanism
    NSMutableAttributedString *currentAttributedText = [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *pastAttributedText = [[NSMutableAttributedString alloc] initWithString:@""];
    
    
    NSString *currentProjects = [self.currentProjects componentsJoinedByString:@", "];
    NSString *pastProjects = [self.pastProjects componentsJoinedByString:@", "];
    
    NSString *currentProjectsString = [currentText stringByAppendingString:currentProjects];
    NSString *pastProjectsString = [pastText stringByAppendingString:pastProjects];

    if (currentProjects)
    {
        currentAttributedText = [[NSMutableAttributedString alloc] initWithString:currentProjectsString];
        UIFont *currentFont = [PeopleBasicTheme peopleFontBookWithSize:16.0];
        [currentAttributedText addAttribute:NSFontAttributeName
                                      value:currentFont
                                      range:NSMakeRange(0, [currentAttributedText length])];
        
        UIColor *projectCategoryTitleColor = [UIColor grayColor];
        [currentAttributedText addAttribute:NSForegroundColorAttributeName
                                      value:projectCategoryTitleColor
                                      range:NSMakeRange(0, [currentText length])];
        

        
        /*
        [ob2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:25.0] range:NSMakeRange(0,4)];
        [ob2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.3 green:0.3 blue:0.0 alpha:1.0] range:NSMakeRange(0,4)];
        
        [ob1 appendAttribu
    bute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:25.0] range:NSMakeRange(0,4)];
        [ob2 addAttribute:NSForegroun
    */
        
        
        
        
        
    }
    if (pastProjects)
    {


        pastAttributedText = [[NSMutableAttributedString alloc] initWithString:pastProjectsString];
        
        UIFont *pastFont = [PeopleBasicTheme peopleFontBookWithSize:16.0];
        [pastAttributedText addAttribute:NSFontAttributeName
                                   value:pastFont
                                   range:NSMakeRange(0, [pastAttributedText length])];
        UIColor *projectCategoryTitleColor = [UIColor grayColor];
        [pastAttributedText addAttribute:NSForegroundColorAttributeName
                                   value:projectCategoryTitleColor
                                   range:NSMakeRange(0, [pastText length])];

    }

    [self.currentLabel setAttributedText:currentAttributedText];
    [self.pastLabel setAttributedText:pastAttributedText];
    
    [self redrawLabelsSize];
    
    
}

- (void)redrawLabelsSize
{
    
    // thanks! http://stackoverflow.com/questions/3527494/how-to-calculate-uilabel-width-based-on-text-length
    NSString *currentString = [self.currentLabel.attributedText string];
    NSString *pastString = [self.pastLabel.attributedText string];
    CGSize maximumSize = CGSizeMake(280, 1000);
    
    NSRange currentRange = NSMakeRange(0, [self.currentLabel.attributedText string].length);
    NSDictionary *currentAttributes = [self.currentLabel.attributedText attributesAtIndex:0
                                                                    effectiveRange:&currentRange];

    CGRect expectedCurrentLabelRect = [currentString boundingRectWithSize:maximumSize
                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                               attributes:currentAttributes
                                                                  context:nil];
    /*
    CGSize expectedCurrentLabelSize = [currentString sizeWithFont:self.currentLabel.font
                                             constrainedToSize:maximumSize
                                                 lineBreakMode:self.currentLabel.lineBreakMode];
    */
    [self.currentLabel setFrame:CGRectMake(self.currentLabel.frame.origin.x,
                                           self.currentLabel.frame.origin.y,
                                          expectedCurrentLabelRect.size.width,
                                           expectedCurrentLabelRect.size.height)];

    NSRange pastRange = NSMakeRange(0, [self.pastLabel.attributedText string].length);
    NSDictionary *pastAttributes = [self.pastLabel.attributedText attributesAtIndex:0
                                                                           effectiveRange:&pastRange];

    CGRect expectedPastLabelRect = [pastString boundingRectWithSize:maximumSize
                                                               options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:pastAttributes
                                                               context:nil];
    
    [self.pastLabel setFrame:CGRectMake(self.pastLabel.frame.origin.x,
                                       self.currentLabel.frame.origin.y + self.currentLabel.frame.size.height + 16.0,
                                       expectedPastLabelRect.size.width,
                                        expectedPastLabelRect.size.height)];

}

- (CGFloat)totalHeight
{
    CGPoint point = CGPointMake(0.0, self.pastLabel.frame.origin.x + self.pastLabel.frame.size.height);
    point = [self convertPoint:point toView:self.superview];
    return point.y;
}

@end
