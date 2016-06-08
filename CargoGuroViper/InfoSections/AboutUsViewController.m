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

- (void)viewDidLoad {
    [super viewDidLoad];}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.aboutLabel.text = LocalizedString(@"TITLE_ABOUT");
    self.aboutUsText.text = LocalizedString(@"DESCRIPTION_ABOUT");
}

- (IBAction)actionToggleLeftDrawer:(id)sender {
    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
}

@end
