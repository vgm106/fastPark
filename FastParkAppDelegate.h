//
//  FastParkAppDelegate.h
//  fastPark
//
//  Created by Madhu Ganesh on 7/3/13.
//  Copyright (c) 2013 Madhu Ganesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FastParkViewController;

@interface FastParkAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FastParkViewController *viewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
