//
//  Forecast.h
//  CurrentWeatherIOS
//
//  Created by Justin Bonne on 2015-05-31.
//  Copyright (c) 2015 Justin Bonne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Forecast : NSObject

@property (weak, nonatomic) NSNumber *temperature;
@property (weak, nonatomic) NSString *icon;
@property (weak, nonatomic) NSString *summary;
@property (weak, nonatomic) NSNumber *windSpeed;
@property (weak, nonatomic) NSNumber *windBearing;
@property (weak, nonatomic) NSNumber *precipProbability;
@property (weak, nonatomic) NSNumber *precipIntensity;
@property (weak, nonatomic) NSString *precipType;
@property (weak, nonatomic) NSNumber *humidity;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *latitude;

+(Forecast*) init;
+(NSString*) iconStringToEmoji: (NSString*) icon;
-(NSString*) getFormattedTemperature;
-(NSString*) getFormattedWindSpeed;
-(NSString*) getFormattedWindBearing;
-(NSString*) getFormattedPrecipProbability;
-(NSString*) getFormattedPrecipType;
-(NSString*) getFormattedHumidity;
-(NSDictionary*) makeForecastRequest;
-(void) loadValuesFromJSON: (NSDictionary*) JSONDict;


@end
