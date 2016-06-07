//
//  ReturnConnectionViewController.m
//  CargoGuruViper
//
//  Created by Виктория on 06.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "ReturnConnectionViewController.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>

@interface ReturnConnectionViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation ReturnConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionToggleLeftDrawer:(id)sender {
    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
}

@end
