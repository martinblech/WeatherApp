//
//  Weather.h
//  WeatherApp
//
//  Created by Martín Blech on 1/19/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "City.h"

@interface WeatherCondition : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, readonly) NSURL *iconURL;

@end

@interface Weather : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, readonly) City *city;
@property (nonatomic, copy) NSDate *sunrise;
@property (nonatomic, copy) NSDate *sunset;
@property (nonatomic, copy) NSArray *conditions;
@property (nonatomic, assign) double temperature;
@property (nonatomic, assign) double minimumTemperature;
@property (nonatomic, assign) double maximumTemperature;
@property (nonatomic, assign) double pressure;
@property (nonatomic, assign) double seaLevel;
@property (nonatomic, assign) double groundLevel;
@property (nonatomic, assign) double humidity;
@property (nonatomic, assign) double windSpeed;
@property (nonatomic, assign) double windAngleDegrees;
@property (nonatomic, assign) double clouds;

@end
