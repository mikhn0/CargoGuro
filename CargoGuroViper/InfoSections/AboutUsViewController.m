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
@property (nonatomic) UIButton *backButton;

@end

@implementation AboutUsViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.backButton removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setCustomNavigationBackButton];
    self.aboutLabel.text = LocalizedString(@"TITLE_ABOUT");
    self.aboutUsText.text = LocalizedString(@"DESCRIPTION_ABOUT");
}

- (void)setCustomNavigationBackButton
{
    self.backButton = [[UIButton alloc] initWithFrame: CGRectMake(15.0f, 25.0f, 80.0f, 30.0f)];
    [self.backButton setImage:[UIImage imageNamed:@"icon_back"]  forState:UIControlStateNormal];
    [self.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.backButton setTitle:LocalizedString(@"BACK") forState:UIControlStateNormal];
    [self.backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 0)];
    [self.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.customTopBar addSubview:self.backButton];
}

- (void) popBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
