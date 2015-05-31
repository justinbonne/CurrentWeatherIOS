//
//  Weather.m
//  CurrentWeatherIOS
//
//  Created by Justin Bonne on 2015-05-31.
//  Copyright (c) 2015 Justin Bonne. All rights reserved.
//

#import "Weather.h"

@implementation Weather

+(Weather*) init{
    Weather *newWeather = [Weather alloc];
    
    newWeather.temperature = [NSNumber numberWithDouble:0.0];
    newWeather.icon = @"";
    newWeather.summary = @"";
    newWeather.windSpeed = [NSNumber numberWithDouble:0.0];
    newWeather.windBearing = [NSNumber numberWithDouble:0.0];
    newWeather.precipProbability = [NSNumber numberWithDouble:0.0];
    newWeather.precipIntensity = [NSNumber numberWithDouble:0.0];
    newWeather.precipType = @"";
    newWeather.humidity = [NSNumber numberWithDouble:0.0];
    
    return newWeather;
}

-(NSString*) getFormattedTemperature{
    return [NSString stringWithFormat:@"%d\u00B0C",[self.temperature intValue]];
}
-(NSString*) getFormattedWindSpeed{
    return [NSString stringWithFormat:@"%d km/h",[self.windSpeed intValue]];
}

-(NSString*) getFormattedWindBearing{
    return [NSString stringWithFormat:@"%d\u00B0",[self.windBearing intValue]];
}

-(NSString*) getFormattedPrecipProbability{
    NSNumber *percent = [NSNumber numberWithDouble:[self.precipProbability doubleValue] * 100];
    return [NSString stringWithFormat:@"%d%%", [percent intValue]];
}

-(NSString*) getFormattedPrecipType{
    double intensity = [self.precipIntensity doubleValue];
    NSString *precipQuantifier = @"";
    if(intensity > 0 && intensity <= 0.005){
        precipQuantifier = @"very light";
    }
    else if(intensity > 0.005 && intensity <= 0.043){
        precipQuantifier = @"light";
    }
    else if(intensity > 0.043 && intensity <= 0.254){
        precipQuantifier = @"moderate";
    }
    else if(intensity > 0.254){
        precipQuantifier = @"heavy";
    }
    
    return [NSString stringWithFormat:@"%@ %@", precipQuantifier, self.precipType];
}
-(NSString*) getFormattedHumidity{
    NSNumber *percent = [NSNumber numberWithDouble:[self.precipProbability doubleValue] * 100];
    return [NSString stringWithFormat:@"%d%%", [percent intValue]];
}

-(void) loadValuesFromJSON: (NSDictionary*) JSONDict{
    self.temperature = [[JSONDict objectForKey:@"currently"]
                        objectForKey:@"apparentTemperature"];
    self.icon = [[JSONDict objectForKey:@"currently"]
                 objectForKey:@"icon"];
    self.summary = [[JSONDict objectForKey:@"currently"]
                    objectForKey:@"summary"];
    self.windSpeed = [[JSONDict objectForKey:@"currently"]
                      objectForKey:@"windSpeed"];
    self.windBearing = [[JSONDict objectForKey:@"currently"]
                        objectForKey:@"windBearing"];
    self.precipProbability = [[JSONDict objectForKey:@"currently"]
                              objectForKey:@"precipProbability"];
    self.precipIntensity = [[JSONDict objectForKey:@"currently"]
                            objectForKey:@"precipIntensity"];
    NSString *type = [[JSONDict objectForKey:@"currently"]
                     objectForKey:@"precipType"];
    self.precipType = (type != nil)? type : @"";
    
    self.humidity = [[JSONDict objectForKey:@"currently"]
                     objectForKey:@"humidity"];
}

+(NSString*) iconStringToEmoji: (NSString*) icon{
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

@end
