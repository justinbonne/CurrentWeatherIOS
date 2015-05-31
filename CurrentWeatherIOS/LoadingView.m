//
//  LoadingController.m
//  CurrentWeatherIOS
//
//  Created by Justin Bonne on 2015-05-31.
//  Copyright (c) 2015 Justin Bonne. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

+(LoadingView *)showLoaderInView:(UIView *)superView{
    
    LoadingView *loader= [[LoadingView alloc] initWithFrame:superView.bounds];
    if(!loader){return nil;}
    
    UIActivityIndicatorView *spinner =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    spinner.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin;
    
    spinner.center = superView.center;
    
    [loader addSubview:spinner];
    [spinner startAnimating];
    
    
    loader.backgroundColor = [[UIColor alloc] initWithWhite:0.0 alpha:0.4];
    
    [superView addSubview:loader];
    return loader;
}

-(void)removeLoader{
    [super removeFromSuperview];
}

@end
