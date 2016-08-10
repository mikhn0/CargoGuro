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

#import "DimensionalTranslation+NSString.h"

@interface CGResultCalculateModuleViewController () <UITableViewDelegate, UITableViewDataSource, SortingViewDelegate> {
    NSInteger countOffers, currentSelectSorting;
    NSMutableArray *listOfResult;
    Arrow arrowCurrentSorting;
    NSString *startVolumeValue;
    NSString *startWeightValue;
    
    BOOL price, name, method, time;
}

@property (weak, nonatomic) IBOutlet UIImageView    *backgroundView;
@property (weak, nonatomic) IBOutlet UIView         *loadScreen;
@property (weak, nonatomic) IBOutlet UILabel        *sendRequestLabel;
@property (weak, nonatomic) IBOutlet UILabel        *ADLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *loadImage;
@property (weak, nonatomic) IBOutlet UITableView    *tableView;
@property (weak, nonatomic) IBOutlet UILabel        *routeLabel;
@property (weak, nonatomic) IBOutlet UILabel        *informationLabel;

@property (nonatomic) NSDictionary *derival;
@property (nonatomic) NSDictionary *arrival;
@property (nonatomic) NSInteger startWeightIndex;
@property (nonatomic) NSInteger startVolumeIndex;
@property (nonatomic) NSInteger startCurrency;

@property (nonatomic) NSDictionary *currencyPrices;

@end


@implementation CGResultCalculateModuleViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    [self showAutoPlayBgViewInFullScreen];
    
    //For transfer demension of valume and weight on this screen
    self.startVolumeIndex = INDEX_VOLUME;//1 cm^3 = 0.000001 м^3 ; 1 cm^3 = ; 1m^3 = 1000l
    self.startWeightIndex = INDEX_WEIGHT;
    startVolumeValue = self.datas[@"cV"];//[NSString transferVolume:self.datas[@"cV"] From:0 to:INDEX_VOLUME];
    startWeightValue = self.datas[@"cW"];//[NSString transferWeight:self.datas[@"cW"] From:0 to:INDEX_WEIGHT];
    
    self.startCurrency = INDEX_CURRENCY;
    
    NSString *priceValue = ([self.datas[@"cInsP"] length] > 0 ? self.datas[@"cInsP"] : @"0.00");
    [self.output reloadPrice:priceValue withCurrency:CURRENCY_NAME[self.startCurrency]];
    
    countOffers = 0;
    currentSelectSorting = 5;
    arrowCurrentSorting = None;
    listOfResult = @[].mutableCopy;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:255.0/256.0 green:255.0/256.0 blue:255.0/256.0 alpha:0.5];
    
    [self.loadScreen setFrame:[UIScreen mainScreen].bounds];
    self.loadScreen.hidden = NO;
    self.loadImage.hidden = NO;
    self.loadImage.image = [UIImage imageNamed:@"logo"];
    self.sendRequestLabel.text = LocalizedString(@"SEND_REQ_CARRIERS");
    self.ADLabel.text = LocalizedString(@"PLACE_ADS");
    [self rotateLayerInfinite:self.loadImage.layer];
    
    self.output.imageIndicator = self.loadImage;
    self.output.loadView = self.loadScreen;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self setCustomNavigationBackButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateUI:) name:@"UpdateUI" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Label on top view FROM - TO
    if (listOfResult.count > 0 && self.derival == nil && self.arrival == nil) {
        self.derival = [listOfResult[0] objectForKey:kCITIES][kDERIVAL];
        self.arrival = [listOfResult[0] objectForKey:kCITIES][kARRIVAL];
    }
    
    if (self.derival != nil && self.arrival != nil) {
        self.routeLabel.text = [NSString stringWithFormat:@"%@ - %@", self.derival[LANGUAGE[INDEX_COUNTRY]], self.arrival[LANGUAGE[INDEX_COUNTRY]]];

    } else {
        self.routeLabel.text = [NSString stringWithFormat:@"%@ - %@", self.datas[@"cargoFrom"], self.datas[@"cargoTo"]];
    }
    
    //Set information about detail cargo
    
    [self setInfoLabel];
    [self.tableView reloadData];
}

- (void)setInfoLabel {
    if (self.currencyPrices != nil) {
        NSString *volumeValue = [NSString transferVolume:startVolumeValue From:self.startVolumeIndex to:INDEX_VOLUME];
        NSString *weightValue = [NSString transferWeight:startWeightValue From:self.startWeightIndex to:INDEX_WEIGHT];
        
        NSString *priceValue = [self.currencyPrices[CURRENCY_NAME[INDEX_CURRENCY]] stringValue];
        
        NSMutableAttributedString *commonInfo = [[NSMutableAttributedString alloc] initWithString:LocalizedString(@"VALUE")];
        [commonInfo appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setGroupingSeparator:@" "];
        [formatter setDecimalSeparator:@","];
        formatter.usesGroupingSeparator = YES;
        [formatter setMaximumFractionDigits:6];
        [formatter setMinimumFractionDigits:0];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        [numberFormatter setDecimalSeparator:@","];
        [numberFormatter setMaximumFractionDigits:6];
        [numberFormatter setMinimumFractionDigits:0];
        volumeValue = [volumeValue stringByReplacingOccurrencesOfString:@"." withString:@","];
        float valueFloat = [numberFormatter numberFromString:volumeValue].floatValue;
        NSString *volumeString =  [formatter stringFromNumber:[NSNumber numberWithFloat:valueFloat]];
        
        [commonInfo appendAttributedString:[NSString setFontForDecimalVWInTopView:volumeString demention:VOLUME_NAME[INDEX_VOLUME] isCurrency:NO]];
        [commonInfo appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        [commonInfo appendAttributedString:[[NSAttributedString alloc] initWithString:LocalizedString(@"WEIGHT")]];
        [commonInfo appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        
        weightValue = [weightValue stringByReplacingOccurrencesOfString:@"." withString:@","];
        float weightFloat = [numberFormatter numberFromString:weightValue].floatValue;
        NSString *weightString =  [formatter stringFromNumber:[NSNumber numberWithFloat:weightFloat]];
        
        [commonInfo appendAttributedString:[NSString setFontForDecimalVWInTopView:weightString demention:WEIGHT_NAME[INDEX_WEIGHT] isCurrency:NO]];
        [commonInfo appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        [commonInfo appendAttributedString:[[NSAttributedString alloc] initWithString:LocalizedString(@"PRICE")]];
        [commonInfo appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        
        float value = [priceValue floatValue];
        [formatter setMaximumFractionDigits:2];
        [formatter setMinimumFractionDigits:2];
        NSString *newString = [formatter stringFromNumber:[NSNumber numberWithFloat:value]];
        [commonInfo appendAttributedString:[NSString setFontForDecimalPartInTopView:newString demention:CURRENCY_NAME[INDEX_CURRENCY] isCurrency:YES]];
        [commonInfo appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        self.informationLabel.attributedText = commonInfo;
    } else {
        self.informationLabel.text = @"";
    }

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
    
    UIButton *filterButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 35.0f, 35.0f)];
    [filterButton setImage:[UIImage imageNamed:@"icon_filter"]  forState:UIControlStateNormal];
    [filterButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -2)];
    [filterButton addTarget:self action:@selector(filterPress) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:filterButton];

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
    cell.titleLabel.text = [[result objectForKey:kTRANSPORT_NAMES] objectForKey:LANGUAGE[INDEX_COUNTRY]];
    
    NSString *timeText = @"";
    if ([result objectForKey:kMETHODS]) {
        if ([[result objectForKey:kMETHODS] objectForKey:kTRANSPORT_TIMES] != nil && [[[result objectForKey:kMETHODS] objectForKey:kTRANSPORT_TIMES] isKindOfClass:[NSDictionary class]]) {
            if ([[[result objectForKey:kMETHODS] objectForKey:kTRANSPORT_TIMES] objectForKey:LANGUAGE[INDEX_COUNTRY]]) {
                timeText = [NSString stringWithFormat:@"%@", [[[result objectForKey:kMETHODS] objectForKey:kTRANSPORT_TIMES] objectForKey:LANGUAGE[INDEX_COUNTRY]]];
            }
        }
    }
    cell.wayLabel.text = timeText;
    
    float value = [[[result objectForKey:kMETHODS][kTRANSPORT_PRICES] objectForKey:CURRENCY_NAME[INDEX_CURRENCY]] floatValue];
    NSNumberFormatter * formatter = [NSNumberFormatter new];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@" "];
    [formatter setDecimalSeparator:@","];
    formatter.usesGroupingSeparator = YES;
    [formatter setMaximumFractionDigits:2];
    [formatter setMinimumFractionDigits:2];
    NSString *newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:value]];
    cell.priceLabel.attributedText = [NSString setFontForDecimalPart:newString];
    cell.transportLabel.text = [[result objectForKey:kMETHODS][@"names"] objectForKey:LANGUAGE[INDEX_COUNTRY]];
    cell.siteLabel.text = listOfResult[indexPath.row][kTRANSPORT_SITE];
    
    return cell;
}


#pragma mark - UITableViewDelegate protocol

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *result = listOfResult[indexPath.row];
    
    //NSString *comma = [[result objectForKey:kMETHODS][kTRANSPORT_TIME] length] > 0 ? @"," : @"";
    NSString *descriptionResult = [NSString stringWithFormat:@"%@", [result objectForKey:kMETHODS][kTRANSPORT_TIME]];
    
    CGFloat widthOfdescribeLabel = [[UIScreen mainScreen] bounds].size.width / 320;
    float heightDescription = [self getHeightForText:descriptionResult withFont:[UIFont systemFontOfSize:12
                                                                      ] andWidth:192 * widthOfdescribeLabel];
    
    
    
    NSString *titleResult = [NSString stringWithFormat:@"%@", [[result objectForKey:kTRANSPORT_NAMES] objectForKey:LANGUAGE[INDEX_COUNTRY]]];
    
    float heightTitle = [self getHeightForText:titleResult withFont:[UIFont systemFontOfSize:16] andWidth:210 * widthOfdescribeLabel];
    
    return heightTitle + heightDescription + 30;//38;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *result = listOfResult[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:result[kTRANSPORT_SITE]];
    
    [[UIApplication sharedApplication] openURL:url];
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
    if ([error isKindOfClass:[NSDictionary class]]) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ОК" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alertError = [UIAlertController alertControllerWithTitle:nil message:[error valueForKey:@"failReason"] preferredStyle:UIAlertControllerStyleAlert];
        [alertError addAction:alertAction];
        [self presentViewController:alertError animated:YES completion:nil];
    } else if ([error isKindOfClass:[NSString class]]) {
        if ([error length] > 0) {
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"ОК" style:UIAlertActionStyleCancel handler:nil];
            UIAlertController *alertError = [UIAlertController alertControllerWithTitle:nil message:error preferredStyle:UIAlertControllerStyleAlert];
            [alertError addAction:alertAction];
            [self presentViewController:alertError animated:YES completion:nil];
        }
    }
}

- (void)reloadCurrencyWuthPrice:(NSDictionary *)result {
    NSLog(@"result Curensy ====== %@", result);
    self.currencyPrices = result;
    [self setInfoLabel];
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
    
    CGFloat height = MAX(totalHeight, 30.0f);
    return height;
}




#pragma mark - Actions

- (IBAction)actionToggleLeftDrawer:(id)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (void) filterPress {
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"SortingView" owner:self options:nil];
    SortingView *mainView = [subviewArray objectAtIndex:0];
    //mainView.frame = self.view.bounds;
    mainView.currentSelectSorting = currentSelectSorting;
    mainView.arrowCurrentSorting = arrowCurrentSorting;
    mainView.delegate = self;
    
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    
    // set frame of auto play bg view
    mainView.frame = window.frame;
    [window addSubview: mainView];
    
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
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[NSString stringWithFormat:@"methods.names.%@", LANGUAGE[INDEX_COUNTRY]]
                                                         ascending:YES];
            
        } else if (filterModule.currentFilter == Time) {
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"methods.calcResultTime"
                                                         ascending:YES];
            
        }
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray = [listOfResult sortedArrayUsingDescriptors:sortDescriptors].copy;
        listOfResult = sortedArray.mutableCopy;
        [self.tableView reloadData];
    }
}


#pragma mark - SortingViewDelegate

- (void)sortingResultsBy:(Filter)filter withFlag:(Arrow)flag {

    currentSelectSorting = filter;
    arrowCurrentSorting = (flag == Top || flag == None) ? Bottom : Top;

    NSSortDescriptor *sortDescriptor;
    
    if (filter == Cost) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[NSString stringWithFormat:@"methods.calcResultPrices.%@", CURRENCY_NAME[INDEX_CURRENCY]]
                                                     ascending:arrowCurrentSorting == Top ? YES : NO];
    } else if (filter == Transfer) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"transportName"
                                                     ascending:arrowCurrentSorting == Top ? YES : NO];
    } else if (filter == Process) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[NSString stringWithFormat:@"methods.names.%@", LANGUAGE[INDEX_COUNTRY]]
                                                     ascending:arrowCurrentSorting == Top ? YES : NO];
    } else if (filter == Time) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"methods.calcResultTime"
                                                     ascending:arrowCurrentSorting == Top ? YES : NO];
    }
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [listOfResult sortedArrayUsingDescriptors:sortDescriptors].copy;
    listOfResult = sortedArray.mutableCopy;
    [self.tableView reloadData];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
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


- (void)UpdateUI:(NSNotification *)notification {
    [self viewWillAppear:YES];
}

@end
