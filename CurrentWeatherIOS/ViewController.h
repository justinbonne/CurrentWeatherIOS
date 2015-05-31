//
//  ViewController.h
//  CurrentWeatherIOS
//
//  Created by Justin Bonne on 2015-05-30.
//  Copyright (c) 2015 Justin Bonne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LoadingView.h"
#import "Weather.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) NSMutableData *forecastReturnJSONData;
@property (strong, nonatomic) LoadingView *loader;
@property (strong, nonatomic)  Weather *weather;

@property (nonatomic, strong) IBOutletCollection(UILabel)
NSArray *temperatureLabels;
@property (nonatomic, strong) IBOutletCollection(UILabel)
NSArray *iconLabels;
@property (nonatomic, strong) IBOutletCollection(UILabel)
NSArray *summaryLabels;
@property (nonatomic, strong) IBOutletCollection(UILabel)
NSArray *windSpeedLabels;
@property (nonatomic, strong) IBOutletCollection(UILabel)
NSArray *windBearingLabels;
@property (nonatomic, strong) IBOutletCollection(UILabel)
NSArray *precipProbabilityLabels;
@property (nonatomic, strong) IBOutletCollection(UILabel)
NSArray *precipIntensityLabels;
@property (nonatomic, strong) IBOutletCollection(UILabel)
NSArray *humidityLabels;

- (void)updateLabels;
@end

