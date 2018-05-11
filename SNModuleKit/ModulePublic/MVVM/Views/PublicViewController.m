//
//  PublicViewController.m
//  SNMediatorKit
//
//  Created by snlo on 2018/5/1.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "PublicViewController.h"

@interface PublicViewController ()

@end

@implementation PublicViewController

#pragma mark -- life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // update form data
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // update position
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // do something
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // add subviews
    [self configureUserInterface];
    
    // add dataSource configure
    [self configureDataSource];
}

- (void)updateViewConstraints {
    
    // update position
    
    [super updateViewConstraints];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // set autolayout
}

#pragma mark -- <UITableViewDelegate>、、

#pragma mark -- CustomDelegate

#pragma mark -- event response

#pragma mark -- public methods

#pragma mark -- private methods
- (void)configureUserInterface {
    
}
- (void)configureDataSource {
    
}

#pragma mark -- getter setter

@end
