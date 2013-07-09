//
//  FastParkViewController.h
//  fastPark
//
//  Created by Madhu Ganesh on 7/3/13.
//  Copyright (c) 2013 Madhu Ganesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FastParkViewController : UIViewController<UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSArray *pLots;

-(void)moveCameraTo:(NSString *) lot;

@end
