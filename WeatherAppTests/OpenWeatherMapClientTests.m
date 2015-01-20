//
//  OpenWeatherMapClientTests.m
//  WeatherApp
//
//  Created by Martín Blech on 1/20/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "OpenWeatherMapClient.h"

@interface OpenWeatherMapClientTests : XCTestCase

@property (nonatomic, strong) OpenWeatherMapClient *client;

@end

@implementation OpenWeatherMapClientTests

- (void)setUp
{
    [super setUp];
    self.client = [[OpenWeatherMapClient alloc] init];
    [Expecta setAsynchronousTestTimeout:30];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.client = nil;
}

- (void)testGetByCity
{
    City *city = [[City alloc] init];
    city.name = @"Mendoza";
    city.country = @"AR";
    __block Weather *weather;
    __block NSError *error;
    [self.client getWeatherWithCity:city unitFormat:OpenWeatherMapUnitFormatMetric completion:^(OVCResponse *response, Weather *_weather, NSError *_error) {
        weather = _weather;
        error = _error;
    }];
    expect(weather).willNot.beNil();
    expect(error).to.beNil();
    expect(weather.city.name).to.equal(@"Mendoza");
    expect(weather.city.country).to.equal(@"AR");
}

- (void)testGetByCityString
{
    __block Weather *weather;
    __block NSError *error;
    [self.client getWeatherWithCityName:@"New York" country:@"US" unitFormat:OpenWeatherMapUnitFormatMetric completion:^(OVCResponse *response, Weather *_weather, NSError *_error) {
        weather = _weather;
        error = _error;
    }];
    expect(weather).willNot.beNil();
    expect(error).to.beNil();
    expect(weather.city.name).to.equal(@"New York");
    expect(weather.city.country).to.equal(@"US");
}

- (void)testGetByGeo
{
    __block Weather *weather;
    __block NSError *error;
    [self.client getWeatherWithLatitude:15.865 longitude:-97.068 unitFormat:OpenWeatherMapUnitFormatMetric completion:^(OVCResponse *response, Weather *_weather, NSError *_error) {
        weather = _weather;
        error = _error;
    }];
    expect(weather).willNot.beNil();
    expect(error).to.beNil();
    expect(weather.city.name).to.equal(@"Puerto Escondido");
    expect(weather.city.country).to.equal(@"MX");
}

- (void)testMetricVsImperial
{
    __block Weather *metric;
    __block Weather *imperial;
    [self.client getWeatherWithLatitude:15.865 longitude:-97.068 unitFormat:OpenWeatherMapUnitFormatMetric completion:^(OVCResponse *response, Weather *weather, NSError *error) {
        metric = weather;
    }];
    [self.client getWeatherWithLatitude:15.865 longitude:-97.068 unitFormat:OpenWeatherMapUnitFormatImperial completion:^(OVCResponse *response, Weather *weather, NSError *error) {
        imperial = weather;
    }];
    expect(metric).willNot.beNil();
    expect(imperial).willNot.beNil();
    double metricTemperatureInFahrenheit = ((metric.temperature * 9.0) / 5.0) + 32.0;
    expect(imperial.temperature).to.beCloseToWithin(metricTemperatureInFahrenheit, 0.1);
}

@end
