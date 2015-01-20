//
//  WeatherTests.m
//  WeatherApp
//
//  Created by Martín Blech on 1/19/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "Weather.h"

@interface WeatherTests : XCTestCase

@end

@implementation WeatherTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJSONLoad
{
    NSString *weatherFilePath = [[NSBundle bundleForClass:[WeatherTests class]] pathForResource:@"weather" ofType:@"json"];
    NSData *weatherData = [NSData dataWithContentsOfFile:weatherFilePath];
    NSDictionary *weatherJSON = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:nil];
    Weather *weather = [MTLJSONAdapter modelOfClass:[Weather class] fromJSONDictionary:weatherJSON error:nil];
    
    expect(weather.latitude).to.equal(-32.89);
    expect(weather.longitude).to.equal(-68.84);
    expect(weather.city.name).to.equal(@"Mendoza");
    expect(weather.city.country).to.equal(@"AR");
    expect(weather.sunrise).to.equal([NSDate dateWithTimeIntervalSince1970:1421747259]);
    expect(weather.sunset).to.equal([NSDate dateWithTimeIntervalSince1970:1421797520]);
    expect(weather.temperature).to.equal(289.199);
    expect(weather.minimumTemperature).to.equal(289.199);
    expect(weather.maximumTemperature).to.equal(289.199);
    expect(weather.pressure).to.equal(861.96);
    expect(weather.seaLevel).to.equal(1030.97);
    expect(weather.groundLevel).to.equal(861.96);
    expect(weather.humidity).to.equal(54);
    expect(weather.windSpeed).to.equal(1.32);
    expect(weather.windAngleDegrees).to.equal(177.504);
    expect(weather.clouds).to.equal(88);
    
    WeatherCondition *condition = weather.conditions.firstObject;
    expect(condition.name).to.equal(@"Clouds");
    expect(condition.detail).to.equal(@"overcast clouds");
    expect(condition.iconURL).to.equal([NSURL URLWithString:@"http://openweathermap.org/img/w/04n.png"]);
}

@end
