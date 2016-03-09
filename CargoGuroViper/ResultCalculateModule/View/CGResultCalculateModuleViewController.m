//
//  CGResultCalculateModuleViewController.m
//  CargoGuroViper
//
//  Created by Виктория on 25/02/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGResultCalculateModuleViewController.h"

#import "CGResultCalculateModuleViewOutput.h"
#import "CGFilterModuleViewController.h"
#import "CGFilterModuleViewOutput.h"
#import "ResultTableViewCell.h"
#import "AppDelegate.h"
#import "SortingView.h"

@interface CGResultCalculateModuleViewController () <UITableViewDelegate, UITableViewDataSource, SortingViewDelegate> {
    NSInteger countOffers;
    NSMutableArray *listOfResult;
    NSInteger currentSelectSorting;
    
    BOOL price, name, method, time;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@property (weak, nonatomic) IBOutlet UIView *loadScreen;

@property (weak, nonatomic) IBOutlet UIImageView *loadImage;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *informationLabel;

@end


@implementation CGResultCalculateModuleViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    [self showAutoPlayBgViewInFullScreen];
    countOffers = 0;
    currentSelectSorting = 5;
    listOfResult = @[].mutableCopy;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:255.0/256.0 green:255.0/256.0 blue:255.0/256.0 alpha:0.5];
    
    [self.loadScreen setFrame:[UIScreen mainScreen].bounds];
    
    self.backgroundView.image = [UIImage imageNamed:@"Background"];
    self.loadScreen.hidden = NO;
    self.loadImage.hidden = NO;
    self.loadImage.image = [UIImage imageNamed:@"logo"];
    [self rotateLayerInfinite:self.loadImage.layer];
    
    NSDictionary *attrs = @{
                            NSFontAttributeName:[UIFont boldSystemFontOfSize:13],
                            NSForegroundColorAttributeName:[UIColor blackColor]
                            };
    NSDictionary *subAttrs = @{
                               NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor blackColor]
                               };
    
    self.informationLabel.text = [NSString stringWithFormat:@"%@ - %@ \nобьём %@ м3; вес %@ кг; \nценность %.2f р.", self.datas[@"cargoFrom"], self.datas[@"cargoTo"], self.datas[@"cV"], self.datas[@"cW"], ([self.datas[@"cInsP"] length] > 0 ? [self.datas[@"cInsP"] floatValue] : 0.00)];
    
    NSRange range0 = [self.informationLabel.text rangeOfString: self.informationLabel.text];
    NSRange range1 = [self.informationLabel.text rangeOfString: self.datas[@"cargoFrom"]];
    NSRange range2 = [self.informationLabel.text rangeOfString: self.datas[@"cargoTo"]];
    NSRange range3 = [self.informationLabel.text rangeOfString: self.datas[@"cV"]];
    NSRange range4 = [self.informationLabel.text rangeOfString: self.datas[@"cW"]];
    NSRange range5 = [self.informationLabel.text rangeOfString: self.datas[@"cInsP"]];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.informationLabel.text];
    
    
    [attributedText setAttributes:subAttrs
                            range:range0];
    [attributedText setAttributes:attrs
                            range:range1];
    [attributedText setAttributes:attrs
                            range:range2];
    [attributedText setAttributes:attrs
                            range:range3];
    [attributedText setAttributes:attrs
                            range:range4];
    [attributedText setAttributes:attrs
                            range:range5];
    
    self.informationLabel.attributedText = attributedText;
    
    
    self.output.imageIndicator = self.loadImage;
    self.output.loadView = self.loadScreen;
	[self.output didTriggerViewReadyEvent];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self setCustomNavigationBackButton];
    
}

- (void) showAutoPlayBgViewInFullScreen
{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    
    // set frame of auto play bg view
    self.loadScreen.frame = window.frame;
    [window addSubview: self.loadScreen];
}

- (void)setCustomNavigationBackButton
{
    
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"custom_back_button"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIButton *filterButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 35.0f, 35.0f)];
    [filterButton setImage:[UIImage imageNamed:@"sorting_icon"]  forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(filterPress) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:filterButton];
    
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = @"Варианты перевозки";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor colorWithRed:77.0/255.0 green:77.0/255.0 blue:77.0/255.0 alpha:1.0];
    lblTitle.shadowColor = [UIColor whiteColor];
    lblTitle.shadowOffset = CGSizeMake(0, 1);
    lblTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
    [lblTitle sizeToFit];
    
    self.navigationItem.titleView = lblTitle;
    
}


- (void)rotateLayerInfinite:(CALayer *)layer
{
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    rotation.duration = 3.0f;
    rotation.repeatCount = HUGE_VALF;
    [layer removeAllAnimations];
    [layer addAnimation:rotation forKey:@"Spin"];
}


#pragma mark - Методы CGResultCalculateModuleViewInput

- (void)setupInitialState {
	// В этом методе происходит настройка параметров view, зависящих от ее жизненого цикла (создание элементов, анимации и пр.)
}


#pragma mark - UITableViewDataSource protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [listOfResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *resultTableIdentifier = @"ResultTableViewCell";
    
    ResultTableViewCell *cell = (ResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:resultTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:resultTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *result = listOfResult[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = [result objectForKey:@"transportName"];
    
    NSString *comma = [[result objectForKey:@"methods"][@"calcResultTime"] length] > 0 ? @"," : @"";
    
    cell.wayLabel.text = [NSString stringWithFormat:@"%@ - %@%@ %@", [result objectForKey:@"cityFrom"], [result objectForKey:@"cityTo"], comma, [result objectForKey:@"methods"][@"calcResultTime"]];
    
    float value = [[result objectForKey:@"methods"][@"calcResultPrice"] floatValue];
    NSString * newString =  [NSString stringWithFormat:@"%.2f", value];
    cell.priceLabel.text = newString;
    
    cell.transportLabel.text = [result objectForKey:@"methods"][@"name"];
    
    return cell;
}


#pragma mark - UITableViewDelegate protocol

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *result = listOfResult[indexPath.row];
    
    NSString *comma = [[result objectForKey:@"methods"][@"calcResultTime"] length] > 0 ? @"," : @"";
    NSString *descriptionResult = [NSString stringWithFormat:@"%@ - %@%@ %@", [result objectForKey:@"cityFrom"], [result objectForKey:@"cityTo"], comma, [result objectForKey:@"methods"][@"calcResultTime"]];
    
    CGFloat widthOfdescribeLabel = [[UIScreen mainScreen] bounds].size.width / 320;
    NSLog(@"widthOfdescribeLabel=================%f, width screen ======== %f" , widthOfdescribeLabel, [[UIScreen mainScreen] bounds].size.width);
    float height = [self getHeightForText:descriptionResult withFont:[UIFont systemFontOfSize:12
                                                                      ] andWidth:150 * widthOfdescribeLabel];
    
    return 33 + height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *result = listOfResult[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:result[@"transportSite"]];
    
    [[UIApplication sharedApplication]
     openURL:url];
}


#pragma mark - CGResultCalculateModuleViewInput protocol

- (void)addRowWithResult:(NSDictionary *)result {
    
    [self.tableView beginUpdates];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[listOfResult count] inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationTop];
    [listOfResult addObject:result];
    
    [self.tableView endUpdates];
}

- (void)outPutError:(NSString *)error {
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ОК" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertController *alertError = [UIAlertController alertControllerWithTitle:nil message:error preferredStyle:UIAlertControllerStyleAlert];
    [alertError addAction:alertAction];
    [self presentViewController:alertError animated:YES completion:nil];
}


- (float) getHeightForText:(NSString*) text withFont:(UIFont*) font andWidth:(float) width {
    CGSize constraint = CGSizeMake(width , 20000.0f);
    CGSize title_size;
    float totalHeight;
    
    SEL selector = @selector(boundingRectWithSize:options:attributes:context:);
    if ([text respondsToSelector:selector]) {
        title_size = [text boundingRectWithSize:constraint
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{ NSFontAttributeName : font }
                                        context:nil].size;
        
        totalHeight = ceil(title_size.height);
    } else {
        title_size = [text sizeWithFont:font
                      constrainedToSize:constraint
                          lineBreakMode:NSLineBreakByWordWrapping];
        totalHeight = title_size.height ;
    }
    
    CGFloat height = MAX(totalHeight, 50.0f);
    return height;
}


#pragma mark - Action Tab Bar

-(void) popBack {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void) filterPress {
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"SortingView" owner:self options:nil];
    SortingView *mainView = [subviewArray objectAtIndex:0];
    //mainView.frame = self.view.bounds;
    mainView.currentSelectSorting = currentSelectSorting;
    mainView.delegate = self;
    
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    
    // set frame of auto play bg view
    mainView.frame = window.frame;
    [window addSubview: mainView];
    
    //[self.view addSubview:mainView];
    //[self.output didSelectFilter];
    
}

- (IBAction)unwindToResultCalculate:(UIStoryboardSegue *)unwindSegue
{
    UIViewController* sourceViewController = unwindSegue.sourceViewController;
    
    if ([sourceViewController isKindOfClass:[CGFilterModuleViewController class]])
    {
        CGFilterModuleViewController *filterModule = (CGFilterModuleViewController *)sourceViewController;
        
        NSSortDescriptor *sortDescriptor;
        
        if (filterModule.currentFilter == Cost) {
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"methods.calcResultPrice"
                                                         ascending:YES];
            
        } else if  (filterModule.currentFilter == Transfer) {
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"transportName"
                                                         ascending:YES];
            
        } else if (filterModule.currentFilter == Process) {
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"methods.name"
                                                         ascending:YES];
            
        } else if (filterModule.currentFilter == Time) {
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"methods.calcResultTime"
                                                         ascending:YES];
            
        }
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray = [listOfResult sortedArrayUsingDescriptors:sortDescriptors];
        listOfResult = sortedArray.copy;
        [self.tableView reloadData];
    }
}


#pragma mark - SortingViewDelegate

- (void)sortingResultsBy:(Filter)filter withFlag:(BOOL)flag {
    if (!flag) {
        currentSelectSorting = 5;
    } else {
        
        currentSelectSorting = filter;
    }
    NSSortDescriptor *sortDescriptor;
    
    if (filter == Cost) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"methods.calcResultPrice"
                                                     ascending:flag ? price : !price];
        
    } else if  (filter == Transfer) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"transportName"
                                                     ascending:flag ? name : !name];
        
    } else if (filter == Process) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"methods.name"
                                                     ascending:flag ? method : !method];
        
    } else if (filter == Time) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"methods.calcResultTime"
                                                     ascending:flag ? time : !time];
        
    }
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [listOfResult sortedArrayUsingDescriptors:sortDescriptors];
    listOfResult = sortedArray.copy;
    [self.tableView reloadData];
}

-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        /* Reorganize views, or move child view controllers */
        UIWindow* window = [[UIApplication sharedApplication] keyWindow];
        
        // set frame of auto play bg view
        self.loadScreen.frame = window.frame;
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        /* Do any cleanup, if necessary */
        UIWindow* window = [[UIApplication sharedApplication] keyWindow];
        
        // set frame of auto play bg view
        self.loadScreen.frame = window.frame;
    }];
}

@end
