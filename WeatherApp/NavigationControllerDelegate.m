//
//  NavigationControllerDelegate.m
//  WeatherApp
//
//  Created by Martín Blech on 1/20/15.
//  Copyright (c) 2015 Martin Blech. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "WeatherViewController.h"
#import "CitiesCollectionViewController.h"
#import "ZoomTransitionAnimator.h"

@implementation NavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ([fromVC isKindOfClass:[WeatherViewController class]] &&
        [toVC isKindOfClass:[CitiesCollectionViewController class]]) {
        return [[ZoomTransitionAnimator alloc] init];
    }
    return nil;
}

@end
