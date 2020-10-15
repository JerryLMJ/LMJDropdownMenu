//
//  Demo-TableViewCellVC.m
//  LMJDropdownMenuExample
//
//  Created by limingjie on 2020/10/14.
//  Copyright © 2020 LMJ. All rights reserved.
//

#import "Demo-TableViewCellVC.h"
#import "LMJDropdownMenu.h"

@interface Demo_TableViewListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet LMJDropdownMenu *menu;
@end

@implementation Demo_TableViewListCell
@end






@interface Demo_TableViewCellVC () <UITableViewDelegate, UITableViewDataSource, LMJDropdownMenuDelegate, LMJDropdownMenuDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listView;
@end

@implementation Demo_TableViewCellVC
{
    NSArray * _menu1OptionTitles;
    NSArray * _menu1OptionIcons;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menu1OptionTitles = @[@"Option1",@"Option2",@"Option3",@"Option4",@"Option5"];
    _menu1OptionIcons = @[@"icon1",@"icon2",@"icon3",@"icon4",@"icon5"];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Demo_TableViewListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    /* LMJDropdownMenu */
    cell.menu.delegate   = self;
    cell.menu.dataSource = self;
    
    cell.menu.layer.borderColor  = [UIColor whiteColor].CGColor;
    
    cell.menu.title           = @"Please Select";
    cell.menu.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    cell.menu.titleFont       = [UIFont boldSystemFontOfSize:15];
    cell.menu.titleColor      = [UIColor whiteColor];
    cell.menu.titleAlignment  = NSTextAlignmentLeft;
    cell.menu.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    cell.menu.rotateIcon      = [UIImage imageNamed:@"arrowIcon3"];
    cell.menu.rotateIconSize  = CGSizeMake(15, 15);
    
    cell.menu.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    cell.menu.optionFont          = [UIFont systemFontOfSize:13];
    cell.menu.optionTextColor     = [UIColor blackColor];
    cell.menu.optionTextAlignment = NSTextAlignmentLeft;
    cell.menu.optionNumberOfLines = 0;
    cell.menu.optionLineColor     = [UIColor whiteColor];
    cell.menu.optionIconSize      = CGSizeMake(15, 15);
    /* LMJDropdownMenu */
    return cell;
}


#pragma mark - LMJDropdownMenu DataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu{
    return _menu1OptionTitles.count;
}
- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
    return 30;
}
- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
    return _menu1OptionTitles[index];
}
- (UIImage *)dropdownMenu:(LMJDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
    return [UIImage imageNamed:_menu1OptionIcons[index]];
}

#pragma mark - LMJDropdownMenu Delegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title{
    NSLog(@"你选择了(you selected)：menu1，index: %ld - title: %@", index, title);
}
- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    NSLog(@"--将要显示(will appear)--menu1");
}
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
    NSLog(@"--已经显示(did appear)--menu1");
}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
    NSLog(@"--将要隐藏(will disappear)--menu1");
}
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu{
    NSLog(@"--已经隐藏(did disappear)--menu1");
}

@end
