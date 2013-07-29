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

@interface PeopleSearchViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundLogo;
@property (weak, nonatomic) IBOutlet UITextField *searchTextfield;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (strong, nonatomic) NSArray *resultCollaborators;

@end

static NSString * const kPeopleSearchCellIdentifier = @"kPeopleSearchCellIdentifier";

@implementation PeopleSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.resultTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kPeopleSearchCellIdentifier];
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
                                                            [self.resultTableView reloadData];
                                                            
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPeopleSearchCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kPeopleSearchCellIdentifier];
    }
    cell.textLabel.text = [self.resultCollaborators[indexPath.row] name];
    
    return cell;
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
