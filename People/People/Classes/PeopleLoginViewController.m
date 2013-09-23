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
#import "PeopleRegularButton.h"
#import "PeoplePreferences.h"

@interface PeopleLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *phraseImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet PeopleRegularButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *usernamePadImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordPadImageView;
@property (weak, nonatomic) IBOutlet UIView *fieldsContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation PeopleLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginButton.enabled = YES;
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
#pragma mark - Positioning

- (CGPoint)logoViewInitialCenter
{
    return CGPointMake(self.view.center.x, self.view.frame.size.height/5);
}

- (CGPoint)phraseViewInitialCenter
{
    return CGPointMake(self.view.center.x, 5*self.view.frame.size.height/6);
}

#pragma mark - Load Methods

- (void)adjustUIElements
{
    CGPoint logoImageViewCenter = [self logoViewInitialCenter];
    [self.logoImageView setCenter:logoImageViewCenter];
    
    CGPoint phraseImageViewCenter = [self phraseViewInitialCenter];
    [self.phraseImageView setCenter:phraseImageViewCenter];
    [self animateViewsIn];
    [self setLoginButtonToNormalState];
    [self.fieldsContainerView setCenter:self.view.center];
    
}

- (void)adjustColors
{
    UIColor *color = [PeopleBasicTheme peopleColor1Secondary];
    UIFont *font = [PeopleBasicTheme peopleFontBookWithSize:self.usernameTextField.font.pointSize];
    self.usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.usernameTextField.placeholder
                                                                                   attributes:@{NSForegroundColorAttributeName : color,
                                                                                                NSFontAttributeName : font }];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.passwordTextField.placeholder
                                                                                   attributes:@{NSForegroundColorAttributeName : color,
                                                                                                NSFontAttributeName : font }];
    
    [self.loginButton applyPrimaryColor];
    
}

- (void)adjustFonts
{
    self.usernameTextField.font = [PeopleBasicTheme peopleFontBookWithSize:self.usernameTextField.font.pointSize];
    self.passwordTextField.font = [PeopleBasicTheme peopleFontBookWithSize:self.passwordTextField.font.pointSize];
    self.loginButton.titleLabel.font = [PeopleBasicTheme peopleFontBookWithSize:self.loginButton.titleLabel.font.pointSize];
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
    self.loginButton.enabled = NO;
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
    NSString *loginButtonTitle;
    NSString *userPadImageName;
    NSString *passPadImageName;
    switch (error.code) {
        case PeopleValidationErrorBlankUsernameOnly:
            userPadImageName = @"ico-user-error";
            passPadImageName = @"ico-pass-normal";
            loginButtonTitle = NSLocalizedString(@"Blank username!", @"");
            break;
        case PeopleValidationErrorBlankPasswordOnly:
            userPadImageName = @"ico-user-normal";
            passPadImageName = @"ico-pass-error";
            loginButtonTitle = NSLocalizedString(@"Blank password!", @"");
            break;
        case PeopleValidationErrorBlankUsernameAndPassword:
            userPadImageName = @"ico-user-error";
            passPadImageName = @"ico-pass-error";
            loginButtonTitle = NSLocalizedString(@"Blank username and password!", @"");
            break;
        default:
            userPadImageName = @"ico-user-normal";
            passPadImageName = @"ico-pass-normal";
            loginButtonTitle = NSLocalizedString(@"Server Error!", @"");
            break;
    }
    
    self.usernamePadImageView.image = [UIImage imageNamed:userPadImageName];
    self.passwordPadImageView.image = [UIImage imageNamed:passPadImageName];
    [self.loginButton setTitle:loginButtonTitle forState:UIControlStateNormal];
    [self.loginButton applyErrorTitleColorForPrimaryColor];
    self.loginButton.enabled = YES;

}

- (void)setPadsImageViewsToNormalState
{
    NSString *userPadImageName = @"ico-user-normal";
    NSString *passPadImageName = passPadImageName = @"ico-pass-normal";
    
    self.usernamePadImageView.image = [UIImage imageNamed:userPadImageName];
    self.passwordPadImageView.image = [UIImage imageNamed:passPadImageName];

}
- (IBAction)loginButtonPressed:(id)sender
{
    
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    PeopleValidation *validation = [[PeopleValidation alloc] init];
    NSError *validationError = nil;
    if ([validation validUsername:username password:password error:&validationError])
    {
        [self setPadsImageViewsToNormalState];
        [self loginWithUsername:username password:password];
    }
    else
    {
        [self loginErrorWithError:validationError];
    }
    
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)setLoginButtonToNormalState
{
    NSString *loginButtonTitle = NSLocalizedString(@"Login", @"");
    [self.loginButton setTitle:loginButtonTitle forState:UIControlStateNormal];
    [self.loginButton applyNormalTitleColorForPrimaryColor];
}

#pragma mark - UITextFieldDelegates

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSString *userPadImageName;
    NSString *passPadImageName;

    if (textField == self.usernameTextField)
    {
        userPadImageName = @"ico-user-active";
        passPadImageName = @"ico-pass-normal";
    }
    else if (textField == self.passwordTextField)
    {
        userPadImageName = @"ico-user-normal";
        passPadImageName = @"ico-pass-active";
    }
    self.usernamePadImageView.image = [UIImage imageNamed:userPadImageName];
    self.passwordPadImageView.image = [UIImage imageNamed:passPadImageName];

    [self setLoginButtonToNormalState];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField) {
        [self loginButtonPressed:textField];
    }
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Keyboard animations

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL enabled = YES;
    
    if (([textField.text length] <=1) && ([string length] == 0)) {
        enabled = NO;
    }
    
    if (textField != self.usernameTextField && [self.usernameTextField.text length] == 0)
    {
        enabled = NO;
    }
    
    if (textField != self.passwordTextField && [self.passwordTextField.text length] == 0)
    {
        enabled = NO;
    }
    
    
    [self.loginButton setEnabled:enabled];
    
    return YES;
}

- (void)keyboardWillHide:(BOOL)willHide animationDuration:(NSTimeInterval)animationDuration
{
    
    CGPoint logoViewCenter;
    CGPoint fieldsViewCenter;

    if (!willHide)
    {
        logoViewCenter = CGPointMake(self.view.center.x, self.view.frame.size.height/7);
        fieldsViewCenter = CGPointMake(self.view.center.x, 2*self.view.frame.size.height/5);
        
        
        [UIView animateWithDuration:animationDuration+0.2f delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             self.logoImageView.center = logoViewCenter;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        
        [UIView animateWithDuration:animationDuration+0.2f delay:0.1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             self.fieldsContainerView.center = fieldsViewCenter;
                             if ([[UIScreen mainScreen] bounds].size.height == 480.0)
                             {
                                 self.loginButton.center = CGPointMake(self.loginButton.center.x, self.loginButton.center.y - 20.0);
                             }
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        
    }
    else
    {
        logoViewCenter = [self logoViewInitialCenter];
        fieldsViewCenter = self.view.center;
        

        [UIView animateWithDuration:animationDuration+0.2f delay:0.1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             self.fieldsContainerView.center = fieldsViewCenter;
                             if ([[UIScreen mainScreen] bounds].size.height == 480.0)
                             {
                                 self.loginButton.center = CGPointMake(self.loginButton.center.x, self.loginButton.center.y + 20.0);
                             }
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        
        [UIView animateWithDuration:animationDuration+0.2f delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             self.logoImageView.center = logoViewCenter;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }
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
    [PeoplePreferences setAutoLogin:YES];
    [PeoplePreferences setUsername:self.usernameTextField.text
                          password:self.passwordTextField.text];
    [self performSegueWithIdentifier:kLoginToSearchSegue sender:self];
}

- (void)performTransitionWithSegueIdentifier:(NSString *)identifier
                                  completion:(void (^)(void))completion
{
    [UIView animateWithDuration:1.0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.fieldsContainerView setAlpha:0.0];
                         [self.phraseImageView setAlpha:0.0];
                     } completion:^(BOOL finished) {

                     }];

    [UIView animateWithDuration:2.0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.logoImageView setCenter:self.view.center];
                     } completion:^(BOOL finished) {

                         UIImageView *logoTransitionImageView = [self logoTransitionImaveView];
                         [UIView animateWithDuration:1.0
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.logoImageView.alpha = 0.0;
                                              logoTransitionImageView.alpha = 1.0;
                                              [self.backgroundImageView setAlpha:0.0];
                                          } completion:^(BOOL finished) {
                                              completion();
                                          }];

                     }];

}

- (UIImageView *)logoTransitionImaveView
{
    UIImageView *logoTransitionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"People - White Logo"]];
    [logoTransitionImageView setAlpha:0.0];
    [self.view addSubview:logoTransitionImageView];
    logoTransitionImageView.frame = self.logoImageView.frame;
    return logoTransitionImageView;
}

@end
