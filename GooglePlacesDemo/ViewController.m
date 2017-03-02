//
//  ViewController.m
//  GooglePlacesDemo
//
//  Created by bharat on 21/02/17.
//  Copyright © 2017 bharat. All rights reserved.
//

#import "ViewController.h"
#import "MVPlaceSearchTextField.h"

static NSString * const KMapPlacesApiKey = @"AIzaSyBXkyGFCkEjWzBnOsGXxFVmUG_H26Y5p-g";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc] init];
    [self startLocationUpdates];
    latitude = locationManager.location.coordinate.latitude;
    longitude =locationManager.location.coordinate.longitude;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:19];
    //plotting the google map
    
    CGPoint point = _mapView_.center;
    GMSCameraUpdate *camera1 =[GMSCameraUpdate setTarget:[_mapView_.projection coordinateForPoint:point]];
    [_mapView_ animateWithCameraUpdate:camera1];
    
    self.title=@"PickUp Location";
    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0];
    
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:229.0/255.0f green:26.0/255.0f blue:90.0/255.0f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)startLocationUpdates
{
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.activityType = CLActivityTypeFitness;
    
    // Movement threshold for new events.
    locationManager.distanceFilter = 10; // meters
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *location = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude]; //insert your coordinates
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];
    [CATransaction commit];
    
    [ceo reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error)
     {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         NSLog(@"I am currently at %@",locatedAt);
       
         //  [self getLocationFromAddressString4:_searchDropAddRef.text];
         
     }
     ];
}


-(void)viewDidAppear:(BOOL)animated
{
    _searchDropRef.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    
    _searchDropRef.autoCompleteBoldFontName = @"HelveticaNeue";
    
    _searchDropRef.autoCompleteTableCornerRadius=0.0;
    
    _searchDropRef.autoCompleteRowHeight=35;
    
    _searchDropRef.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    
    _searchDropRef.autoCompleteFontSize=14;
    
    _searchDropRef.autoCompleteTableBorderWidth=1.0;
    
    _searchDropRef.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    
    _searchDropRef.autoCompleteShouldHideOnSelection=YES;
    
    _searchDropRef.autoCompleteShouldHideClosingKeyboard=YES;
    
    _searchDropRef.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    _searchDropRef.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_searchDropRef.frame.size.width)*0.01, _searchDropRef.frame.size.height+22.0, self.view.frame.size.width-0.1, 200.0);
}

#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict
{
    [self.view endEditing:YES];
    
     NSString *strdata=_searchDropRef.text;
    
    NSLog(@"%@",strdata);
   
}


-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField
{
    
}

-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField
{
    
}

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index
{
    
    if(index%2==0){
        
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        
    }else{
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    _searchDropRef.placeSearchDelegate                 = self;
    
    _searchDropRef.strApiKey                           = KMapPlacesApiKey;
    
    _searchDropRef.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    
    _searchDropRef.autoCompleteShouldHideOnSelection   = YES;
    
    _searchDropRef.maximumNumberOfAutoCompleteRows     = 5;
    
}




-(void)viewWillDisappear:(BOOL)animated
{
    //    NSDictionary *date=[[NSDictionary alloc] initWithObjectsAndKeys:_searchDropRef.text,@"Data", nil];
    //
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"anyname" object:self userInfo:date];
    
    [super viewWillDisappear:animated];
   
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
