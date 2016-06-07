//
//  CGCalculateModuleViewController.m
//  CargoGuro
//
//  Created by Viktoria on 24/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGCalculateModuleViewController.h"

#import "CGCalculateModuleViewOutput.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "AppDelegate.h"

#import "CGCalculateModulePresenter.h"

@interface CGCalculateModuleViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIButton *searchTransite;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *from;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *to;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *value;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *length;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *width;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *height;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *weight;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *cost;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *widthLabel;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;

@property (nonatomic) JVFloatLabeledTextField *activeField;

@end


@implementation CGCalculateModuleViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.from.delegate = self;
    self.to.delegate = self;
    self.value.delegate = self;
    self.length.delegate = self;
    self.width.delegate = self;
    self.height.delegate = self;
    self.weight.delegate = self;
    self.cost.delegate = self;
    self.cost.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //self.background.image = [UIImage imageNamed:@"Background"];
    self.searchTransite.layer.cornerRadius = 5.0;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.scrollView addGestureRecognizer:tapGesture];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
    [self registerForKeyboardNotifications];
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.widthLabel
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.lengthLabel
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0 
                                                      constant:0]];
    [self.scrollView updateConstraints];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    [UIView setAnimationsEnabled:YES];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Actions

- (IBAction)actionToggleLeftDrawer:(id)sender {
    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
}

#pragma mark - Helpers

- (JVFloatingDrawerSpringAnimator *)drawerAnimator {
    return [[AppDelegate globalDelegate] drawerAnimator];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        if (textField == self.value || textField == self.length || textField == self.width || textField == self.height || textField == self.weight || textField == self.cost) {
            NSString *candidate = [[textField text] stringByReplacingCharactersInRange:range withString:string];
            if (!candidate || [candidate length] < 1 || [candidate isEqualToString:@""])
            {
                return YES;
            }
            if (candidate && [candidate length] > 1 && [[candidate substringFromIndex:[candidate length] - 1] isEqualToString:@","] && [[textField text] rangeOfString:@","].location == NSNotFound)
            {
                return YES;
            }
            NSScanner *scanner = [NSScanner scannerWithString:string];
            BOOL isNumeric = [scanner scanInteger:NULL] && [scanner isAtEnd];
            if (isNumeric) {
                return YES;
            } else {
                return NO;
            }
        }
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(JVFloatLabeledTextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.activeField isEqual:self.length] || [self.activeField isEqual:self.width] || [self.activeField isEqual:self.height]) {
        if (self.length.text.length > 0 && self.width.text.length > 0 && self.height.text.length>0) {
            
            NSNumber *number = [[NSNumberFormatter new] numberFromString: self.length.text];
            float lengthValue = number.floatValue;
            
            number = [[NSNumberFormatter new] numberFromString: self.width.text];
            float widthValue = number.floatValue;

            number = [[NSNumberFormatter new] numberFromString: self.height.text];
            float heightValue = number.floatValue;
            
            self.value.text = [NSString stringWithFormat:@"%.2f", lengthValue * widthValue * heightValue];
        }
    }
    self.activeField = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
    
    return YES;
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void)hideKeyboard {
    [self.from resignFirstResponder];
    [self.to resignFirstResponder];
    [self.value resignFirstResponder];
    [self.length resignFirstResponder];
    [self.width resignFirstResponder];
    [self.height resignFirstResponder];
    [self.weight resignFirstResponder];
    [self.cost resignFirstResponder];
}

- (IBAction)searchTransiteAction:(id)sender {
    NSInteger tNum = 1;
    NSString *cargoFrom = self.from.text;
    NSString *cargoTo = self.to.text;
    NSString *cW = self.weight.text;
    NSString *cV = self.value.text;
    NSString *cInsP = self.cost.text;
    
    if (cargoFrom.length < 1) {
        
        [self outPutError:NSLocalizedString(@"ENTER_FROM", nil)];
        
    } else if (cargoTo.length < 1) {
        
        [self outPutError:NSLocalizedString(@"ENTER_TO", nil)];
        
    } else if (self.value.text.length < 1) {
        
        [self outPutError:NSLocalizedString(@"ENTER_VALUE", nil)];
        
    } else if (self.weight.text.length < 1) {
        
        [self outPutError:NSLocalizedString(@"ENTER_WAIST", nil)];
       
    } else {
        NSDictionary *datas = @{@"tNum":@(tNum), @"cargoFrom": cargoFrom, @"cargoTo": cargoTo, @"cW": cW, @"cV": cV, @"cInsP": cInsP, @"lang":@"ru", @"currency": [CURRENCY_NAME objectAtIndex:[[[NSUserDefaults standardUserDefaults] objectForKey:@"currentIndexCountry"] integerValue]], @"cFC": @"RU", @"cTC":@"UA"};
        [self.output searchTransition:datas];
        
    }
    
}

- (void)outPutError:(NSString *)error {
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ОК" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertController *alertError = [UIAlertController alertControllerWithTitle:nil message:error preferredStyle:UIAlertControllerStyleAlert];
    [alertError addAction:alertAction];
    [self presentViewController:alertError animated:YES completion:nil];
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
