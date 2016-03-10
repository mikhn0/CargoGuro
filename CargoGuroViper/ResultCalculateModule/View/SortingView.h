//
//  SortingView.h
//  CargoGuroViper
//
//  Created by Виктория on 05.03.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGFilterModulePresenter.h"
#import "CGResultCalculateModuleViewController.h"

@protocol SortingViewDelegate <NSObject>

- (void)sortingResultsBy:(Filter)filter withFlag:(Arrow)flag;

@end

@interface SortingView : UIView

@property (weak, nonatomic) id <SortingViewDelegate> delegate;
@property (nonatomic) Filter currentSelectSorting;
@property (nonatomic) Arrow arrowCurrentSorting;

@end
