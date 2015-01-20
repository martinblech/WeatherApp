//
//  ViewController.m
//  WeatherApp
//
//  Created by Martín Blech on 1/19/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

@import CoreLocation;
#import "WeatherViewController.h"
#import "OpenWeatherMapClient.h"
#import "Settings.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface WeatherViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) OpenWeatherMapClient *weatherClient;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *conditionImage;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeLocationManager];
    [RACObserve(self, desiredCity) subscribeNext:^(City *desiredCity) {
        if (desiredCity) {
            [self getWeatherForCity:desiredCity.name country:desiredCity.country];
        } else {
            [self getWeatherForCurrentLocation];
        }
    }];
    [RACObserve(self, weather) subscribeNext:^(Weather *weather) {
        NSString *cityName = weather.city.fullName;
        if (cityName.length) {
            self.cityLabel.text = cityName;
        } else {
            self.cityLabel.text = @"--";
        }
        WeatherCondition *condition = weather.conditions.firstObject;
        if (condition) {
            if (condition.detail.length) {
                self.conditionLabel.text = [NSString stringWithFormat:@"%@ (%@)", condition.name, condition.detail];
            } else {
                self.conditionLabel.text = condition.name;
            }
            [self.conditionImage sd_setImageWithURL:condition.iconURL];
        } else {
            self.conditionLabel.text = @"--";
            self.conditionImage.image = nil;
        }
        if (weather) {
            self.temperatureLabel.text = [NSString stringWithFormat:@"%d%@ (max: %d, min: %d)", (int)round(weather.temperature), [self temperatureUnitString], (int)round(weather.maximumTemperature), (int)round(weather.minimumTemperature)];
        } else {
            self.temperatureLabel.text = @"--";
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.desiredCity = self.desiredCity; // refresh
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (OpenWeatherMapClient *)weatherClient
{
    if (!_weatherClient) {
        _weatherClient = [[OpenWeatherMapClient alloc] init];
    }
    return _weatherClient;
}

- (void)initializeLocationManager
{
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"location services disabled");
    }
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted) {
        NSLog(@"location services unauthorized");
    }
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
}

- (void)getWeatherForCity:(NSString *)cityName country:(NSString *)country
{
    [self.weatherClient getWeatherWithCityName:cityName
                                       country:country
                                    unitFormat:[Settings sharedInstance].preferredUnitFormat
                                    completion:
     ^(OVCResponse *response, Weather *weather, NSError *error) {
         NSLog(@"weather: %@, error: %@", weather, error);
         // TODO: implement error handling workaround for broken API (HTTP status is 200 but JSON says 404)
         if (weather.city.name == nil) {
             weather = nil;
         }
         self.weather = weather;
     }];
}

- (void)getWeatherForCurrentLocation
{
    NSLog(@"Enabling location manager: %@", self.locationManager);
    if (self.locationManager) {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationUnavailableFallback
{
    [self getWeatherForCity:@"New York" country:@"US"];
}

- (NSString *)temperatureUnitString
{
    switch ([Settings sharedInstance].preferredUnitFormat) {
        case OpenWeatherMapUnitFormatMetric: return @"°C";
        case OpenWeatherMapUnitFormatImperial: return @"°F";
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didUpdateLocations: %@", locations);
    CLLocation *location = locations.lastObject;
    if (location) {
        [self.locationManager stopUpdatingLocation];
        CLLocationCoordinate2D coordinate = location.coordinate;
        [self.weatherClient getWeatherWithLatitude:coordinate.latitude
                                         longitude:coordinate.longitude
                                        unitFormat:[Settings sharedInstance].preferredUnitFormat
                                        completion:
         ^(OVCResponse *response, Weather *weather, NSError *error) {
             NSLog(@"weather: %@, error: %@", weather, error);
             self.weather = weather;
         }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"locationManager didFailWithError: %@", error);
    [self locationUnavailableFallback];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"locationManager didChangeAuthorizationStatus: %d", status);
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self locationUnavailableFallback];
            break;
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            break;
    }
}

@end
