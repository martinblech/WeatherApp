//
//  ViewController.m
//  WeatherApp
//
//  Created by Martín Blech on 1/19/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import "ViewController.h"
#import "OpenWeatherMapClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[[OpenWeatherMapClient alloc] init] getWeatherWithCityName:@"New York" country:@"US" completion:^(OVCResponse *response, Weather *weather, NSError *error) {
        NSLog(@"got response: %@", response);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
