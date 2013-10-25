//
//  RootViewController.m
//  MCAlertViewDemo
//
//  Created by wusj on 13-10-25.
//  Copyright (c) 2013年 brant. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn1 = [[[UIButton alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 20, 40)] autorelease];
    [btn1 setTitle:@"确定 取消 单选" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[[UIButton alloc] initWithFrame:CGRectMake(10, 80, self.view.frame.size.width - 20, 40)] autorelease];
    [btn2 setTitle:@"确定 取消 多选" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)btn1 {
    MCAlertView *alertView = [[MCAlertView alloc] init];
    alertView.choiceMode = ChoiceModeSingle;
    alertView.buttonType = ButtonTypeDefault;
    alertView.mcDelegate = self;
    alertView.title = @"title";
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    for (int i = 0; i < 4; i++) {
        CellData *data = [[[CellData alloc] init] autorelease];
        data.isSelected = NO;
        data.title = [NSString stringWithFormat:@"row %d ", i];
        [array addObject:data];
    }
    
    alertView.dataArray = array;
    [alertView show];
}

- (void)btn2 {
    MCAlertView *alertView = [[MCAlertView alloc] init];
    alertView.choiceMode = ChoiceModeMultiple;
    alertView.buttonType = ButtonTypeDefault;
    alertView.mcDelegate = self;
    alertView.title = @"title";
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    for (int i = 0; i < 14; i++) {
        CellData *data = [[[CellData alloc] init] autorelease];
        data.isSelected = NO;
        data.title = [NSString stringWithFormat:@"row %d ", i];
        [array addObject:data];
    }
    
    alertView.dataArray = array;
    [alertView show];
}

#pragma mark - MCAlertViewDelegate
- (void)okButtonClickedAlertView:(MCAlertView *)alertView {
    NSLog(@"数据是从当前viewController传过去的，vc里面就可以读到数据的改变");
    [alertView dismiss];
}

- (void)didSelectedRow:(int)row {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
