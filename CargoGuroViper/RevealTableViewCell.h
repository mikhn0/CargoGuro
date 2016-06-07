//
//  JVDrawerTableViewCell.h
//  JVFloatingDrawer
//
//  Created by Julian Villella on 2015-01-15.
//  Copyright (c) 2015 JVillella. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RevealTableViewCellDelegate <NSObject>

- (void)segueOnMainScreen;

@end

@interface RevealTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, copy) NSString *titleParameter;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, weak) id <RevealTableViewCellDelegate> delegate;

@end
