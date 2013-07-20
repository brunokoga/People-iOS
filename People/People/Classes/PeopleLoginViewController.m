//
//  PeopleLoginViewController.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleLoginViewController.h"
#import "PeopleServices.h"

@interface PeopleLoginViewController ()

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doLogin
{
    PeopleServices *sharedServices = [PeopleServices sharedServices];
    [sharedServices loginWithUsername:@""
                             password:@""
                              success:^(PeopleColaborador *colaborador) {
                                  //save colaborador
                                  //go to next screen
                          
                      } failure:^(NSError *error) {
                          //analyse error message and display error
                      }];
    
}


@end
