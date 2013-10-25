//
//  MCAlertView.m
//  InCarTimeV3
//
//  Created by wusj on 13-10-24.
//  Copyright (c) 2013年 wangsl-iMac. All rights reserved.
//

#import "MCAlertView.h"

#define screenHeight [[UIScreen mainScreen] bounds].size.height
#define screenWidth [[UIScreen mainScreen] bounds].size.width

#define ALERT_WIDTH 300
// alert view max height
#define MAX_HEIGHT (screenHeight - 90)
// content row height
#define ITEM_HEIGHT 50
// leave 1px to seprator
#define BUTTON_HEIGHT 49 
#define TITLE_HEIGHT 50

@interface MCAlertView ()

@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) UIView *alertView;

@end

@implementation MCAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id)init {
    if (self == [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.windowLevel = UIWindowLevelAlert;
        self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        self.choiceMode = ChoiceModeMultiple;
        self.buttonType = ButtonTypeDefault;
    }
    
    return self;
}

- (void)setupViews {
    self.alertView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, ALERT_WIDTH, 0)] autorelease];
    self.alertView.center = CGPointMake(screenWidth / 2, screenHeight);
    self.alertView.backgroundColor = [UIColor colorWithRed:65.0/255.0f green:177.0/255.0f blue:102.0/255.0f alpha:1];
    [self addSubview:self.alertView];
    
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 4, self.alertView.frame.size.width, 50)] autorelease];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont systemFontOfSize:25];
    [self.alertView addSubview:titleLabel];
    
    // table view height
    int tableViewhei = [self.dataArray count] * ITEM_HEIGHT;
    int hei = MIN(tableViewhei, MAX_HEIGHT - BUTTON_HEIGHT - TITLE_HEIGHT - 6);
    // update alertView height
    CGRect frame = self.alertView.frame;
    frame.size = CGSizeMake(ALERT_WIDTH, hei + BUTTON_HEIGHT + TITLE_HEIGHT + 6);
    if (self.buttonType == ButtonTypeNone) {
        frame.size = CGSizeMake(ALERT_WIDTH, hei + TITLE_HEIGHT + 6);
    }
    self.alertView.frame = frame;
    
    self.contentView = [[[UIView alloc] initWithFrame:CGRectMake(0, titleLabel.frame.size.height + titleLabel.frame.origin.y + 2, ALERT_WIDTH, hei)] autorelease];
    [self.alertView addSubview:self.contentView];
    switch (self.buttonType) {
        case ButtonTypeCancel: {
            // 分隔线
            UILabel *btnSeprator = [[[UILabel alloc] initWithFrame:CGRectMake(0, self.alertView.frame.size.height - 50, ALERT_WIDTH, 1)] autorelease];
            btnSeprator.backgroundColor = [UIColor grayColor];
            [self.alertView addSubview:btnSeprator];
            
            UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cancelBtn setBackgroundColor:[UIColor whiteColor]];
            [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cancelBtn setBackgroundImage:[UIImage imageNamed:@"alert_view_btn_pressed.png"] forState:UIControlStateHighlighted];
            cancelBtn.frame = CGRectMake(0, self.alertView.frame.size.height - BUTTON_HEIGHT, self.alertView.frame.size.width, BUTTON_HEIGHT);
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:cancelBtn];
            break;
        }
        case ButtonTypeNone: {
            
            break;
        }
            
        case ButtonTypeDefault:
        default: {
            // seprator
            UILabel *btnSeprator = [[[UILabel alloc] initWithFrame:CGRectMake(0, self.alertView.frame.size.height - 50, ALERT_WIDTH, 1)] autorelease];
            btnSeprator.backgroundColor = [UIColor grayColor];
            [self.alertView addSubview:btnSeprator];
            
            UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [okBtn setBackgroundColor:[UIColor whiteColor]];
            [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [okBtn setBackgroundImage:[UIImage imageNamed:@"alert_view_btn_pressed.png"] forState:UIControlStateHighlighted];
            okBtn.frame = CGRectMake(0, self.alertView.frame.size.height - BUTTON_HEIGHT, self.alertView.frame.size.width / 2, BUTTON_HEIGHT);
            [okBtn setTitle:@"OK" forState:UIControlStateNormal];
            [okBtn addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:okBtn];
            
            UILabel *sperator3 = [[[UILabel alloc] initWithFrame:CGRectMake(ALERT_WIDTH / 2, self.alertView.frame.size.height - 50, 1, 50)] autorelease];
            sperator3.backgroundColor = [UIColor grayColor];
            [self.alertView addSubview:sperator3];
            
            UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cancelBtn setBackgroundColor:[UIColor whiteColor]];
            [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cancelBtn setBackgroundImage:[UIImage imageNamed:@"alert_view_btn_pressed.png"] forState:UIControlStateHighlighted];
            cancelBtn.frame = CGRectMake(self.alertView.frame.size.width / 2 + 1, self.alertView.frame.size.height - BUTTON_HEIGHT, self.alertView.frame.size.width / 2 - 1, BUTTON_HEIGHT);
            [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:cancelBtn];
            break;
        }
    }
    
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ALERT_WIDTH, hei) style:UITableViewStylePlain] autorelease];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.contentView addSubview:self.myTableView];
    
    if (hei >= tableViewhei) {
        self.myTableView.scrollEnabled = NO;
    } else {
        self.myTableView.scrollEnabled = YES;
    }
    
    [self animation:self.alertView];
}

- (void)okButtonClicked {
    if (self.mcDelegate && [self.mcDelegate respondsToSelector:@selector(okButtonClickedAlertView:)]) {
        [self.mcDelegate okButtonClickedAlertView:self];
    }
}

- (void)animation:(UIView *)view {
    [UIView animateWithDuration:0.5 animations:^{
        view.center = CGPointMake(screenWidth / 2, screenHeight / 2);
    }];
}

- (UIView *)createItemWithTitle:(NSString *)title frame:(CGRect)frame {
    UIView *item = [[[UIView alloc] initWithFrame:frame] autorelease];
    item.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 80, frame.size.height)] autorelease];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [item addSubview:titleLabel];
    
    UIButton *selectBtn = [[[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 40, 5, 30, 30)] autorelease];
    [selectBtn setImage:[UIImage imageNamed:@"radio_btn_off.png"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"radio_btn_on.png"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [item addSubview:selectBtn];
    
    return item;
}

- (void)selectBtn:(UIButton *)btn {
    if (btn.isSelected) {
        [btn setSelected:NO];
    } else {
        [btn setSelected:YES];
    }
}

#pragma mark - UITableDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CheckCell *cell = (CheckCell *) [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[CheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert_view_item_pressed.png"]];
    }
    
    [cell bindData:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ITEM_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.choiceMode == ChoiceModeSingle) {
        for (int i = 0; i < [self.dataArray count]; i++) {
            CellData *data = [self.dataArray objectAtIndex:i];
            if (indexPath.row != i) {
                data.isSelected = NO;
            } else {
                data.isSelected = YES;
            }
        }
    
        [self.myTableView reloadData];
    } else {
        CheckCell *cell = (CheckCell *) [tableView cellForRowAtIndexPath:indexPath];
        [cell onClick];
    }
    
    if (self.mcDelegate && [self.mcDelegate respondsToSelector:@selector(didSelectedRow:)]) {
        [self.mcDelegate didSelectedRow:indexPath.row];
    }
    
    // 单选无按钮的模式下，点击消失
    if (self.choiceMode == ChoiceModeSingle && self.buttonType == ButtonTypeNone) {
        [self dismiss];
    }
}

- (void)show {
    [self setupViews];
    [self makeKeyAndVisible];
}

- (void)dismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.center = CGPointMake(screenWidth / 2, screenHeight + self.alertView.frame.size.height / 2);
    } completion:^(BOOL com) {
        [self resignKeyWindow];
        [self release];
    }];
}

- (void)dealloc
{
    [self.title release];
    [self.contentView release];
    [self.myTableView release];
    [self.dataArray release];
    [self.alertView release];
    [super dealloc];
}

@end

/*      Cell        */
@interface CheckCell ()

@property (nonatomic, retain) UIView * view;
@property (nonatomic, retain) UIButton *btn;
@property (nonatomic, retain) UILabel *titleLabel;

@end

@implementation CheckCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    self.view = [[[UIView alloc] initWithFrame:self.frame] autorelease];
    [self.contentView addSubview:self.view];
    
    self.btn = [[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, 5, 40, 40)] autorelease];
    [self.btn setImage:[UIImage imageNamed:@"radio_btn_off.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.btn];
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(5, 0, ALERT_WIDTH - ITEM_HEIGHT, ITEM_HEIGHT)] autorelease];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.titleLabel];
}

- (void)onClick {
    if (self.cellData.isSelected) {
        self.cellData.isSelected = NO;
        [self.btn setImage:[UIImage imageNamed:@"radio_btn_off.png"] forState:UIControlStateNormal];
    } else {
        self.cellData.isSelected = YES;
        [self.btn setImage:[UIImage imageNamed:@"radio_btn_on.png"] forState:UIControlStateNormal];
    }
}

- (void)bindData:(CellData *)data {
    self.cellData = data;
    self.titleLabel.text = data.title;
    if (data.isSelected) {
        [self.btn setImage:[UIImage imageNamed:@"radio_btn_on.png"] forState:UIControlStateNormal];
    } else {
        [self.btn setImage:[UIImage imageNamed:@"radio_btn_off.png"] forState:UIControlStateNormal];
    }
}

- (void)dealloc
{
    [self.view release];
    [self.btn release];
    [self.titleLabel release];
    [self.cellData release];
    [super dealloc];
}

@end

@implementation CellData

- (void)dealloc
{
    [self.title release];
    [super dealloc];
}

@end
