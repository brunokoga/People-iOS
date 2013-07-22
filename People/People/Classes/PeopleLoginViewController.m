//
//  PeopleLoginViewController.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleLoginViewController.h"
#import "PeopleServices.h"
#import "PeopleValidation.h"
#import "PeopleBasicTheme.h"

@interface PeopleLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *phraseImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation PeopleLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappear:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Load Methods

- (void)adjustUIElements
{
    CGPoint logoImageViewCenter = CGPointMake(self.view.center.x, self.view.frame.size.height/4);
    [self.logoImageView setCenter:logoImageViewCenter];
    
    CGPoint phraseImageViewCenter = CGPointMake(self.view.center.x, 5*self.view.frame.size.height/6);
    [self.phraseImageView setCenter:phraseImageViewCenter];
    [self animateViewsIn];
    
}

- (void)adjustColors
{
    UIColor *color = [PeopleBasicTheme peopleColorPrimaryLight];
    self.usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.usernameTextField.placeholder
                                                                                   attributes:@{NSForegroundColorAttributeName : color}];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.passwordTextField.placeholder
                                                                                   attributes:@{NSForegroundColorAttributeName : color}];
}

- (void)adjustFonts
{
    self.usernameTextField.font = [PeopleBasicTheme peopleFontLightWithSize:self.usernameTextField.font.pointSize];
    self.passwordTextField.font = [PeopleBasicTheme peopleFontLightWithSize:self.passwordTextField.font.pointSize];
    self.loginButton.titleLabel.font = [PeopleBasicTheme peopleFontLightWithSize:self.loginButton.titleLabel.font.pointSize];
}

- (void)animateViewsIn
{
    self.usernameTextField.alpha = 0.0;
    self.passwordTextField.alpha = 0.0;
    self.loginButton.alpha = 0.0;
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.usernameTextField.alpha = 1.0;
                         self.passwordTextField.alpha = 1.0;
                         self.loginButton.alpha = 1.0;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)adjustLocalizationItems
{
    self.usernameTextField.placeholder = NSLocalizedString(@"username", @"");
    self.passwordTextField.placeholder = NSLocalizedString(@"password", @"");
}

#pragma mark - Functionality

- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    PeopleServices *sharedServices = [PeopleServices sharedServices];
    [sharedServices loginWithUsername:username
                             password:password
                              success:^(PeopleColaborador *colaborador) {
                                  [self performLoginSucceededOperationsWithColaborador:colaborador];
                              } failure:^(NSError *error) {
                                  [self loginErrorWithError:error];
                              }];
}

- (void)loginErrorWithError:(NSError *)error
{
 
}

- (IBAction)loginButtonPressed:(id)sender
{
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    PeopleValidation *validation = [[PeopleValidation alloc] init];
    NSError *validationError = nil;
    if ([validation validUsername:username password:password error:&validationError])
    {
        [self loginWithUsername:username password:password];
    }
    else
    {
        [self loginErrorWithError:validationError];
    }
}

#pragma mark - UITextFieldDelegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField) {
        if (([self.usernameTextField.text length] > 0) &&
            ([self.passwordTextField.text length] > 0))
        {
            if (YES) {
                [self loginButtonPressed:textField];
            }
        }
    }
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Keyboard animations


- (void)keyboardWillHide:(BOOL)willHide animationDuration:(NSTimeInterval)animationDuration
{
    /*
    CGPoint titleViewCenter;
    CGPoint fieldsViewCenter;
    CGPoint btnLoginCenter;
    
    if (!willHide)
    {
        titleViewCenter = CGPointMake(165, 50);
        fieldsViewCenter = CGPointMake(160, 130);
        btnLoginCenter = CGPointMake(160, 205);
        
        [UIView animateWithDuration:animationDuration+0.2f delay:0
                            options:UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             //                             self.titleView.transform = CGAffineTransformMakeScale(0.6f, 0.6f);
                             self.titleView.center = titleViewCenter;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        
        [UIView animateWithDuration:animationDuration+0.2f delay:0.1
                            options:UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             self.fieldView.center = fieldsViewCenter;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        
        [UIView animateWithDuration:animationDuration+0.2f delay:0.2
                            options:UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             self.btnLogin.center = btnLoginCenter;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }
    else
    {
        titleViewCenter = CGPointMake(165, 110);
        fieldsViewCenter = CGPointMake(160, 221);
        btnLoginCenter = CGPointMake(160, 295);
        
        [UIView animateWithDuration:animationDuration+0.5f delay:0
                            options:UIViewAnimationCurveEaseIn
                         animations:^{
                             
                             self.btnLogin.center = btnLoginCenter;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        
        [UIView animateWithDuration:animationDuration+0.5f delay:0.1
                            options:UIViewAnimationCurveEaseIn
                         animations:^{
                             
                             self.fieldView.center = fieldsViewCenter;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        
        [UIView animateWithDuration:animationDuration+0.5f delay:0.2
                            options:UIViewAnimationCurveEaseIn
                         animations:^{
                             
                             //                             self.titleView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                             self.titleView.center = titleViewCenter;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }
     */
}



- (void)keyboardWillAppear:(NSNotification*)notification
{
    NSTimeInterval animationDuration = [(NSNumber*)[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self keyboardWillHide:NO animationDuration:animationDuration];
}

- (void)keyboardWillDisappear:(NSNotification*)notification
{
    NSTimeInterval animationDuration = [(NSNumber*)[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self keyboardWillHide:YES animationDuration:animationDuration];
}

#pragma mark - Transitions

static NSString * const kLoginToSearchSegue = @"Login To Search Segue";

- (void)performLoginSucceededOperationsWithColaborador:(PeopleColaborador *)colaborador
{
    [self performSegueWithIdentifier:kLoginToSearchSegue sender:self];
}

- (void)performTransitionWithSegueIdentifier:(NSString *)identifier
                                  completion:(void (^)(void))completion
{
    completion();
}


@end
