//
//  ViewController.m
//  CurrentWeatherIOS
//
//  Created by Justin Bonne on 2015-05-30.
//  Copyright (c) 2015 Justin Bonne. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup location manager and start updating location
    self.locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    
    //show loading spinner
    self.loader = [LoadingView showLoaderInView:self.view];
    
    //initialize forecast object
    self.forecast = [Forecast init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    
    //stop updating location (we only need it once)
    [_locationManager stopUpdatingLocation];

    //load long./lat. into forecast object
    CLLocation *newLocation = [locations lastObject];
    _forecast.longitude = [NSNumber numberWithDouble:newLocation.coordinate.longitude];
    _forecast.latitude = [NSNumber numberWithDouble:newLocation.coordinate.latitude];
    
    //make forecast request and update the forecast object and update labels in view
    NSDictionary *forecastResponse = [_forecast makeForecastRequest];
    if(forecastResponse != nil){
        [_forecast loadValuesFromJSON:forecastResponse];
        [self updateLabels];
    }
    
    //hide loading spinner when done
    [self.loader removeLoader];
}

- (void)updateLabels{
    _temperatureLabel.text = [_forecast getFormattedTemperature];
    _iconLabel.text = [Forecast iconStringToEmoji:_forecast.icon];
    _summaryLabel.text = _forecast.summary;
    _windSpeedLabel.text = [_forecast getFormattedWindSpeed];
    _windBearingLabel.text = [_forecast getFormattedWindBearing];
    _precipProbabilityLabel.text = [_forecast getFormattedPrecipProbability];
    _precipIntensityLabel.text = [_forecast getFormattedPrecipType];
    _humidityLabel.text = [_forecast getFormattedHumidity];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSString *errorType = (error.code == kCLErrorDenied)?
        @"Access Denied" : @"Unknown Error";
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error getting Location"
                          message:errorType
                          delegate:nil
                          cancelButtonTitle:@"Okay"
                          otherButtonTitles:nil];
    [alert show];
}

@end
