//
//  VolumeCalculateView.m
//  CargoGuruViper
//
//  Created by a1 on 14.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "VolumeCalculateView.h"
#import "JVFloatLabeledTextField.h"

@interface VolumeCalculateView () <UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *width;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *height;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *length;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic) JVFloatLabeledTextField *activeField;

@end

@implementation VolumeCalculateView

- (id)init {
    if ((self = [super init])) {
        [self registerForKeyboardNotifications];
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    return !(touch.view != self);
}

- (void)drawRect:(CGRect)rect {
    UIColor *color = [UIColor whiteColor];
    UIColor *colorBorder = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    self.width.delegate = self;
    self.width.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@)", LocalizedString(@"WIGTH"), LocalizedString(@"M")] attributes:@{NSForegroundColorAttributeName: color}];
    self.width.layer.borderWidth = 1.0;
    self.width.layer.borderColor = colorBorder.CGColor;
    self.width.layer.cornerRadius = 3.0;
    
    self.height.delegate = self;
    self.height.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@)", LocalizedString(@"HEIGHT"), LocalizedString(@"M")] attributes:@{NSForegroundColorAttributeName: color}];
    self.height.layer.borderWidth = 1.0;
    self.height.layer.borderColor = colorBorder.CGColor;
    self.height.layer.cornerRadius = 3.0;
    
    self.length.delegate = self;
    self.length.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@)", LocalizedString(@"LENGTH"), LocalizedString(@"M")] attributes:@{NSForegroundColorAttributeName: color}];
    self.length.layer.borderWidth = 1.0;
    self.length.layer.borderColor = colorBorder.CGColor;
    self.length.layer.cornerRadius = 3.0;
    
    [self.calculateButton setTitle:LocalizedString(@"ENTER_CALCULATE") forState:UIControlStateNormal];
    self.calculateButton.layer.cornerRadius = 5.0;
    self.calculateButton.enabled = NO;
    self.calculateButton.alpha = 0.5;
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeScreen:)];
    tapGest.delegate = self;
    [tapGest setCancelsTouchesInView:NO];
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:tapGest];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.scrollView addGestureRecognizer:tapGesture];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        if (textField == self.length || textField == self.width || textField == self.height) {
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
    self.activeField.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.activeField isEqual:self.length] || [self.activeField isEqual:self.width] || [self.activeField isEqual:self.height]) {
        if (self.length.text.length > 0 && self.width.text.length > 0 && self.height.text.length>0) {
            self.calculateButton.enabled = YES;
            self.calculateButton.alpha = 1.0;
        } else {
            self.calculateButton.enabled = NO;
            self.calculateButton.alpha = 0.5;
        }
    }
    self.activeField.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
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
  //  NSLog(@"Main view frame ==== %@", NSStringFromCGRect(self.view.frame));
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.frame;
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
    [self.length resignFirstResponder];
    [self.width resignFirstResponder];
    [self.height resignFirstResponder];
}

- (IBAction)pressOnCulculateButton:(id)sender {
    NSString *resultValue;
    if (self.length.text.length > 0 && self.width.text.length > 0 && self.height.text.length>0) {

        NSNumber *number = [[NSNumberFormatter new] numberFromString: self.length.text];
        float lengthValue = number.floatValue;

        number = [[NSNumberFormatter new] numberFromString: self.width.text];
        float widthValue = number.floatValue;

        number = [[NSNumberFormatter new] numberFromString: self.height.text];
        float heightValue = number.floatValue;

        resultValue = [NSString stringWithFormat:@"%.2f", lengthValue * widthValue * heightValue];
        [self.delegate resultCalculateVolume:resultValue];
        [self removeFromSuperview];
        
    }
}

#pragma mark - UITableViewDataSource

- (void)closeScreen:(UITapGestureRecognizer *)sender {
    [self removeFromSuperview];
}

@end
