//
//  LoadingController.h
//  CurrentWeatherIOS
//
//  Created by Justin Bonne on 2015-05-31.
//  Copyright (c) 2015 Justin Bonne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

+(LoadingView *)showLoaderInView:(UIView *)superView;

-(void)removeLoader;

@end
