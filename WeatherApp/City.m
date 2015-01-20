//
//  City.m
//  WeatherApp
//
//  Created by Martín Blech on 1/19/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import "City.h"

@implementation City

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"name": @"city",
    };
}

+ (NSValueTransformer *)imageURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSArray *)allCities
{
    NSString *citiesFilePath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
    NSData *citiesData = [NSData dataWithContentsOfFile:citiesFilePath];
    NSDictionary *citiesJSON = [NSJSONSerialization JSONObjectWithData:citiesData options:0 error:nil];
    return [MTLJSONAdapter modelsOfClass:[City class] fromJSONArray:citiesJSON[@"cities"] error:nil];
}

- (NSString *)fullName
{
    NSMutableArray *nameComponents = [[NSMutableArray alloc] init];
    if (self.name.length) {
        [nameComponents addObject:self.name];
    }
    if (self.country.length) {
        [nameComponents addObject:self.country];
    }
    return [nameComponents componentsJoinedByString:@", "];
}

@end
