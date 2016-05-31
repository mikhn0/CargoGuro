//
//  DMSideMenuController.h
//  CargoGuruViper
//
//  Created by a1 on 30.05.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMSideMenuController : UIViewController

// These values can't be changed after the view is loaded
@property (nonatomic) CGFloat menuWidth;  // default is 320
@property (nonatomic) CGFloat overlapWidth;  // default is 50

@property (nonatomic, getter = isMenuOpen) BOOL menuOpen;  // default is NO
- (void)setMenuOpen:(BOOL)menuOpen animated:(BOOL)animated;

@property (strong, nonatomic) UIViewController *mainViewController;  // default is nil
@property (strong, nonatomic) UIViewController *menuViewController;  // default is nil

@property (nonatomic) BOOL gesturesEnabled;                  // default is YES
@property (nonatomic) BOOL useScreenEdgeInsteadOfNormalPan;  // default is NO

@end
