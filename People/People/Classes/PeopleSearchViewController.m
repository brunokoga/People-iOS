//
//  PeopleSearchViewController.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchViewController.h"
#import "PeopleProfileViewController.h"
#import "PeopleBasicTheme.h"
#import "PeopleColaborador.h"
#import "PeopleServices.h"
#import "PeopleSearchTableViewCell.h"
#import "PeopleSearchTableViewHeader.h"

@interface PeopleSearchViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundLogo;
@property (weak, nonatomic) IBOutlet UITextField *searchTextfield;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (strong, nonatomic) NSArray *resultCollaborators;

@end

static NSString * const kPeopleSearchCellIdentifier = @"kPeopleSearchCellIdentifier";
static NSString * const kPeopleSearchHeaderIdentifier = @"kPeopleSearchHeaderIdentifier";
static NSString * const kPeopleSearchToProfileSegueIdentifier = @"Search to Profile Segue";

@implementation PeopleSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.resultTableView.dataSource = self;
    self.resultTableView.delegate = self;
    self.searchTextfield.delegate = self;
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[PeopleServices sharedServices] colaboradoresForSearchTerm:self.searchTextfield.text
                                                        success:^(NSArray *colaboradores) {
                                                            self.resultCollaborators = [colaboradores copy];
                                                            
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                                            [self.resultTableView reloadData];
                                                            });
                                                            
                                                        } failure:^(NSError *error) {
                                                            //handle error
                                                        }];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.resultCollaborators.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeopleSearchTableViewCell *cell = (PeopleSearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kPeopleSearchCellIdentifier];
    if (!cell)
    {
        cell = [[PeopleSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kPeopleSearchCellIdentifier];
    }
    PeopleColaborador *collaborator = self.resultCollaborators[indexPath.row];
    [cell updateLabelsWithCollaborator:collaborator];
    
    return cell;
}

#pragma mark TableView Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PeopleSearchTableViewHeader *headerView = nil;
    NSInteger count = self.resultCollaborators.count;
    if (count)
    {
        headerView = [tableView dequeueReusableCellWithIdentifier:kPeopleSearchHeaderIdentifier];
        [headerView updateTitleWithCount:count];
        headerView.headerTitleLabel.textColor = [PeopleBasicTheme peopleColor2Secondary];
        headerView.headerTitleLabel.font = [PeopleBasicTheme peopleFontBookWithSize:20.0f];
    }

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat headerHeight = 0.0f;
    NSInteger count = self.resultCollaborators.count;
    if (count)
    {
        PeopleSearchTableViewHeader *headerView = [tableView dequeueReusableCellWithIdentifier:kPeopleSearchHeaderIdentifier];
        headerHeight = headerView.frame.size.height;
    }
    
    return headerHeight;
}

- (void)adjustUIElements
{
    [self.backgroundLogo setCenter:self.view.center];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kPeopleSearchToProfileSegueIdentifier sender:self];
}

#pragma mark UI adjustments

- (void)adjustFonts
{
    UIColor *color = [PeopleBasicTheme peopleColor1Secondary];
    UIFont *font = [PeopleBasicTheme peopleFontBookWithSize:self.searchTextfield.font.pointSize];
    self.searchTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.searchTextfield.placeholder
                                                                                   attributes:@{NSForegroundColorAttributeName : color,
                                                                                                NSFontAttributeName : font }];
    self.searchTextfield.font = [PeopleBasicTheme peopleFontBookWithSize:22.0f];

}

static NSString * const kSearchToProfileSegue = @"Search To Profile Segue";

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:kSearchToProfileSegue])
    {
        PeopleProfileViewController *profileViewController = (PeopleProfileViewController *)segue.destinationViewController;
        profileViewController.colaborador = nil;
    }
    
}

- (IBAction)testButtonTouched:(id)sender {
    [self performSegueWithIdentifier:kSearchToProfileSegue sender:self];
    UIImage *searchIcon = [UIImage imageNamed:@"ico-search"];
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:searchIcon];
    leftImageView.contentMode = UIViewContentModeTopLeft;
    leftImageView.frame = (CGRect){leftImageView.frame.origin, searchIcon.size.width + 5.0f, searchIcon.size.height};
    self.searchTextfield.leftView = leftImageView;
    self.searchTextfield.leftViewMode = UITextFieldViewModeAlways;
    [self.backgroundLogo setCenter:self.view.center];
}

@end
