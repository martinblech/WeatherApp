//
//  ViewController.h
//  WeatherApp
//
//  Created by Martín Blech on 1/19/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"
#import "City.h"

@interface WeatherViewController : UIViewController

@property (nonatomic, strong) Weather *weather;
@property (nonatomic, strong) City *desiredCity;

@end

