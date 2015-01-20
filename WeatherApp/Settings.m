//
//  Settings.m
//  WeatherApp
//
//  Created by Martín Blech on 1/20/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import "Settings.h"

static NSString * const kPreferredUnitFormatKey = @"PreferredUnitFormat";

@interface Settings ()

@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation Settings

- (instancetype)init
{
    [NSException raise:@"Unavailable" format:@"Use sharedInstance instead"];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static Settings *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initPrivate];
    });
    return instance;
}

- (NSUserDefaults *)defaults
{
    if (!_defaults) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return _defaults;
}

- (OpenWeatherMapUnitFormat)preferredUnitFormat
{
    [self.defaults synchronize];
    return [self.defaults integerForKey:kPreferredUnitFormatKey];
}

- (void)setPreferredUnitFormat:(OpenWeatherMapUnitFormat)preferredUnitFormat
{
    [self.defaults setInteger:preferredUnitFormat forKey:kPreferredUnitFormatKey];
    [self.defaults synchronize];
}

@end