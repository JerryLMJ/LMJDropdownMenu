//
//  Demo-LayoutByMasonryVC.m
//  LMJDropdownMenuExample
//
//  Created by limingjie on 2021/1/20.
//  Copyright © 2021 LMJ. All rights reserved.
//

#import "Demo-LayoutByMasonryVC.h"
#import "LMJDropdownMenu.h"
#import "Masonry.h"

@interface Demo_LayoutByMasonryVC () <LMJDropdownMenuDataSource>

@end

@implementation Demo_LayoutByMasonryVC
{
    LMJDropdownMenu *_menu;
    
    NSArray *_optionTitles;
    NSArray *_optionIcons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _optionTitles = @[@"Option1",@"Option2",@"Option3",@"Option4",@"Option5"];
    _optionIcons = @[@"icon1",@"icon2",@"icon3",@"icon4",@"icon5"];
    
    _menu = [[LMJDropdownMenu alloc] init];
    _menu.dataSource = self;
    
    _menu.layer.borderColor  = [UIColor whiteColor].CGColor;
    _menu.layer.borderWidth  = 1;
    _menu.layer.cornerRadius = 3;
    
    _menu.title           = @"Please Select";
    _menu.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    _menu.titleFont       = [UIFont boldSystemFontOfSize:15];
    _menu.titleColor      = [UIColor whiteColor];
    _menu.titleAlignment  = NSTextAlignmentLeft;
    _menu.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    _menu.rotateIcon            = [UIImage imageNamed:@"arrowIcon3"];
    _menu.rotateIconSize        = CGSizeMake(15, 15);
    _menu.rotateIconMarginRight = 15;
    
    _menu.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    _menu.optionFont          = [UIFont systemFontOfSize:13];
    _menu.optionTextColor     = [UIColor blackColor];
    _menu.optionTextAlignment = NSTextAlignmentLeft;
    _menu.optionNumberOfLines = 0;
    _menu.optionLineColor     = [UIColor whiteColor];
    _menu.optionIconSize      = CGSizeMake(15, 15);
    
    [self.view addSubview:_menu];
    
    
    [_menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - LMJDropdownMenu DataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu{
    return _optionTitles.count;
}
- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
    return 40;
}
- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
    return _optionTitles[index];
}
- (UIImage *)dropdownMenu:(LMJDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
    return [UIImage imageNamed:_optionIcons[index]];
}
@end
