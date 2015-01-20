//
//  OpenWeatherMapClient.h
//  WeatherApp
//
//  Created by Martín Blech on 1/19/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import <Overcoat/Overcoat.h>
#import "Weather.h"

typedef void(^OpenWeatherMapCompletionBlock)(OVCResponse *response, Weather *weather, NSError *error);

@interface OpenWeatherMapClient : OVCHTTPSessionManager

- (NSURLSessionDataTask *)getWeatherWithCityName:(NSString *)cityName country:(NSString *)country completion:(OpenWeatherMapCompletionBlock)completion;
- (NSURLSessionDataTask *)getWeatherWithCity:(City *)city completion:(OpenWeatherMapCompletionBlock)completion;
- (NSURLSessionDataTask *)getWeatherWithLatitude:(double)latitude longitude:(double)longitude completion:(OpenWeatherMapCompletionBlock)completion;

@end
