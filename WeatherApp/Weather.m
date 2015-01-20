//
//  Weather.m
//  WeatherApp
//
//  Created by Martín Blech on 1/19/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import "Weather.h"

@interface WeatherCondition ()

@property (nonatomic, copy) NSString *iconId;

@end

@implementation WeatherCondition

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"name": @"main",
        @"detail": @"description",
        @"iconId": @"icon",
    };
}

- (NSURL *)iconURL
{
    if (self.iconId) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", self.iconId]];
    } else {
        return nil;
    }
}

@end

@interface Weather ()

@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *cityCountry;

@end

@implementation Weather

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"latitude": @"coord.lat",
        @"longitude": @"coord.lon",
        @"cityName": @"name",
        @"cityCountry": @"sys.country",
        @"sunrise": @"sys.sunrise",
        @"sunset": @"sys.sunset",
        @"conditions": @"weather",
        @"temperature": @"main.temp",
        @"minimumTemperature": @"main.temp_min",
        @"maximumTemperature": @"main.temp_max",
        @"pressure": @"main.pressure",
        @"seaLevel": @"main.sea_level",
        @"groundLevel": @"main.grnd_level",
        @"humidity": @"main.humidity",
        @"windSpeed": @"wind.speed",
        @"windAngleDegrees": @"wind.deg",
        @"clouds": @"clouds.all",
    };
}

+ (NSValueTransformer *)timestampTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSNumber *timestamp) {
        return [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
    } reverseBlock:^id(NSDate *date) {
        return @(date.timeIntervalSince1970);
    }];
}

+ (NSValueTransformer *)sunriseJSONTransformer
{
    return [self timestampTransformer];
}

+ (NSValueTransformer *)sunsetJSONTransformer
{
    return [self timestampTransformer];
}

+ (NSValueTransformer *)conditionsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[WeatherCondition class]];
}

- (City *)city
{
    City *city = [[City alloc] init];
    city.name = self.cityName;
    city.country = self.cityCountry;
    return city;
}

@end
