//
//  SettingsViewController.m
//  WeatherApp
//
//  Created by Martín Blech on 1/20/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import "SettingsViewController.h"
#import "Settings.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *unitFormatSegmentedControl;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.unitFormatSegmentedControl.selectedSegmentIndex = [Settings sharedInstance].preferredUnitFormat;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [Settings sharedInstance].preferredUnitFormat = self.unitFormatSegmentedControl.selectedSegmentIndex;
}

@end
