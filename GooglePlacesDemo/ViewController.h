//
//  ViewController.h
//  GooglePlacesDemo
//
//  Created by bharat on 21/02/17.
//  Copyright © 2017 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPlaceSearchTextField.h"
#import <CoreLocation/CoreLocation.h>
@import GoogleMaps;

@interface ViewController : UIViewController<PlaceSearchTextFieldDelegate,CLLocationManagerDelegate,GMSMapViewDelegate>
{
    CLLocationManager *locationManager;
    float			latitude;
    float			longitude;
}

@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *searchDropRef;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView_;
@end

