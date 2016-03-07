//
//  CGFilterModuleViewController.m
//  CargoGuroViper
//
//  Created by Виктория on 03/03/2016.
//  Copyright © 2016 Fruktorum. All rights reserved.
//

#import "CGFilterModuleViewController.h"

#import "CGFilterModuleViewOutput.h"


@interface CGFilterModuleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation CGFilterModuleViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
    [self setCustomNavigationBackButton];
}


- (void)setCustomNavigationBackButton
{
    
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"custom_back_button"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = @"Фильтры";
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor colorWithRed:77.0/255.0 green:77.0/255.0 blue:77.0/255.0 alpha:1.0];
    lblTitle.shadowColor = [UIColor whiteColor];
    lblTitle.shadowOffset = CGSizeMake(0, 1);
    lblTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
    [lblTitle sizeToFit];
    
    self.navigationItem.titleView = lblTitle;
    
}


#pragma mark - Методы CGFilterModuleViewInput

- (void)setupInitialState {
	// В этом методе происходит настройка параметров view, зависящих от ее жизненого цикла (создание элементов, анимации и пр.)
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentFilter = indexPath.row;
    [self performSegueWithIdentifier:@"unwindToResultCalculateSegue" sender:self];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *resultTableIdentifier = @"FilterCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:resultTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:resultTableIdentifier];
    }
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"По цене";
        
    } else if (indexPath.row == 1) {
        
        cell.textLabel.text = @"По перевозчику";
        
    } else if (indexPath.row == 2) {
        
        cell.textLabel.text = @"По способу";
        
    } else if (indexPath.row == 3) {
        
        cell.textLabel.text = @"По времени";
        
    }
    return cell;
}

-(void) popBack {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
