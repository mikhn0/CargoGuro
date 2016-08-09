//
//  BaseConfigurationViewController.h
//  CargoGuruViper
//
//  Created by a1 on 01.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//


@protocol BaseConfigurationViewControllerDelegate

- (void)openRevealMenuWithCompletion:(void (^__strong)(BOOL))completion;

@end

@interface BaseConfigurationViewController : UITableViewController

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, weak) IBOutlet UIView *customTopBar;

@property (nonatomic) id <BaseConfigurationViewControllerDelegate> baseDelegate;

- (void)setCustomNavigationBackButton;

@end
