//
//  Weather.h
//  CurrentWeatherIOS
//
//  Created by Justin Bonne on 2015-05-31.
//  Copyright (c) 2015 Justin Bonne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (weak, nonatomic) NSNumber *temperature;
@property (weak, nonatomic) NSString *icon;
@property (weak, nonatomic) NSString *summary;
@property (weak, nonatomic) NSNumber *windSpeed;
@property (weak, nonatomic) NSNumber *windBearing;
@property (weak, nonatomic) NSNumber *precipProbability;
@property (weak, nonatomic) NSNumber *precipIntensity;
@property (weak, nonatomic) NSString *precipType;
@property (weak, nonatomic) NSNumber *humidity;

+(Weather*) init;
-(NSString*) getFormattedTemperature;
-(NSString*) getFormattedWindSpeed;
-(NSString*) getFormattedWindBearing;
-(NSString*) getFormattedPrecipProbability;
-(NSString*) getFormattedPrecipType;
-(NSString*) getFormattedHumidity;

-(void) loadValuesFromJSON: (NSDictionary*) JSONDict;
+(NSString*) iconStringToEmoji: (NSString*) icon;

@end
