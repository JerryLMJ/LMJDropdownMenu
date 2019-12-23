//
//  LMJDropdownMenu.m
//
//  Created by JerryLMJ on 15/5/4.
//  Copyright (c) 2015年 LMJ. All rights reserved.
//

#import "LMJDropdownMenu.h"

@interface LMJDropdownMenu() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView      * bgView;
@property (nonatomic, strong) UIButton    * mainBtn;
@property (nonatomic, strong) UIImageView * arrowMark;   // 尖头图标
@property (nonatomic, strong) UITableView * optionsList;   // 下拉列表

@property (nonatomic, assign) NSLayoutConstraint * hConstraint;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> * bConstraints;

@end



@implementation LMJDropdownMenu
{
    CGFloat _originHeight;
    CGFloat _listHeight;
    NSMutableArray * _cellHeights;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initPropertys];
        [self initViews];
        [self setFrame:self.frame];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    _bConstraints = [NSMutableArray array];
    [self initPropertys];
    [self initViews];
    [self setFrame:self.frame];
}

-(void)layoutSubviews {
    NSArray *constraints = self.constraints;
    for(NSLayoutConstraint *constraint in constraints){
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            _hConstraint = constraint;
        }

    }
    constraints = self.superview.constraints;
    [_bConstraints removeAllObjects];
    for (NSLayoutConstraint *constraint in constraints) {
        if (constraint.secondItem == self && constraint.secondAttribute == NSLayoutAttributeBottom) {
            [_bConstraints addObject:constraint];
        }
    }
}


- (void)initPropertys{
    _originHeight        = 0;

    _title               = @"Please Select";
    _titleBgColor        = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    _titleFont           = [UIFont boldSystemFontOfSize:15];
    _titleColor          = [UIColor whiteColor];
    _titleAlignment      = NSTextAlignmentLeft;
    _titleEdgeInsets     = UIEdgeInsetsMake(0, 10, 0, 10);

    _rotateIcon          = nil;
    _rotateIconSize      = CGSizeMake(15, 15);

    _optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    _optionFont          = [UIFont systemFontOfSize:13];
    _optionTextColor     = [UIColor blackColor];
    _optionTextAlignment = NSTextAlignmentCenter;
    _optionNumberOfLines = 0;
    _optionLineColor     = [UIColor whiteColor];
    _optionIconSize      = CGSizeMake(0, 0);

    _animateTime         = 0.25f;
}

- (void)initViews{
    self.layer.masksToBounds = YES;
    
    // 主按钮 显示在界面上的点击按钮
    _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mainBtn addTarget:self action:@selector(clickMainBtn:) forControlEvents:UIControlEventTouchUpInside];
    _mainBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _mainBtn.titleEdgeInsets            = UIEdgeInsetsMake(0, 15, 0, 0);
    _mainBtn.selected                   = NO;
    [self addSubview:_mainBtn];
    
    // 旋转尖头
    _arrowMark = [[UIImageView alloc] init];
    [_mainBtn addSubview:_arrowMark];
    
    
    // 下拉列表TableView
    _optionsList = [[UITableView alloc] init];
    _optionsList.delegate       = self;
    _optionsList.dataSource     = self;
    _optionsList.separatorStyle = UITableViewCellSeparatorStyleNone;
    _optionsList.bounces        = NO;
    [self addSubview:_optionsList];
}


#pragma mark - Set Methods
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (_originHeight == 0) {
        _originHeight = frame.size.height;
    }
    [_mainBtn setFrame:CGRectMake(0, 0, self.frame.size.width, _originHeight)];
    [_arrowMark setFrame:CGRectMake(self.frame.size.width -7.5-self.rotateIconSize.width, (_originHeight -self.rotateIconSize.height)/2, self.rotateIconSize.width, self.rotateIconSize.height)];
    [_optionsList setFrame:CGRectMake(0, _originHeight, self.frame.size.width, 0)];
}

- (void)setRotateIcon:(UIImage *)rotateIcon{
    _rotateIcon = rotateIcon;
    [self.arrowMark setImage:rotateIcon];
}
- (void)setRotateIconSize:(CGSize)rotateIconSize{
    _rotateIconSize = rotateIconSize;
    [_arrowMark setFrame:CGRectMake(self.frame.size.width -7.5-rotateIconSize.width, (_originHeight -rotateIconSize.height)/2, rotateIconSize.width, rotateIconSize.height)];
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



#pragma mark - Methods
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

- (void)showDropDown{   // 显示下拉列表
    for (UIView * view in self.superview.subviews) {
        if ([view isKindOfClass:[LMJDropdownMenu class]]) {
            if (view != self) {
                [(LMJDropdownMenu *)view hideDropDown];
            }
        }
    }
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillShow:)]) {
        [self.delegate dropdownMenuWillShow:self]; // 将要显示回调代理
    }
    NSUInteger count = [self.dataSource numberOfOptionsInDropdownMenu:self];
    _cellHeights = [NSMutableArray arrayWithCapacity:count];
    _listHeight = 0;
    for (int i = 0; i < count; i++) {
        CGFloat cHeight = [self.dataSource dropdownMenu:self heightForOptionAtIndex:i];
        [_cellHeights addObject:@(cHeight)];
        _listHeight += cHeight;
    }
    __weak typeof(self) weakSelf = self;
    if(_hConstraint) {
        _hConstraint.constant = _originHeight + _listHeight;
    }
    if (_bConstraints.count > 0) {
        for (NSLayoutConstraint * constraint in _bConstraints) {
            constraint.constant = constraint.constant -_listHeight;
        }
    }
    [UIView animateWithDuration:self.animateTime animations:^{
        if (self->_hConstraint || self->_bConstraints.count > 0) {
            [self.superview layoutIfNeeded];
        } else {
            weakSelf.frame  = CGRectMake(weakSelf.frame.origin.x, weakSelf.frame.origin.y, weakSelf.frame.size.width, self->_originHeight + self->_listHeight);
        }
        weakSelf.arrowMark.transform = CGAffineTransformMakeRotation(M_PI);
        weakSelf.optionsList.frame = CGRectMake(0, self->_originHeight, self.frame.size.width, self->_listHeight);
    }completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
            [self.delegate dropdownMenuDidShow:self]; // 已经显示回调代理
        }
    }];
    
    _mainBtn.selected = YES;
}


- (void)hideDropDown{  // 隐藏下拉列表
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillHidden:)]) {
        [self.delegate dropdownMenuWillHidden:self]; // 将要隐藏回调代理
    }
    
    __weak typeof(self) weakSelf = self;
    if(_hConstraint) {
        _hConstraint.constant = _originHeight;
    }
    if (_bConstraints.count > 0) {
        for (NSLayoutConstraint * constraint in _bConstraints) {
            constraint.constant = constraint.constant +_listHeight;
        }
    }
    [UIView animateWithDuration:self.animateTime animations:^{
        weakSelf.arrowMark.transform = CGAffineTransformIdentity;
        if (self->_hConstraint || self-> _bConstraints) {
            [self.superview layoutIfNeeded];
        } else {
            weakSelf.frame  = CGRectMake(weakSelf.frame.origin.x, weakSelf.frame.origin.y, weakSelf.frame.size.width, self->_originHeight);
        }
    }completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidHidden:)]) {
            [self.delegate dropdownMenuDidHidden:self]; // 已经隐藏回调代理
        }
    }];
    
    _mainBtn.selected = NO;
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
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 0.5)];
        line.backgroundColor = self.optionLineColor;
        [cell addSubview:line];
        //---------------------------------------------------------------------------
    }
    CGFloat cHeight = [_cellHeights[indexPath.row] floatValue];
    
    UILabel * titleLabel = [cell viewWithTag:999];
    titleLabel.text = [self.dataSource dropdownMenu:self titleForOptionAtIndex:indexPath.row];;
    titleLabel.frame = CGRectMake(15, 0, self.frame.size.width - 15 -self.optionIconSize.width -15, cHeight);
    
    UIImageView * icon = [cell viewWithTag:888];
    if ([self.dataSource respondsToSelector:@selector(dropdownMenu:iconForOptionAtIndex:)]){
        icon.image =  [self.dataSource dropdownMenu:self iconForOptionAtIndex:indexPath.row];
    }
    icon.frame = CGRectMake(self.frame.size.width -7.5-self.optionIconSize.width, (cHeight - self.optionIconSize.height)/2, self.optionIconSize.width, self.optionIconSize.height);
    
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
@end
