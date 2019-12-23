//
//  ViewController.m
//  LMJDropdownMenuExample
//
//  Created by LiMingjie on 2019/5/24.
//  Copyright © 2019 LMJ. All rights reserved.
//

#import "ViewController.h"
#import "Demo-StoryboardVC.h"

#import "LMJDropdownMenu.h"

@interface ViewController () <LMJDropdownMenuDataSource,LMJDropdownMenuDelegate>
{
    NSArray * _menu1OptionTitles;
    NSArray * _menu1OptionIcons;
    
    NSArray * _menu2OptionTitles;
    
    LMJDropdownMenu * menu1;
    LMJDropdownMenu * menu2;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    _menu1OptionTitles = @[@"Option1",@"Option2",@"Option3",@"Option4",@"Option5"];
    _menu1OptionIcons = @[@"icon1",@"icon2",@"icon3",@"icon4",@"icon5"];
    
    _menu2OptionTitles = @[@"选项一\n1",@"选项二\n2",@"选项三\n3",@"选项四\n4"];
    
    
    
    // ----------------------- menu1 ---------------------------
    menu1 = [[LMJDropdownMenu alloc] init];
    [menu1 setFrame:CGRectMake(20, 80, 150, 40)];
    menu1.dataSource = self;
    menu1.delegate   = self;
    
    menu1.layer.borderColor  = [UIColor whiteColor].CGColor;
    menu1.layer.borderWidth  = 1;
    menu1.layer.cornerRadius = 3;
    
    menu1.title           = @"Please Select";
    menu1.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    menu1.titleFont       = [UIFont boldSystemFontOfSize:15];
    menu1.titleColor      = [UIColor whiteColor];
    menu1.titleAlignment  = NSTextAlignmentLeft;
    menu1.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    menu1.rotateIcon      = [UIImage imageNamed:@"arrowIcon3"];
    menu1.rotateIconSize  = CGSizeMake(15, 15);
    
    menu1.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    menu1.optionFont          = [UIFont systemFontOfSize:13];
    menu1.optionTextColor     = [UIColor blackColor];
    menu1.optionTextAlignment = NSTextAlignmentLeft;
    menu1.optionNumberOfLines = 0;
    menu1.optionLineColor     = [UIColor whiteColor];
    menu1.optionIconSize      = CGSizeMake(15, 15);
    
    [self.view addSubview:menu1];
    
    
    
    // ----------------------- menu2 ---------------------------
    menu2 = [[LMJDropdownMenu alloc] initWithFrame:CGRectMake(200, 80, 150, 40)];
    menu2.dataSource = self;
    menu2.delegate   = self;

    menu2.layer.borderColor  = [UIColor blackColor].CGColor;
    menu2.layer.borderWidth  = 1;
//    menu2.layer.cornerRadius = 3;

    menu2.title           = @"Please Select";
    menu2.titleBgColor    = [UIColor lightGrayColor];
    menu2.titleFont       = [UIFont boldSystemFontOfSize:15];
    menu2.titleColor      = [UIColor orangeColor];
    menu2.titleAlignment  = NSTextAlignmentCenter;
    menu2.titleEdgeInsets = UIEdgeInsetsZero;

//    menu2.rotateIcon      = [UIImage imageNamed:@"arrowIcon3"];
//    menu2.rotateIconSize  = CGSizeMake(15, 15);

    menu2.optionBgColor       = [UIColor whiteColor];
    menu2.optionFont          = [UIFont systemFontOfSize:12];
    menu2.optionTextColor     = [UIColor blackColor];
    menu2.optionTextAlignment = NSTextAlignmentCenter;
    menu2.optionNumberOfLines = 0;
    menu2.optionLineColor     = [UIColor blackColor];
//    menu2.optionIconSize      = CGSizeMake(15, 15);

    [self.view addSubview:menu2];
    
    
    [self buildGotoStoryboardPageBtn];
}

- (void)buildGotoStoryboardPageBtn{
    UIButton * demoAddToXibPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [demoAddToXibPageBtn setTitle:@"DemoAddToXibPage >>>" forState:UIControlStateNormal];
    [demoAddToXibPageBtn setBackgroundColor:[UIColor grayColor]];
    [demoAddToXibPageBtn setFrame:CGRectMake(20, 550, 300, 30)];
    [demoAddToXibPageBtn addTarget:self action:@selector(clickDemoAddToXibPageBtn) forControlEvents:UIControlEventTouchUpInside];
    demoAddToXibPageBtn.layer.cornerRadius = 3;
    [self.view addSubview:demoAddToXibPageBtn];
}

- (void)clickDemoAddToXibPageBtn {
    Demo_StoryboardVC * vc = [[UIStoryboard storyboardWithName:@"Demo" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Demo_StoryboardVC"];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - LMJDropdownMenu DataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu{
    if (menu == menu1) {
        return _menu1OptionTitles.count;
    } else if (menu == menu2) {
        return _menu2OptionTitles.count;
    } else {
        return 0;
    }
}
- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
    if (menu == menu1) {
        return 30;
    } else if (menu == menu2) {
        return 40;
    } else {
        return 0;
    }
}
- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
    if (menu == menu1) {
        return _menu1OptionTitles[index];
    } else if (menu == menu2) {
        return _menu2OptionTitles[index];
    } else {
        return @"";
    }
}
- (UIImage *)dropdownMenu:(LMJDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
    if (menu == menu1) {
        return [UIImage imageNamed:_menu1OptionIcons[index]];
    } else {
        return nil;
    }
}
#pragma mark - LMJDropdownMenu Delegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title{
    if (menu == menu1) {
        NSLog(@"你选择了(you selected)：menu1，index: %ld - title: %@", index, title);
    } else if (menu == menu2) {
        NSLog(@"你选择了(you selected)：menu2，index: %ld - title: %@", index, title);
    }
}

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    if (menu == menu1) {
        NSLog(@"--将要显示(will appear)--menu1");
    } else if (menu == menu2) {
        NSLog(@"--将要显示(will appear)--menu2");
    }
}
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
    if (menu == menu1) {
        NSLog(@"--已经显示(did appear)--menu1");
    } else if (menu == menu2) {
        NSLog(@"--已经显示(did appear)--menu2");
    }
}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
    if (menu == menu1) {
        NSLog(@"--将要隐藏(will disappear)--menu1");
    } else if (menu == menu2) {
        NSLog(@"--将要隐藏(will disappear)--menu2");
    }
}
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu{
    if (menu == menu1) {
        NSLog(@"--已经隐藏(did disappear)--menu1");
    } else if (menu == menu2) {
        NSLog(@"--已经隐藏(did disappear)--menu2");
    }
}


@end
