//
//  OpenWeatherMapClient.m
//  WeatherApp
//
//  Created by Martín Blech on 1/19/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import "OpenWeatherMapClient.h"
#import <NSString-UrlEncode/NSString+URLEncode.h>

@implementation OpenWeatherMapClient

+ (NSDictionary *)modelClassesByResourcePath
{
    return @{
        @"data/2.5/weather": [Weather class],
    };
}

- (NSURLSessionDataTask *)getWeatherWithCityName:(NSString *)cityName country:(NSString *)country completion:(OpenWeatherMapCompletionBlock)completion
{
    cityName = [cityName URLEncode];
    country = [country URLEncode];
    NSString *URLString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@,%@", cityName, country];
    return [self GET:URLString parameters:nil completion:^(OVCResponse *response, NSError *error) {
        completion(response, response.result, error);
    }];
}

- (NSURLSessionDataTask *)getWeatherWithCity:(City *)city completion:(OpenWeatherMapCompletionBlock)completion
{
    return [self getWeatherWithCityName:city.name country:city.country completion:completion];
}

- (NSURLSessionDataTask *)getWeatherWithLatitude:(double)latitude longitude:(double)longitude completion:(OpenWeatherMapCompletionBlock)completion
{
    NSString *URLString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f", latitude, longitude];
    return [self GET:URLString parameters:nil completion:^(OVCResponse *response, NSError *error) {
        completion(response, response.result, error);
    }];
}

@end
