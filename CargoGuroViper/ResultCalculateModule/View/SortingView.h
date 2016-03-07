//
//  SortingView.h
//  CargoGuroViper
//
//  Created by Виктория on 05.03.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGFilterModulePresenter.h"

@protocol SortingViewDelegate <NSObject>

- (void)sortingResultsBy:(Filter)filter withFlag:(BOOL)flag;

@end

@interface SortingView : UIView

@property (weak, nonatomic) id <SortingViewDelegate> delegate;
@property (nonatomic) Filter currentSelectSorting;

- (id)initWithFrame:(CGRect)frame;

@end
