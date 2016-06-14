//
//  AppDelegate.h
//  CargoGuroViper
//
//  Created by Виктория on 24.02.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MMDrawerController.h"

@class JVFloatingDrawerViewController;
@class JVFloatingDrawerSpringAnimator;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) JVFloatingDrawerViewController *drawerViewController;
@property (nonatomic, strong) JVFloatingDrawerSpringAnimator *drawerAnimator;

@property (nonatomic, strong) UITableViewController *leftDrawerViewController;

@property (nonatomic, strong) UIViewController *calculateModuleViewController;
@property (nonatomic, strong) UIViewController *languageViewController;
@property (nonatomic, strong) UIViewController *currencyViewController;
@property (nonatomic, strong) UIViewController *weightViewController;
@property (nonatomic, strong) UIViewController *volumeViewController;
@property (nonatomic, strong) UIViewController *aboutUsViewController;
@property (nonatomic, strong) UIViewController *returnConnectionViewController;

@property (nonatomic,strong) MMDrawerController * drawerController;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (AppDelegate *)globalDelegate;

@end

