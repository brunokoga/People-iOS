//
//  PeopleSearchViewController.m
//  People
//
//  Created by Bruno Koga on 7/18/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import "PeopleSearchViewController.h"
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

@implementation PeopleSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
//    [self.resultTableView registerClass:[PeopleSearchTableViewCell class] forCellReuseIdentifier:kPeopleSearchCellIdentifier];
    self.resultTableView.dataSource = self;
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
    cell.collaboratorNameLabel.text = [self.resultCollaborators[indexPath.row] name];
    [cell addButton:[UIButton buttonWithType:UIButtonTypeRoundedRect] toCellSide:MCSwipeTableViewCellSideLeft];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = nil;
    NSInteger count = self.resultCollaborators.count;
    if (count)
    {
        PeopleSearchTableViewHeader *headerView = [tableView dequeueReusableCellWithIdentifier:kPeopleSearchHeaderIdentifier];
        [headerView updateTitleWithCount:count];
        headerView.headerTitleLabel.textColor = [PeopleBasicTheme peopleColor2Secondary];
        
//        NSString *titleString = @"";
//        NSString *singularString = [NSString stringWithFormat:NSLocalizedString(@"%d result", @""), count];
//        NSString *pluralString = [NSString stringWithFormat:NSLocalizedString(@"%d results", @""), count];
//        titleString = count == 1 ? singularString : pluralString;
//        headerLabel.textColor = [PeopleBasicTheme peopleColor2Secondary];
//        headerLabel.text = [self tableView:tableView titleForHeaderInSection:section];
//        headerLabel.textAlignment = NSTextAlignmentCenter;
    }

    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger count = self.resultCollaborators.count;
    NSString *titleString = [NSString stringWithFormat:NSLocalizedString(@"%d results", @""), count];
    return titleString;
}

#pragma mark UI adjustments

- (void)adjustFonts
{
    UIColor *color = [PeopleBasicTheme peopleColor1Secondary];
    UIFont *font = [PeopleBasicTheme peopleFontBookWithSize:self.searchTextfield.font.pointSize];
    self.searchTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.searchTextfield.placeholder
                                                                                   attributes:@{NSForegroundColorAttributeName : color,
                                                                                                NSFontAttributeName : font }];
}

- (void)adjustUIElements
{
    UIImage *searchIcon = [UIImage imageNamed:@"ico-search"];
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:searchIcon];
    leftImageView.contentMode = UIViewContentModeTopLeft;
    leftImageView.frame = (CGRect){leftImageView.frame.origin, searchIcon.size.width + 5.0f, searchIcon.size.height};
    self.searchTextfield.leftView = leftImageView;
    self.searchTextfield.leftViewMode = UITextFieldViewModeAlways;
    [self.backgroundLogo setCenter:self.view.center];
}

#pragma mark Getters/Setters

@end
