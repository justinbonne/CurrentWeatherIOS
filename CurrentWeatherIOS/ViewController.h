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
#import "Forecast.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) NSMutableData *forecastReturnJSONData;
@property (strong, nonatomic) LoadingView *loader;
@property (strong, nonatomic)  Forecast *forecast;

@property (nonatomic, strong) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, strong) IBOutlet UILabel *iconLabel;
@property (nonatomic, strong) IBOutlet UILabel *summaryLabel;
@property (nonatomic, strong) IBOutlet UILabel *windSpeedLabel;
@property (nonatomic, strong) IBOutlet UILabel *windBearingLabel;
@property (nonatomic, strong) IBOutlet UILabel *precipProbabilityLabel;
@property (nonatomic, strong) IBOutlet UILabel *precipIntensityLabel;
@property (nonatomic, strong) IBOutlet UILabel *humidityLabel;

- (void)updateLabels;
@end

