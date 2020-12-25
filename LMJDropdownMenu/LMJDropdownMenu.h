//
//  LMJDropdownMenu.h
//
//  Created by Jerry LMJ on 15/5/4.
//  Copyright (c) 2015年 LMJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMJDropdownMenu;

NS_ASSUME_NONNULL_BEGIN
@protocol LMJDropdownMenuDataSource <NSObject>
@required
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu;
- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index;
- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index;
@optional
- (UIImage *)dropdownMenu:(LMJDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index;
@end


@protocol LMJDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu;    // 当下拉菜单将要显示时调用
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu;     // 当下拉菜单已经显示时调用
- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu;  // 当下拉菜单将要收起时调用
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu;   // 当下拉菜单已经收起时调用

- (void)dropdownMenu:(LMJDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title; // 当选择某个选项时调用
@end




@interface LMJDropdownMenu : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <LMJDropdownMenuDataSource> dataSource;
@property (nonatomic, weak) id <LMJDropdownMenuDelegate> delegate;

@property (nonatomic,copy)   NSString        * title;
@property (nonatomic,strong) UIColor         * titleBgColor;
@property (nonatomic,strong) UIFont          * titleFont;
@property (nonatomic,strong) UIColor         * titleColor;
@property (nonatomic)        NSTextAlignment   titleAlignment;
@property (nonatomic)        UIEdgeInsets      titleEdgeInsets;

@property (nonatomic,strong) UIImage         * rotateIcon;
@property (nonatomic,assign) CGSize            rotateIconSize;
@property (nonatomic,assign) CGFloat           rotateIconMarginRight; // default: 7.5
@property (nonatomic,strong) UIColor         * rotateIconTint;

@property (nonatomic,strong) UIColor         * optionBgColor;
@property (nonatomic,strong) UIFont          * optionFont;
@property (nonatomic,strong) UIColor         * optionTextColor;
@property (nonatomic)        NSTextAlignment   optionTextAlignment;
@property (nonatomic,assign) CGFloat           optionTextMarginLeft; // default: 15
@property (nonatomic)        NSInteger         optionNumberOfLines;
@property (nonatomic,assign) CGSize            optionIconSize;  // default:(15,15)
@property (nonatomic,assign) CGFloat           optionIconMarginRight; // default: 15
@property (nonatomic,strong) UIColor         * optionLineColor;
@property (nonatomic,assign) CGFloat           optionLineHeight; // default: 0.5

/*
 选项列表的最大高度。超出最大高度后，选项可滚动 （optionsListLimitHeight <= 0 时，下拉列表将显示所有选项）
 The maximum height of the drop-down list, beyond which the options can be scrolled （When optionsListLimitHeight <= 0, the drop-down list shows all options）
 */
@property (nonatomic,assign) CGFloat           optionsListLimitHeight; // default: 0
@property (nonatomic,assign) BOOL              showsVerticalScrollIndicatorOfOptionsList; // default: YES


@property (nonatomic,assign) CGFloat animateTime;   // 下拉动画时间 default: 0.25


- (void)reloadOptionsData;

- (void)showDropDown; // 显示下拉菜单
- (void)hideDropDown; // 隐藏下拉菜单

@end

NS_ASSUME_NONNULL_END
