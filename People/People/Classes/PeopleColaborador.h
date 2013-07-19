//
//  PeopleColaborador.h
//  People
//
//  Created by Bruno Koga on 7/19/13.
//  Copyright (c) 2013 CI&T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleColaborador : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *mentorLogin;
@property (nonatomic, strong) NSString *mentorName;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *managerName;
@property (nonatomic, strong) NSString *managerLogin;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *building;
@property (nonatomic, strong) NSString *ownWords;
@property (nonatomic, strong) NSArray *skills;
@property (nonatomic, strong) NSArray *teammatesNames;
@property (nonatomic, strong) NSArray *teammatesLogins;
@property (nonatomic, strong) NSArray *currentProjects;
@property (nonatomic, strong) NSArray *pastProjects;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *joiningDate;
@property (nonatomic, strong) NSArray *socialNetworks;

@end
