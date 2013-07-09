//
//  FastParkAppDelegate.m
//  fastPark
//
//  Created by Madhu Ganesh on 7/3/13.
//  Copyright (c) 2013 Madhu Ganesh. All rights reserved.
//

#import "FastParkAppDelegate.h"
#import "FastParkViewController.h"

#import "MMLeftSideDrawerViewController.h"
#import "MMDrawerVisualStateManager.h"

#import <MMDrawerController.h>
#import <MMDrawerVisualState.h>

#import <Scringo/ScringoAgent.h>
#import <GoogleMaps/GoogleMaps.h>

#import "Building.h"
#import "ParkingLot.h"

@implementation FastParkAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [GMSServices provideAPIKey:@"AIzaSyClec2eL4anHgZXeuZCDpMBn1zDtAsrHDo"];
    
    UIViewController *leftViewController = [[MMLeftSideDrawerViewController alloc] init];
    FastParkViewController  *centerViewController = [[FastParkViewController alloc] init];
    
    centerViewController.managedObjectContext = self.managedObjectContext;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    
    [navigationController.navigationBar.topItem setRightBarButtonItem:[ScringoAgent scringoActivationBarItem]];
    
    MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:navigationController leftDrawerViewController:leftViewController];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    
    [drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.viewController = [[FastParkViewController alloc] initWithNibName:@"FastParkViewController" bundle:nil];
    [self.window setRootViewController:drawerController];
    [self.window makeKeyAndVisible];
    
    //API keys for 3rd party libraries and services
    
    [ScringoAgent startSession:@"p2mAHDPMwLhgPcgs33mwWXyKHVaBUPdK" locationManager:nil];
    [ScringoAgent setScringoActivationButtonType:SCRINGO_BUTTON4];
    [ScringoAgent pauseSwipe];
    
    
    //[self create];
    //[self read];
    return YES;
}

//-(void) create{
//    //grab context
//    NSManagedObjectContext *context = [self managedObjectContext];
//    
//
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)create {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //Building *building = [NSEntityDescription insertNewObjectForEntityForName:@"Building" inManagedObjectContext:context];
    
    //building.name = @"HRI";
    
//    ParkingLot *pLot = [NSEntityDescription insertNewObjectForEntityForName:@"ParkingLot" inManagedObjectContext:context];
//    
//    pLot.name = @"Starfish";
//    pLot.latitude = [NSNumber numberWithFloat: 27.715289];
//    pLot.longitude = [NSNumber numberWithFloat: -97.326892];
//    
//    pLot = [NSEntityDescription insertNewObjectForEntityForName:@"ParkingLot" inManagedObjectContext:context];
//    
//    pLot.name = @"Angelfish";
//    pLot.latitude = [NSNumber numberWithFloat: 27.714529];
//    pLot.longitude = [NSNumber numberWithFloat: -97.325642];
//    
//    pLot = [NSEntityDescription insertNewObjectForEntityForName:@"ParkingLot" inManagedObjectContext:context];
//    
//    pLot.name = @"Seahorse";
//    pLot.latitude = [NSNumber numberWithFloat: 27.714061];
//    pLot.longitude = [NSNumber numberWithFloat: -97.327334];
//    
//    pLot = [NSEntityDescription insertNewObjectForEntityForName:@"ParkingLot" inManagedObjectContext:context];
//    
//    pLot.name = @"Jellyfish"; 
//    pLot.latitude = [NSNumber numberWithFloat: 27.712428];
//    pLot.longitude = [NSNumber numberWithFloat: -97.326838];
//    
//    pLot = [NSEntityDescription insertNewObjectForEntityForName:@"ParkingLot" inManagedObjectContext:context];
//    
//    pLot.name = @"Turtle Cove";
//    pLot.latitude = [NSNumber numberWithFloat: 27.71097];
//    pLot.longitude = [NSNumber numberWithFloat:  -97.325848];
//    
//    pLot = [NSEntityDescription insertNewObjectForEntityForName:@"ParkingLot" inManagedObjectContext:context];
//    
//    pLot.name = @"Sand dollar"; 
//    pLot.latitude = [NSNumber numberWithFloat: 27.713743];
//    pLot.longitude = [NSNumber numberWithFloat: -97.321173];
//    
//    pLot = [NSEntityDescription insertNewObjectForEntityForName:@"ParkingLot" inManagedObjectContext:context];
//    
//    pLot.name = @"Hammerhead"; 
//    pLot.latitude = [NSNumber numberWithFloat: 27.712941];
//    pLot.longitude = [NSNumber numberWithFloat: -97.319537];
//    
//    pLot = [NSEntityDescription insertNewObjectForEntityForName:@"ParkingLot" inManagedObjectContext:context];
//    
//    pLot.name = @"Seabreeze"; 
//    pLot.latitude = [NSNumber numberWithFloat: 27.713142];
//    pLot.longitude = [NSNumber numberWithFloat: -97.322345];
//    
//    pLot = [NSEntityDescription insertNewObjectForEntityForName:@"ParkingLot" inManagedObjectContext:context];
//    
//    pLot.name = @"Tarpon"; 
//    pLot.latitude = [NSNumber numberWithFloat: 27.71262];
//    pLot.longitude = [NSNumber numberWithFloat: -97.321331];
//    
//    pLot = [NSEntityDescription insertNewObjectForEntityForName:@"ParkingLot" inManagedObjectContext:context];
//    
//    pLot.name = @"Curlew"; 
//    pLot.latitude = [NSNumber numberWithFloat: 27.712181];
//    pLot.longitude = [NSNumber numberWithFloat: -97.322981];
    
    // Save everything
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
    
    
}

-(void)read
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Construct a fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ParkingLot"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name LIKE[c] 'NRC')"];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for(ParkingLot *pLot in fetchedObjects)
    {
        double lat = [pLot.latitude doubleValue];
        double lon = [pLot.longitude doubleValue];
        NSLog(@"%@, Lat: %f, Lon: %f", pLot.name, lat, lon);
    }
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FastPark" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FastPark.sqlite"];
    
//    if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
//        NSURL *preloadURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"FastPark" ofType:@"sqlite"]];
//        NSError* err = nil;
//        
//        if (![[NSFileManager defaultManager] copyItemAtURL:preloadURL toURL:storeURL error:&err]) {
//            NSLog(@"Oops, could copy preloaded data");
//        }
//    }
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
