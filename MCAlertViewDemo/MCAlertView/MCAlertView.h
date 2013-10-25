//
//  MCAlertView.h
//  InCarTimeV3
//
//  Created by wusj on 13-10-24.
//  Copyright (c) 2013年 wangsl-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCAlertView;

typedef NS_ENUM(NSInteger, ButtonType) {
    ButtonTypeDefault = 0,      // show two buttons
    ButtonTypeCancel,           // just show cancel
    ButtonTypeNone              // no button
};

typedef NS_ENUM(NSInteger, ChoiceMode) {
    ChoiceModeMultiple = 0,         // multiple choice, is default
    ChoiceModeSingle                // single choice
};

@protocol MCAlertViewDelegate <NSObject>

@optional;
- (void)okButtonClickedAlertView:(MCAlertView *)alertView;
- (void)didSelectedRow:(int)row;

@end

@interface MCAlertView : UIWindow <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id <MCAlertViewDelegate> mcDelegate;
@property (nonatomic, retain) NSArray *dataArray;   // the data type must be CellData class type
@property (nonatomic, assign) ChoiceMode choiceMode;
@property (nonatomic, assign) ButtonType buttonType;
@property (nonatomic, copy) NSString *title;

- (void)show;
- (void)dismiss;

@end

@interface CellData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface CheckCell : UITableViewCell

@property (nonatomic, retain) CellData *cellData;

- (void)bindData:(CellData *)data;
- (void)onClick;

@end
