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
#import "VolumeCalculateView.h"

#import "CGCalculateModulePresenter.h"

@interface CGCalculateModuleViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate,  VolumeCalculateViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *searchTransite;
@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *from;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *to;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *value;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *weight;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *cost;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *inputView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aligment_from_to;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aligment_to_volume;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aligment_volume_weight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aligment_weight_cost;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aligment_cost_button;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aligment_from_right;

@property (nonatomic) JVFloatLabeledTextField *activeField;


@end


@implementation CGCalculateModuleViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.logoLabel.adjustsFontSizeToFitWidth = YES;
    
    self.from.delegate = self;
    UIColor *color = [UIColor whiteColor];
    self.from.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Откуда" attributes:@{NSForegroundColorAttributeName: color}];
    self.from.layer.borderWidth = 1.0;
    self.from.layer.borderColor = [UIColor whiteColor].CGColor;
    self.from.layer.cornerRadius = 3.0;
    
    self.to.delegate = self;
    self.to.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Куда" attributes:@{NSForegroundColorAttributeName: color}];
    self.to.layer.borderWidth = 1.0;
    self.to.layer.borderColor = [UIColor whiteColor].CGColor;
    self.to.layer.cornerRadius = 3.0;
    
    self.value.delegate = self;
    self.value.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Объем (%@)", [NSString printCubeOfValue:@"м"]] attributes:@{NSForegroundColorAttributeName: color}];
    self.value.layer.borderWidth = 1.0;
    self.value.layer.borderColor = [UIColor whiteColor].CGColor;
    self.value.layer.cornerRadius = 3.0;
    
    self.weight.delegate = self;
    self.weight.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Вес (кг)" attributes:@{NSForegroundColorAttributeName: color}];
    self.weight.layer.borderWidth = 1.0;
    self.weight.layer.borderColor = [UIColor whiteColor].CGColor;
    self.weight.layer.cornerRadius = 3.0;
    
    self.cost.delegate = self;
    self.cost.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Объявленная ценность (руб)" attributes:@{NSForegroundColorAttributeName: color}];
    self.cost.layer.borderWidth = 1.0;
    self.cost.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cost.layer.cornerRadius = 3.0;
    
    [self.from setText:@"Уфа"];
    [self.to setText:@"Киев"];
    [self.value setText:@"123"];
    [self.weight setText:@"123"];
    [self.cost setText:@"123"];
    
    self.searchTransite.layer.cornerRadius = 5.0;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.scrollView addGestureRecognizer:tapGesture];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
    [self registerForKeyboardNotifications];
    
    self.aligment_from_to.constant = (14 * self.view.frame.size.width) / 305.0;
    self.aligment_to_volume.constant = (14 * self.view.frame.size.width) / 305.0;
    self.aligment_volume_weight.constant = (14 * self.view.frame.size.width) / 305.0;
    self.aligment_weight_cost.constant = (14 * self.view.frame.size.width) / 305.0;
    self.aligment_cost_button.constant = (14 * self.view.frame.size.width) / 305.0;
    self.aligment_from_right.constant = (20 * self.view.frame.size.width) / 305.0;

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
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - Helpers

- (JVFloatingDrawerSpringAnimator *)drawerAnimator {
    return [[AppDelegate globalDelegate] drawerAnimator];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        if (textField == self.value || textField == self.weight || textField == self.cost) {
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
    NSLog(@"Main view frame ==== %@", NSStringFromCGRect(self.view.frame));
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    CGRect tfRect = self.activeField.frame;
    tfRect.origin.y += self.inputView.frame.origin.y + self.scrollView.frame.origin.y + 64 + self.activeField.frame.size.height;
    NSLog(@"self.activeField.frame.origin ==== %@", NSStringFromCGPoint(tfRect.origin));
    if (!CGRectContainsPoint(aRect, tfRect.origin) ) {
        tfRect.origin.y -= self.inputView.frame.origin.y + 64 + self.activeField.frame.size.height;
        [self.scrollView scrollRectToVisible:tfRect animated:YES];
    }
}

- (void)hideKeyboard {
    [self.from resignFirstResponder];
    [self.to resignFirstResponder];
    [self.value resignFirstResponder];
    [self.weight resignFirstResponder];
    [self.cost resignFirstResponder];
}

- (IBAction)changeCityPlaces:(id)sender {
    NSString *fromString = self.from.text;
    self.from.text = self.to.text;
    self.to.text = fromString;
}

- (IBAction)volumeCalculation:(id)sender {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VolumeCalculateView" owner:self options:nil];
    VolumeCalculateView *mainView = [subviewArray objectAtIndex:0];
    //mainView.frame = self.view.bounds;
    //mainView.currentSelectSorting = currentSelectSorting;
    //mainView.arrowCurrentSorting = arrowCurrentSorting;
    mainView.delegate = self;
    
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    
    // set frame of auto play bg view
    mainView.frame = window.frame;
    [window addSubview: mainView];
    
    //[self.view addSubview:mainView];
    //[self.output didSelectFilter];
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
        NSDictionary *datas = @{@"tNum":@(tNum), @"cargoFrom": cargoFrom, @"cargoTo": cargoTo, @"cW": cW, @"cV": cV, @"cInsP": cInsP, @"lang":@"ru", @"currency": [CURRENCY_NAME objectAtIndex:INDEX_COUNTRY], @"cFC": @"RU", @"cTC":@"UA"};
        [self.output searchTransition:datas];
        
    }
    
}


#pragma mark - VolumeCalculateViewDelegate 

- (void)resultCalculateVolume:(NSString *)resultString {
    self.value.text = resultString;
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
