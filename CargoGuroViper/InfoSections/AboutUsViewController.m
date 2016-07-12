//
//  AboutUsViewController.m
//  CargoGuruViper
//
//  Created by Виктория on 06.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *aboutUsText;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;

@end

@implementation AboutUsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setCustomNavigationBackButton];
}

- (void)setCustomNavigationBackButton
{
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(15.0f, 25.0f, 80.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"icon_back"]  forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [backButton setTitle:LocalizedString(@"BACK") forState:UIControlStateNormal];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 0)];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.customTopBar addSubview:backButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.aboutLabel.text = LocalizedString(@"TITLE_ABOUT");
    self.aboutUsText.text = LocalizedString(@"DESCRIPTION_ABOUT");
}

- (void) popBack {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateUI" object:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
