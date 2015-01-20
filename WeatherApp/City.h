//
//  City.h
//  WeatherApp
//
//  Created by Martín Blech on 1/19/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface City : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSURL *imageURL;
@property (nonatomic, readonly) NSString *fullName;

+ (NSArray *)allCities;

@end
