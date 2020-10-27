//
//  LMJDropdownMenu.m
//
//  Created by JerryLMJ on 15/5/4.
//  Copyright (c) 2015年 LMJ. All rights reserved.
//

#import "LMJDropdownMenu.h"

@interface LMJDropdownMenu() <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton    *mainBtn;      // 菜单按钮
@property (nonatomic, strong) UIImageView *arrowMark;    // 尖头图标
@property (nonatomic, strong) UITableView *optionsList;  // 下拉列表

@property (nonatomic, strong) UIView      *floatView;
@property (nonatomic, strong) UIView      *coverView;

@end



@implementation LMJDropdownMenu
{
    BOOL _isOpened;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initProperties];
        [self initViews];
        [self initFrame:self.frame];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initProperties];
    [self initViews];
    [self initFrame:self.frame];
}

- (void)layoutSubviews {
    if (_isOpened) return;
    CGFloat width  = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    [_floatView setFrame:CGRectMake(_floatView.frame.origin.x, _floatView.frame.origin.y, width, height)];
    [_mainBtn setFrame:CGRectMake(0, 0, width, height)];
    [_arrowMark setFrame:CGRectMake(width -self.rotateIconMarginRight -self.rotateIconSize.width, (height -self.rotateIconSize.height)/2, self.rotateIconSize.width, self.rotateIconSize.height)];
    [_optionsList setFrame:CGRectMake(0, height, width, _optionsList.frame.size.height)];
}

#pragma mark - Init
- (void)initProperties{
    _title                  = @"Please Select";
    _titleBgColor           = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    _titleFont              = [UIFont boldSystemFontOfSize:15];
    _titleColor             = [UIColor whiteColor];
    _titleAlignment         = NSTextAlignmentLeft;
    _titleEdgeInsets        = UIEdgeInsetsMake(0, 10, 0, 10);

    _rotateIcon             = nil;
    _rotateIconSize         = CGSizeMake(15, 15);
    _rotateIconMarginRight  = 7.5;
    _rotateIconTint         = [UIColor blackColor];

    _optionBgColor          = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    _optionFont             = [UIFont systemFontOfSize:13];
    _optionTextColor        = [UIColor blackColor];
    _optionTextAlignment    = NSTextAlignmentCenter;
    _optionNumberOfLines    = 0;
    _optionIconSize         = CGSizeMake(0, 0);
    _optionIconMarginRight  = 15;
    _optionLineColor        = [UIColor whiteColor];
    _optionLineHeight       = 0.5f;

    _animateTime            = 0.25f;

    _optionsListLimitHeight = 0;

    _isOpened               = NO;
}

- (void)initViews{
    self.layer.masksToBounds = YES;
    
    _floatView = [[UIView alloc] initWithFrame:self.bounds];
    _floatView.layer.masksToBounds = YES;
    [self addSubview:_floatView];
    
    
    // 主按钮 显示在界面上的点击按钮
    _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mainBtn addTarget:self action:@selector(clickMainBtn:) forControlEvents:UIControlEventTouchUpInside];
    _mainBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _mainBtn.titleEdgeInsets            = UIEdgeInsetsMake(0, 15, 0, 0);
    _mainBtn.selected                   = NO;
    [_floatView addSubview:_mainBtn];
    
    // 旋转尖头
    _arrowMark = [[UIImageView alloc] init];
    [_arrowMark setTintColor:self.rotateIconTint];
    [_mainBtn addSubview:_arrowMark];
    
    
    // 下拉列表TableView
    _optionsList = [[UITableView alloc] init];
    _optionsList.delegate       = self;
    _optionsList.dataSource     = self;
    _optionsList.separatorStyle = UITableViewCellSeparatorStyleNone;
    _optionsList.scrollEnabled  = NO;
    [_floatView addSubview:_optionsList];
}

- (void)initFrame:(CGRect)frame {
    CGFloat width  = frame.size.width;
    CGFloat height = frame.size.height;
    [_floatView setFrame:CGRectMake(0, 0, width, height)];
    [_mainBtn setFrame:CGRectMake(0, 0, width, height)];
    [_arrowMark setFrame:CGRectMake(width -self.rotateIconMarginRight -self.rotateIconSize.width, (height -self.rotateIconSize.height)/2, self.rotateIconSize.width, self.rotateIconSize.height)];
    [_optionsList setFrame:CGRectMake(0, height, width, _optionsList.frame.size.height)];
}

#pragma mark - Action Methods
- (void)reloadOptionsData{
    [self.optionsList reloadData];
}
- (void)clickMainBtn:(UIButton *)button{
    if(button.selected == NO) {
        [self showDropDown];
    }else {
        [self hideDropDown];
    }
}

- (void)showDropDown{   /* 显示下拉列表 */
    _isOpened = YES;
    // 变更menu图层
    CGPoint newPosition = [self getScreenPosition];
    _floatView.frame = CGRectMake(newPosition.x, newPosition.y, _floatView.bounds.size.width, _floatView.bounds.size.height);
    _floatView.layer.borderColor  = self.layer.borderColor;
    _floatView.layer.borderWidth  = self.layer.borderWidth;
    _floatView.layer.cornerRadius = self.layer.cornerRadius;
    [self.coverView addSubview:_floatView];
    
    // call delegate
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillShow:)]) {
        [self.delegate dropdownMenuWillShow:self]; // 将要显示回调代理
    }
    
    // 刷新下拉列表数据
    [self reloadOptionsData];
    
    // 菜单高度计算
    CGFloat listHeight = 0;
    if (self.optionsListLimitHeight <= 0) { // 当未设置下拉菜单最小展示高度
        NSUInteger count = [self.dataSource numberOfOptionsInDropdownMenu:self];
        for (int i = 0; i < count; i++) {
            CGFloat cHeight = [self.dataSource dropdownMenu:self heightForOptionAtIndex:i];
            listHeight += cHeight;
        }
        _optionsList.scrollEnabled = NO;
    } else {
        listHeight = self.optionsListLimitHeight;
        _optionsList.scrollEnabled = YES;
    }
    
    // 执行展开动画
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.animateTime animations:^{
        UIView *floatView     = weakSelf.floatView;
        UIButton *mainBtn     = weakSelf.mainBtn;
        UITableView *listView = weakSelf.optionsList;
        
        floatView.frame = CGRectMake(floatView.frame.origin.x, floatView.frame.origin.y, floatView.frame.size.width, mainBtn.frame.size.height + listHeight);
        weakSelf.arrowMark.transform = CGAffineTransformMakeRotation(M_PI);
        listView.frame = CGRectMake(listView.frame.origin.x, listView.frame.origin.y, listView.frame.size.width, listHeight);
        
    }completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
            [self.delegate dropdownMenuDidShow:self]; // 已经显示回调代理
        }
    }];
    
    _mainBtn.selected = YES;
}


- (void)hideDropDown{  // 隐藏下拉列表
    // call delegate
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillHidden:)]) {
        [self.delegate dropdownMenuWillHidden:self]; // 将要隐藏回调代理
    }

    // 执行关闭动画
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.animateTime animations:^{
        UIView *floatView = weakSelf.floatView;
        UIButton *mainBtn = weakSelf.mainBtn;
        weakSelf.arrowMark.transform = CGAffineTransformIdentity;
        weakSelf.floatView.frame  = CGRectMake(floatView.frame.origin.x, floatView.frame.origin.y, floatView.frame.size.width, mainBtn.frame.size.height);
        
    }completion:^(BOOL finished) {
        weakSelf.optionsList.frame = CGRectMake(weakSelf.optionsList.frame.origin.x, weakSelf.optionsList.frame.origin.y, weakSelf.frame.size.width, 0);
        
        // 变更menu图层
        weakSelf.floatView.frame = weakSelf.floatView.bounds;
        [self addSubview:weakSelf.floatView];
        [weakSelf.coverView removeFromSuperview];
        weakSelf.coverView = nil;
        
        self->_isOpened = NO;
        
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidHidden:)]) {
            [self.delegate dropdownMenuDidHidden:self]; // 已经隐藏回调代理
        }
    }];
    
    _mainBtn.selected = NO;
}

#pragma mark - Utility Methods
- (CGPoint)getScreenPosition {
    return [self.superview convertPoint:self.frame.origin toView:[self getCurrentKeyWindow]];
}

- (UIWindow *)getCurrentKeyWindow {
//    UIApplication * application = [UIApplication sharedApplication];
//    if (application && application.windows && application.windows.count > 0) {
//        return application.windows.lastObject;
//    }
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfOptionsInDropdownMenu:self];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource dropdownMenu:self heightForOptionAtIndex:indexPath.row];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MenuOptionListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //---------------------------下拉选项样式，可在此处自定义-------------------------
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = self.optionBgColor;
        
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font          = self.optionFont;
        titleLabel.textColor     = self.optionTextColor;
        titleLabel.numberOfLines = self.optionNumberOfLines;
        titleLabel.textAlignment = self.optionTextAlignment;
        titleLabel.tag           = 999;
        [cell addSubview:titleLabel];
        
        UIImageView * icon = [[UIImageView alloc] init];
        icon.tag = 888;
        [cell addSubview:icon];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, self.optionLineHeight)];
        line.backgroundColor = self.optionLineColor;
        line.tag             = 777;
        [cell addSubview:line];
        //---------------------------------------------------------------------------
    }
    CGFloat cHeight = [self.dataSource dropdownMenu:self heightForOptionAtIndex:indexPath.row];
    
    UILabel * titleLabel = [cell viewWithTag:999];
    titleLabel.text  = [self.dataSource dropdownMenu:self titleForOptionAtIndex:indexPath.row];;
    titleLabel.frame = CGRectMake(15, 0, self.frame.size.width - 15 -self.optionIconSize.width -self.optionIconMarginRight, cHeight);
    
    UIImageView * icon = [cell viewWithTag:888];
    if ([self.dataSource respondsToSelector:@selector(dropdownMenu:iconForOptionAtIndex:)]){
        icon.image = [self.dataSource dropdownMenu:self iconForOptionAtIndex:indexPath.row];
    }
    icon.frame = CGRectMake(self.frame.size.width -self.optionIconSize.width -self.optionIconMarginRight, (cHeight - self.optionIconSize.height)/2, self.optionIconSize.width, self.optionIconSize.height);
    
    UIView *line = [cell viewWithTag:777];
    line.frame           = CGRectMake(0, 0, cell.frame.size.width, self.optionLineHeight);
    line.backgroundColor = self.optionLineColor;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel * titleLabel = [cell viewWithTag:999];
    self.title = titleLabel.text;
    if ([self.delegate respondsToSelector:@selector(dropdownMenu:didSelectOptionAtIndex:optionTitle:)]) {
        [self.delegate dropdownMenu:self didSelectOptionAtIndex:indexPath.row optionTitle:titleLabel.text];
    }
    [self hideDropDown];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
   if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
       return NO;
   }
   return  YES;
}


#pragma mark - Get Methods
- (BOOL)showsVerticalScrollIndicatorOfOptionsList {
    return _optionsList.showsVerticalScrollIndicator;
}

- (UIView *)coverView {
    UIWindow *window = [self getCurrentKeyWindow];
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, window.bounds.size.width, window.bounds.size.height)];
        _coverView.backgroundColor = [UIColor clearColor];
        [window addSubview:_coverView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDropDown)];
        tap.delegate = self;
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

#pragma mark - Set Methods
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self initFrame:frame];
}

- (void)setRotateIcon:(UIImage *)rotateIcon {
    _rotateIcon = rotateIcon;
    [self.arrowMark setImage:rotateIcon];
}
- (void)setRotateIconSize:(CGSize)rotateIconSize {
    _rotateIconSize = rotateIconSize;
    [self.arrowMark setFrame:CGRectMake(self.mainBtn.bounds.size.width -self.rotateIconMarginRight -rotateIconSize.width, (self.mainBtn.bounds.size.height -rotateIconSize.height)/2, rotateIconSize.width, rotateIconSize.height)];
}
- (void)setRotateIconMarginRight:(CGFloat)rotateIconMarginRight {
    _rotateIconMarginRight = rotateIconMarginRight;
    [self.arrowMark setFrame:CGRectMake(self.mainBtn.bounds.size.width -rotateIconMarginRight -self.rotateIconSize.width, (self.mainBtn.bounds.size.height -self.rotateIconSize.height)/2, self.rotateIconSize.width, self.rotateIconSize.height)];
}
- (void)setRotateIconTint:(UIColor *)rotateIconTint {
    _rotateIconTint = rotateIconTint;
    self.arrowMark.tintColor = rotateIconTint;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self.mainBtn setTitle:title forState:UIControlStateNormal];
}
- (void)setTitleBgColor:(UIColor *)titleBgColor{
    _titleBgColor = titleBgColor;
    [self.mainBtn setBackgroundColor:titleBgColor];
    [self.arrowMark setBackgroundColor:titleBgColor];
}
- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    self.mainBtn.titleLabel.font = titleFont;
}
- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self.mainBtn setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)setTitleAlignment:(NSTextAlignment)titleAlignment{
    _titleAlignment = titleAlignment;
    if (titleAlignment == NSTextAlignmentLeft) {
        self.mainBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    } else if (titleAlignment == NSTextAlignmentCenter) {
        self.mainBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    } else if (titleAlignment == NSTextAlignmentRight) {
        self.mainBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
}
- (void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets{
    _titleEdgeInsets = titleEdgeInsets;
    self.mainBtn.titleEdgeInsets = titleEdgeInsets;
}

- (void)setShowsVerticalScrollIndicatorOfOptionsList:(BOOL)showsVerticalScrollIndicatorOfOptionsList {
    _optionsList.showsVerticalScrollIndicator = showsVerticalScrollIndicatorOfOptionsList;
}

@end




