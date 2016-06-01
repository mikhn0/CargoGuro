//
//  AppDelegate.m
//  CargoGuroViper
//
//  Created by Виктория on 24.02.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "JVFloatingDrawerViewController.h"
#import "JVFloatingDrawerSpringAnimator.h"

static NSString * const kMainStoryboardName = @"Main";
static NSString * const kConfigurationStoryboardName = @"Configuration";
static NSString * const kInfoStoryboardName = @"Info";

static NSString * const kLeftDrawerStoryboardID = @"LeftDrawerVCStoryboardID";

static NSString * const kLanguageVCStoryboardID = @"LanguageVCStoryboardID";
static NSString * const kCurrencyVCStoryboardID = @"CurrencyVCStoryboardID";
static NSString * const kWeightVCStoryboardID = @"WeightVCStoryboardID";
static NSString * const kVolumeVCStoryboardID = @"VolumeVCStoryboardID";
static NSString * const kCalculateModuleVCStoryboardID = @"CalculateModuleVCStoryboardID";

@interface AppDelegate ()

@property (nonatomic, strong, readonly) UIStoryboard *drawersStoryboard;
@property (nonatomic, strong, readonly) UIStoryboard *configurationStoryboard;
@property (nonatomic, strong, readonly) UIStoryboard *infoStoryboard;

@end

@implementation AppDelegate

@synthesize drawersStoryboard = _drawersStoryboard;
@synthesize configurationStoryboard = _configurationStoryboard;
@synthesize infoStoryboard = _infoStoryboard;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.drawerViewController;
    [self configureDrawerViewController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

#pragma mark - Drawer View Controllers

- (JVFloatingDrawerViewController *)drawerViewController {
    if (!_drawerViewController) {
        _drawerViewController = [[JVFloatingDrawerViewController alloc] init];
    }
    
    return _drawerViewController;
}

#pragma mark Sides

- (UITableViewController *)leftDrawerViewController {
    if (!_leftDrawerViewController) {
        _leftDrawerViewController = [self.drawersStoryboard instantiateViewControllerWithIdentifier:kLeftDrawerStoryboardID];
    }
    
    return _leftDrawerViewController;
}

#pragma mark Center

- (UIViewController *)languageViewController {
    if (!_languageViewController) {
        _languageViewController = [self.configurationStoryboard instantiateViewControllerWithIdentifier:kLanguageVCStoryboardID];
    }
    
    return _languageViewController;
}

- (UIViewController *)currencyViewController {
    if (!_currencyViewController) {
        _currencyViewController = [self.configurationStoryboard instantiateViewControllerWithIdentifier:kCurrencyVCStoryboardID];
    }
    
    return _currencyViewController;
}

- (UIViewController *)weightViewController {
    if (!_weightViewController) {
        _weightViewController = [self.configurationStoryboard instantiateViewControllerWithIdentifier:kWeightVCStoryboardID];
    }
    return _weightViewController;
}

- (UIViewController *)volumeViewController {
    if (!_volumeViewController) {
        _volumeViewController = [self.configurationStoryboard instantiateViewControllerWithIdentifier:kVolumeVCStoryboardID];
    }
    return _volumeViewController;
}

- (UIViewController *)calculateModuleViewController {
    if (!_calculateModuleViewController) {
        _calculateModuleViewController = [self.drawersStoryboard instantiateViewControllerWithIdentifier:kCalculateModuleVCStoryboardID];
    }
    return _calculateModuleViewController;
}

- (JVFloatingDrawerSpringAnimator *)drawerAnimator {
    if (!_drawerAnimator) {
        _drawerAnimator = [[JVFloatingDrawerSpringAnimator alloc] init];
    }
    return _drawerAnimator;
}

- (UIStoryboard *)drawersStoryboard {
    if(!_drawersStoryboard) {
        _drawersStoryboard = [UIStoryboard storyboardWithName:kMainStoryboardName bundle:nil];
    }
    return _drawersStoryboard;
}

- (UIStoryboard *)configurationStoryboard {
    if(!_configurationStoryboard) {
        _configurationStoryboard = [UIStoryboard storyboardWithName:kConfigurationStoryboardName bundle:nil];
    }
    return _configurationStoryboard;
}

- (UIStoryboard *)infoStoryboard {
    if(!_infoStoryboard) {
        _infoStoryboard = [UIStoryboard storyboardWithName:kInfoStoryboardName bundle:nil];
    }
    return _infoStoryboard;
}

- (void)configureDrawerViewController {
    self.drawerViewController.leftViewController = self.leftDrawerViewController;
    self.drawerViewController.centerViewController = self.calculateModuleViewController;
    
    self.drawerViewController.animator = self.drawerAnimator;
    
    
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    layer.colors = @[ (__bridge id)[UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:47.0/255.0 alpha:1.0].CGColor ,   // start color
                      (__bridge id)[UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:1.0].CGColor]; // end color
    
    UIGraphicsBeginImageContext(size);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.drawerViewController.backgroundImage = image;//[UIImage imageNamed:@"background_transport"];

}

#pragma mark - Global Access Helper

+ (AppDelegate *)globalDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)toggleLeftDrawer:(id)sender animated:(BOOL)animated {
    [self.drawerViewController toggleDrawerWithSide:JVFloatingDrawerSideLeft animated:animated completion:nil];
}

- (void)toggleRightDrawer:(id)sender animated:(BOOL)animated {
    [self.drawerViewController toggleDrawerWithSide:JVFloatingDrawerSideRight animated:animated completion:nil];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "fruktorum.CargoGuroViper" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CargoGuroViper" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CargoGuroViper.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
