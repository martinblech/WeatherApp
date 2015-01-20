//
//  CityCollectionViewCell.m
//  WeatherApp
//
//  Created by Martín Blech on 1/20/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import "CityCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CityCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cityImageView;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;

@end

@implementation CityCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCity:(City *)city
{
    _city = city;
    [self.cityImageView sd_setImageWithURL:self.city.imageURL];
    self.cityNameLabel.text = self.city.fullName;
}

@end
