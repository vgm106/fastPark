//
//  FastParkViewController.m
//  fastPark
//
//  Created by Madhu Ganesh on 7/3/13.
//  Copyright (c) 2013 Madhu Ganesh. All rights reserved.
//

#import "FastParkViewController.h"

#import "MMDrawerVisualStateManager.h"
#import "MMLeftSideDrawerViewController.h"

#import <MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import "ParkingLot.h"
#import "Building.h"

#import <Scringo/ScringoAgent.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface FastParkViewController ()

@property(strong,nonatomic) GMSMapView *mapView;
@property(strong,nonatomic) GMSCameraUpdate *parkLotCam;
@property(strong,nonatomic) GMSMarker *marker;

@property(strong,nonatomic) UIButton *button;
@property(nonatomic,readwrite) CLLocationCoordinate2D parkLot;

@property(strong,nonatomic) NSString *currentLot;
@property(nonatomic,readwrite) CGFloat currentZoom;
@property(nonatomic,readwrite) CGFloat scrollX;
@property(nonatomic,readwrite) CGFloat scrollY;

@end

@implementation FastParkViewController

-(FastParkViewController *)init
{
    _parkLot = kCLLocationCoordinate2DInvalid;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
    //right button
    UIButton *scringo =  [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image  = [UIImage imageNamed:@"ScrImg_ribbonicon4@2x.png"];
    [scringo setImage:image forState:UIControlStateNormal];
    [scringo setContentMode:UIViewContentModeScaleToFill];
    
    [scringo addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scringo setTitle:@"scringo" forState:UIControlStateNormal];
    scringo.frame = CGRectMake(0, 0, image.size.width*0.55, image.size.height*0.575);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scringo];
    [self.navigationController.navigationBar.topItem setRightBarButtonItem:barButtonItem];
    
    //left button
    [self setupLeftMenuButton];
    
    //Google Maps
    CGFloat h = self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:27.71328
                                                            longitude:-97.324411
                                                                 zoom:15];
    _mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, 320, h) camera:camera];
    _mapView.myLocationEnabled = YES;
    [self.view  addSubview:_mapView];
    
    // Creates a marker in the center of the map.
    _marker = [[GMSMarker alloc] init];
    _marker.position = CLLocationCoordinate2DMake(27.71328, -97.32441);
    _marker.title = @"Texas A&M University - Corpus Christi";
    _marker.snippet = @"6300 Ocean Dr";
    _marker.map = _mapView;
    

    
    //An invisible close button to work around the lack off close 'swipe' disable in scingo
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(270, 0, 50, h);
    [_button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [_button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [_button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [_button addTarget:self action:@selector(closeScringoButtonClicked:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:_button];
     _button.hidden = true;
    
    self.mm_drawerController.managedObjectContext = _managedObjectContext;
    
}

//To close scringo properly
- (void) closeScringoButtonClicked: (id)sender
{
    NSLog( @"tapped" );
    [_mapView.settings setScrollGestures:YES];
    _button.hidden = true;
} 

-(void)rightBarButtonClicked:(id)sender
{
    NSLog( @"Button clicked." );
//    if(![_button isHidden])
//    {
//        _button.hidden = true;
//        [ScringoAgent closeSidebar];
//        [_mapView.settings setScrollGestures:YES];
//    }
//    else{
        _button.hidden = false;
        [ScringoAgent openSidebar];
        [_mapView.settings setScrollGestures:NO];
    //}
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSLog( @"map dissapeared" );
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog( @"map apeared" );
    //refocus
    if(CLLocationCoordinate2DIsValid(_parkLot))
    {
        NSLog(@"test in refocus");
        _parkLotCam = [GMSCameraUpdate setTarget:_parkLot zoom:_currentZoom];
        [_mapView animateWithCameraUpdate:_parkLotCam];
        
        //marker
        _marker = [[GMSMarker alloc] init];
        _marker.position = _parkLot;
        _marker.title = _currentLot;
        _marker.map = _mapView;
        

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)moveCameraTo:(NSString *)lot
{
    NSLog(@"%@",lot);
    _currentLot = [NSString stringWithFormat:@"%@ Parking Lot",lot];
    
    //_managedObjectContext = [(FastParkAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ParkingLot" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name LIKE[c] %@)",lot];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    _pLots = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for(ParkingLot *pLot in _pLots){
    double lat = [pLot.latitude doubleValue];
    double lon = [pLot.longitude doubleValue];
    _parkLot = CLLocationCoordinate2DMake(lat, lon);
    _currentZoom = 18.0;
    }
//    if([lot isEqualToString:@"HRI"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.715864, -97.328104);
//        _currentZoom = 19.0;
//    }
//    else if([lot isEqualToString:@"NRC"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.715548, -97.328506);
//        _currentZoom = 18.5;
//
//    }
//    else if([lot isEqualToString:@"Starfish"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.715289, -97.326892);
//        _currentZoom = 18.2;
//        
//    }
//    else if([lot isEqualToString:@"Angelfish"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.714529, -97.325642);
//         _currentZoom = 19.5;
//        
//    }
//    else if([lot isEqualToString:@"Seahorse"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.714061, -97.327334);
//         _currentZoom = 18.2;
//        
//    }
//    else if([lot isEqualToString:@"Jellyfish"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.712428, -97.326838);
//         _currentZoom = 18.5;
//        
//    }
//    else if([lot isEqualToString:@"Turtle Cove"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.71097, -97.325848);
//         _currentZoom = 18.4;
//        
//    }
//    else if([lot isEqualToString:@"Sand dollar"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.713743, -97.321173);
//        _currentZoom = 17.6;
//        
//    }
//    else if([lot isEqualToString:@"Hammerhead"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.712941,-97.319537);
//        _currentZoom = 18.5;
//    }
//    else if([lot isEqualToString:@"Seabreeze"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.713142,-97.322345);
//        _currentZoom = 19.1;
//    }
//    else if([lot isEqualToString:@"Tarpon"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.71262,-97.321331);
//        _currentZoom = 18.4;
//    }
//    else if([lot isEqualToString:@"Curlew"])
//    {
//        _parkLot = CLLocationCoordinate2DMake(27.712181,-97.322981);
//        _currentZoom = 18.2;
//    }
    
    

}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
     NSLog( @"left Button clicked." );
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
