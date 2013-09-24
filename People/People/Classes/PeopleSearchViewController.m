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
#import "PeopleSearchTableViewHeader.h"

@interface PeopleSearchViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundLogo;
@property (weak, nonatomic) IBOutlet UITextField *searchTextfield;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (strong, nonatomic) NSArray *resultCollaborators;

@property(nonatomic, strong, readwrite) IBOutlet UIView *containerView;
@property(nonatomic, strong, readwrite) IBOutlet UIView *contentView;
//overriding readonly property
@property (nonatomic, strong, readwrite) PeopleSearchTableViewCell *selectedCell;
@property (nonatomic, strong, readwrite) NSIndexPath *selectedIndexPath;

@end

static NSString * const kPeopleSearchCellIdentifier = @"kPeopleSearchCellIdentifier";
static NSString * const kPeopleSearchHeaderIdentifier = @"kPeopleSearchHeaderIdentifier";
static NSString * const kPeopleSearchToProfileSegueIdentifier = @"Search to Profile Segue";

@implementation PeopleSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createContainerAndContentViews];
    [self bounceSearchView];
	// Do any additional setup after loading the view.
}

- (void)bounceSearchView
{
    CGRect oldFrame = self.searchView.frame;
    [self.searchView setFrame:CGRectMake(oldFrame.origin.x,
                                         oldFrame.origin.y - oldFrame.size.height,
                                         oldFrame.size.width,
                                         oldFrame.size.height)];
    
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:25.0 options:0 animations:^{
        
        [self.searchView setFrame:oldFrame];
    } completion:^(BOOL finished) {
        [[self searchTextfield] becomeFirstResponder];
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.resultTableView.dataSource = self;
    self.resultTableView.delegate = self;
    self.searchTextfield.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)createContainerAndContentViews
{
    [super viewDidLoad];
}

- (CGRect)frameForContainerView {
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    return CGRectMake(0.0f, height/2.0f - width/2.0f, width, height);
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
        cell = [[PeopleSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPeopleSearchCellIdentifier];
    }
    PeopleColaborador *collaborator = self.resultCollaborators[indexPath.row];
    [cell updateLabelsWithCollaborator:collaborator];
    cell.tag = indexPath.row;
    cell.image = nil;
    [[PeopleServices sharedServices] photoForUser:collaborator.login
                                          success:^(UIImage *image) {
                                              if (cell.tag == indexPath.row)
                                              {
                                                  cell.image = image;
                                              }
                                          } failure:^(NSError *error) {
                                              
                                          }];

    return cell;
}

#pragma mark TableView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchTextfield resignFirstResponder];
}
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
    self.selectedCell = (PeopleSearchTableViewCell *)[self tableView:self.resultTableView
                                               cellForRowAtIndexPath:indexPath];
    self.selectedIndexPath = indexPath;
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:kPeopleSearchToProfileSegueIdentifier])
    {
        PeopleProfileViewController *profileViewController = (PeopleProfileViewController *)segue.destinationViewController;
        profileViewController.colaborador = self.resultCollaborators[self.selectedIndexPath.row];
    }
    
}

- (CGRect)selectedCellRelativeFrame
{
    CGRect rectOfCellInTableView = [self.resultTableView rectForRowAtIndexPath:self.selectedIndexPath];
    CGRect rectOfCellInSuperview = [self.resultTableView convertRect:rectOfCellInTableView toView:self.view];

    return rectOfCellInSuperview;
}

@end
