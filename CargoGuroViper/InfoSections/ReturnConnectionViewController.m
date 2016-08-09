//
//  ReturnConnectionViewController.m
//  CargoGuruViper
//
//  Created by Виктория on 06.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "ReturnConnectionViewController.h"
#import <MessageUI/MessageUI.h>

@interface ReturnConnectionViewController () <MFMailComposeViewControllerDelegate>

@property (nonatomic) UIButton *backButton;
@end

@implementation ReturnConnectionViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.backButton removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setCustomNavigationBackButton];
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

- (IBAction)callPhone:(UIButton *)sender {
    NSString *phoneNumber = @"telprompt://+79191233398";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phoneNumber]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
    
}

- (IBAction)sendEmail:(id)sender {
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"info@cargo.guru"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) popBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
