//
//  AppDelegate.h
//  GooglePlacesDemo
//
//  Created by bharat on 21/02/17.
//  Copyright © 2017 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *ceo;
    CLPlacemark *currentLocPlacemark;
    CLLocation *currentLocation;
    
}
@property (strong, nonatomic) UIWindow *window;


@end

