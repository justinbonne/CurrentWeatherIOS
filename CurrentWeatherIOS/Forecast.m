//
//  Forecast.m
//  CurrentWeatherIOS
//
//  Created by Justin Bonne on 2015-05-31.
//  Copyright (c) 2015 Justin Bonne. All rights reserved.
//

#import "Forecast.h"

static NSString *const FORECAST_URL = @"https://api.forecast.io/forecast/";
static NSString *const API_KEY = @"9809553ac289203e5f21597f0278a007";

@implementation Forecast

+(Forecast*) init{
    Forecast *newForecast = [Forecast alloc];
    
    newForecast.temperature = [NSNumber numberWithDouble:0.0];
    newForecast.icon = @"";
    newForecast.summary = @"";
    newForecast.windSpeed = [NSNumber numberWithDouble:0.0];
    newForecast.windBearing = [NSNumber numberWithDouble:0.0];
    newForecast.precipProbability = [NSNumber numberWithDouble:0.0];
    newForecast.precipIntensity = [NSNumber numberWithDouble:0.0];
    newForecast.precipType = @"";
    newForecast.humidity = [NSNumber numberWithDouble:0.0];
    
    newForecast.longitude = [NSNumber numberWithDouble:0.0];
    newForecast.latitude = [NSNumber numberWithDouble:0.0];
    
    return newForecast;
}

+(NSString*) iconStringToEmoji: (NSString*) icon{
    //class method to convert icon string from forecaset response
    // into a unicode string for different types of weather
    NSString *emoji = @"?";
    icon = @"partly-cloudy-night";
    if([icon isEqualToString:@"clear-day"]){
        // SUN
        emoji = @"\u2600";
    }
    else if([icon isEqualToString:@"clear-night"]){
        //CRESCENT MOON
        emoji = @"\uE04C";
    }
    else if([icon isEqualToString:@"rain"]){
        //UMBRELLA WITH RAIN DROPS
        emoji = @"\u2614";
    }
    else if([icon isEqualToString:@"snow"]){
        //SNOWFLAKE
        emoji = @"\u2744";
    }
    else if([icon isEqualToString:@"sleet"]){
        //SNOWFLAKE
        emoji = @"\u2744";
    }
    else if([icon isEqualToString:@"wind"]){
        //DASH SYMBOL
        emoji = @"\uE330";
    }
    else if([icon isEqualToString:@"fog"]){
        //CLOUD
        emoji = @"\u2601";
    }
    else if([icon isEqualToString:@"cloudy"]){
        //CLOUD
        emoji = @"\u2601";
    }
    else if([icon isEqualToString:@"partly-cloudy-day"]){
        //SUN BEHIND CLOUD
        emoji = @"\u26C5";
    }
    else if([icon isEqualToString:@"partly-cloudy-night"]){
        //CRESCENT MOON + CLOUD
        emoji = @"\uE04C\u2601";
    }
    return emoji;
}

-(NSString*) getFormattedTemperature{
    return [NSString stringWithFormat:@"%d\u00B0C",[_temperature intValue]];
}

-(NSString*) getFormattedWindSpeed{
    return [NSString stringWithFormat:@"%d km/h",[_windSpeed intValue]];
}

-(NSString*) getFormattedWindBearing{
    return [NSString stringWithFormat:@"%d\u00B0",[_windBearing intValue]];
}

-(NSString*) getFormattedPrecipProbability{
    NSNumber *percent = [NSNumber numberWithDouble:[_precipProbability doubleValue] * 100];
    return [NSString stringWithFormat:@"%d%%", [percent intValue]];
}

-(NSString*) getFormattedPrecipType{
    //return a string of the quality and type of precipitation
    //quality is based in the cm/h of intensity
    double intensity = [_precipIntensity doubleValue];
    NSString *precipQualifier = @"";
    if(intensity > 0 && intensity <= 0.005){
        precipQualifier = @"very light";
    }
    else if(intensity > 0.005 && intensity <= 0.043){
        precipQualifier = @"light";
    }
    else if(intensity > 0.043 && intensity <= 0.254){
        precipQualifier = @"moderate";
    }
    else if(intensity > 0.254){
        precipQualifier = @"heavy";
    }
    return [NSString stringWithFormat:@"%@ %@", precipQualifier, _precipType];
}

-(NSString*) getFormattedHumidity{
    NSNumber *percent = [NSNumber numberWithDouble:[_precipProbability doubleValue] * 100];
    return [NSString stringWithFormat:@"%d%%", [percent intValue]];
}

-(void) loadValuesFromJSON: (NSDictionary*) JSONDict{
    
    _temperature = [[JSONDict objectForKey:@"currently"]
                        objectForKey:@"apparentTemperature"];
    
    _icon = [[JSONDict objectForKey:@"currently"]
                 objectForKey:@"icon"];
    
    _summary = [[JSONDict objectForKey:@"currently"]
                    objectForKey:@"summary"];
    
    _windSpeed = [[JSONDict objectForKey:@"currently"]
                      objectForKey:@"windSpeed"];
    
    _windBearing = [[JSONDict objectForKey:@"currently"]
                        objectForKey:@"windBearing"];
    
    _precipProbability = [[JSONDict objectForKey:@"currently"]
                              objectForKey:@"precipProbability"];
    
    _precipIntensity = [[JSONDict objectForKey:@"currently"]
                            objectForKey:@"precipIntensity"];
    
    NSString *type = [[JSONDict objectForKey:@"currently"]
                     objectForKey:@"precipType"];
    
    _precipType = (type != nil)? type : @"";
    
    _humidity = [[JSONDict objectForKey:@"currently"]
                     objectForKey:@"humidity"];
}

-(NSDictionary*) makeForecastRequest{
    //make syncronous request to forecast.io api
    //return JSON result as parsed NSDictionary
    NSString *forecastCallString = [NSString stringWithFormat:
                                    @"%@%@/%@,%@?units=ca",
                                    FORECAST_URL,
                                    API_KEY,
                                    _latitude,
                                    _longitude ];
    
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
        NSDictionary *JSONDict = [NSJSONSerialization JSONObjectWithData:forecastData
                                                                 options:kNilOptions
                                                                   error:&JSONError];
        if (JSONError != nil) {
            NSLog(@"Error parsing JSON.");
            return [NSDictionary alloc];
        }
        else {
            return JSONDict;
        }
    }
    else{
        NSLog(@"Error with forecast request");
        return nil;
    }

}


@end
