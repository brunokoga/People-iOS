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
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation PeopleLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)adjustUIElements
{
    CGPoint logoImageViewCenter = CGPointMake(self.view.center.x, self.view.center.y - 114);
    [self.logoImageView setCenter:logoImageViewCenter];
    [self animateViewsIn];
    
}

- (void)adjustFonts
{
    self.usernameTextField.font = [PeopleBasicTheme peopleFontLightWithSize:self.usernameTextField.font.pointSize];
    self.passwordTextField.font = [PeopleBasicTheme peopleFontLightWithSize:self.passwordTextField.font.pointSize];
}

- (void)animateViewsIn
{
    self.usernameTextField.alpha = 0.0;
    self.passwordTextField.alpha = 0.0;
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.usernameTextField.alpha = 1.0;
                         self.passwordTextField.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)adjustLocalizationItems
{
    self.usernameTextField.placeholder = NSLocalizedString(@"username", @"");
    self.passwordTextField.placeholder = NSLocalizedString(@"password", @"");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    PeopleServices *sharedServices = [PeopleServices sharedServices];
    [sharedServices loginWithUsername:username
                             password:password
                              success:^(PeopleColaborador *colaborador) {
                                  //save colaborador
                                  //go to next screen
                          
                      } failure:^(NSError *error) {
                          [self loginErrorWithError:error];
                      }];
}

- (void)loginErrorWithError:(NSError *)error
{
 
}

- (IBAction)loginButtonPressed:(id)sender
{
    NSString *username;
    NSString *password;
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


@end
