//
//  CityTests.m
//  WeatherApp
//
//  Created by Martín Blech on 1/19/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "City.h"

@interface CityTests : XCTestCase

@end

@implementation CityTests

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

- (void)testAllCities
{
    NSArray *allCities = [City allCities];
    expect(allCities).to.haveCountOf(7);
    
    City *london = allCities.firstObject;
    expect(london).toNot.beNil();
    expect(london.name).to.equal(@"London");
    expect(london.country).to.equal(@"UK");
    expect(london.imageURL).to.equal([NSURL URLWithString:@"http://scontent-a.cdninstagram.com/hphotos-xfa1/t51.2885-15/e15/10932167_831556373568695_682235807_n.jpg"]);
    
    City *betzlandia = allCities.lastObject;
    expect(betzlandia.name).to.equal(@"Betzlandia");
}

@end
