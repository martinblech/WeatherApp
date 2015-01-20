//
//  Settings.h
//  WeatherApp
//
//  Created by Martín Blech on 1/20/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenWeatherMapClient.h"

@interface Settings : NSObject

@property (nonatomic, assign) OpenWeatherMapUnitFormat preferredUnitFormat;

+ (instancetype)sharedInstance;

@end
