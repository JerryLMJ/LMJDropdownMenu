//
//  ViewController.m
//  LMJDropdownMenuExample
//
//  Created by LiMingjie on 2019/5/24.
//  Copyright © 2019 LMJ. All rights reserved.
//

#import "ViewController.h"

#import "LMJDropdownMenu.h"

@interface ViewController () <LMJDropdownMenuDataSource,LMJDropdownMenuDelegate>
{
    NSArray * _optionTitles;
    NSArray * _optionIcons;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    _optionTitles = @[@"Option1",@"Option2",@"Option3",@"Option4",@"Option5"];
    _optionIcons = @[@"icon1",@"icon2",@"icon3",@"icon4",@"icon5"];
    
    
    
    LMJDropdownMenu * menu = [[LMJDropdownMenu alloc] init];
    [menu setFrame:CGRectMake(20, 80, 150, 40)];
    menu.dataSource = self;
    menu.delegate   = self;
    
    menu.layer.borderColor  = [UIColor whiteColor].CGColor;
    menu.layer.borderWidth  = 1;
    menu.layer.cornerRadius = 3;
    
    menu.title           = @"选择框";
    menu.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    menu.titleFont       = [UIFont boldSystemFontOfSize:15];
    menu.titleColor      = [UIColor whiteColor];
    menu.titleAlignment  = NSTextAlignmentLeft;
    menu.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    menu.rotateIcon      = [UIImage imageNamed:@"arrowIcon3"];
    menu.rotateIconSize  = CGSizeMake(15, 15);
    
    menu.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    menu.optionFont          = [UIFont systemFontOfSize:13];
    menu.optionTextColor     = [UIColor blackColor];
    menu.optionTextAlignment = NSTextAlignmentCenter;
    menu.optionNumberOfLines = 0;
    menu.optionLineColor     = [UIColor whiteColor];
    menu.optionIconSize      = CGSizeMake(15, 15);
    
    [self.view addSubview:menu];
}

#pragma mark - LMJDropdownMenu DataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu{
    return _optionTitles.count;
}
- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
    return 30;
}
- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
    return _optionTitles[index];
}
- (UIImage *)dropdownMenu:(LMJDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
    return [UIImage imageNamed:_optionIcons[index]];
}
#pragma mark - LMJDropdownMenu Delegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    NSLog(@"你选择了(you selected)：%ld",number);
}

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    NSLog(@"--将要显示(will appear)--");
}
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
    NSLog(@"--已经显示(did appear)--");
}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
    NSLog(@"--将要隐藏(will disappear)--");
}
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu{
    NSLog(@"--已经隐藏(did disappear)--");
}


@end
