//
//  ViewController.m
//  CurrentWeatherIOS
//
//  Created by Justin Bonne on 2015-05-30.
//  Copyright (c) 2015 Justin Bonne. All rights reserved.
//

#import "ViewController.h"

static NSString *const FORECAST_URL = @"https://api.forecast.io/forecast/";
static NSString *const API_KEY = @"9809553ac289203e5f21597f0278a007";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    self.loader = [LoadingView showLoaderInView:self.view];
    self.weather = [Weather init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{

    [_locationManager stopUpdatingLocation];
    CLLocation *newLocation = [locations lastObject];
    NSString *forecastCallString = [NSString stringWithFormat:
                                    @"%@%@/%g,%g?units=ca",
                                    FORECAST_URL,
                                    API_KEY,
                                    newLocation.coordinate.latitude,
                                    newLocation.coordinate.longitude ];
   
    
    NSURL *forecastURL = [NSURL URLWithString:forecastCallString];
    NSURLRequest *forecastRequest = [NSURLRequest requestWithURL:forecastURL];
    NSURLResponse * forecastResponse = nil;
    NSError * forecastError = nil;
    NSData * forecastData = [NSURLConnection sendSynchronousRequest:forecastRequest
                                                  returningResponse:&forecastResponse
                                                              error:&forecastError];
    
    
    if (forecastError == nil)
    {
        NSError *JSONError = nil;
        NSDictionary *JSONDict = [NSJSONSerialization JSONObjectWithData:forecastData options:kNilOptions error:&JSONError];
        
        if (JSONError != nil) {
            NSLog(@"Error parsing JSON.");
        }
        else {
            [self.weather loadValuesFromJSON:JSONDict];
            [self updateLabels];
        }
    }
    else{
        NSLog(@"Error with forecast request");
    }
    [self.loader removeLoader];
}

- (void)updateLabels{
    for(UILabel *temperature in _temperatureLabels){
        temperature.text = [self.weather getFormattedTemperature];
    }
    
    for(UILabel *icon in _iconLabels){
        icon.text = [Weather iconStringToEmoji:self.weather.icon];
    }
    
    for(UILabel *summary in _summaryLabels){
        summary.text = self.weather.summary;
    }
    
    for(UILabel *windSpeed in _windSpeedLabels){
        windSpeed.text = [self.weather getFormattedWindSpeed];
    }
    
    for(UILabel *windBearing in _windBearingLabels){
        windBearing.text = [self.weather getFormattedWindBearing];
    }
    
    for(UILabel *precipProbability in _precipProbabilityLabels){
        precipProbability.text = [self.weather getFormattedPrecipProbability];
    }
    
    for(UILabel *precipIntensity in _precipIntensityLabels){
        precipIntensity.text = [self.weather getFormattedPrecipType];
    }
    
    for(UILabel *humidity in _humidityLabels){
        humidity.text = [self.weather getFormattedHumidity];
    }
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
