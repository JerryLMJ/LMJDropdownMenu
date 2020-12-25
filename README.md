![(logo)](https://avatars2.githubusercontent.com/u/15794032?s=460&v=4)

简体中文 | [English](./README.en.md)             

# LMJDropdownMenu

![podversion](https://img.shields.io/cocoapods/v/LMJDropdownMenu.svg?style=flat)
![](https://img.shields.io/cocoapods/p/LMJDropdownMenu.svg?style=flat)
![](https://img.shields.io/badge/language-oc-orange.svg)
![](https://img.shields.io/cocoapods/l/LMJDropdownMenu.svg?style=flat)

- 一个简单好用的下拉菜单控件                           

🎉 欢迎大家使用最新的3.0.0版本，同时也恳请各位开发者提供在使用新版本中发现的问题，以帮助此控件更加完善，抱拳！                     
     
      
## 效果                              
![](https://github.com/JerryLMJ/LMJDropdownMenu/raw/master/demo1.gif)        


## 使用场景
- 3.0 版本已经支持各种场景，包括导航栏、storyboard、UITableViewCell等，并且无论父视图空间是否足够都可以正常显示                     
- ⚠️ 如果你使用的是 2.x.x 版本，请确保使用此控件的父视图有足够空间展示控件的下拉列表


## 使用
* 使用cocoapods安装：               
`pod 'LMJDropdownMenu'`
* 手动导入:             
    * 将 `LMJDropdownMenu` 文件拖拽到工程中
    * 导入头文件`#import "LMJDropdownMenu.h"`
    
    
## 属性及方法
| 属性 | 描述 |
| --- | ---
| dataSource | 数据源代理对象
| delegate | 代理对象
| --- | ---
| title | 标题，默认‘Please Select’。选择选项值后，表示当前选择的选项
| titleFont | 标题字体
| titleColor | 标题颜色
| titleAlignment | 标题对齐
| titleEdgeInsets | 标题边界内距
| titleBgColor | 标题背景颜色
| --- | ---
| rotateIcon | 下拉旋转箭头图标
| rotateIconSize | 下拉旋转箭头大小
| rotateIconMarginRight | 下拉旋转箭头右侧边距，默认7.5
| rotateIconTint | 下拉旋转箭头颜色
| --- | ---
| optionBgColor | 选项背景颜色
| optionFont | 选项字体
| optionTextColor | 选项字体颜色
| optionTextAlignment | 选项文字对齐
| optionTextMarginLeft | 选项文字左侧边距，默认15
| optionNumberOfLines | 选项文字行数，默认0（多行）
| optionIconSize | 选项图标大小，默认(15,15)
| optionIconMarginRight | 选项图标右侧边距，默认15
| optionLineColor | 选项分割线颜色
| optionLineHeight | 选项分割线粗细，默认0.5
| --- | ---
| optionsListLimitHeight | 选项列表的最大高度。超出最大高度后，选项可滚动。默认0 （当optionsListLimitHeight <= 0 时，下拉列表将显示所有选项）
| showsVerticalScrollIndicatorOfOptionsList | 是否展示选项列表的纵向滑块
| --- | ---
| animateTime | 下拉动画时间， 默认0.25

| 方法 | 描述 |
| --- | ---
| - reloadOptionsData | 刷新下拉列表数据
| - showDropDown | 显示下拉列表
| - hideDropDown | 隐藏下拉列表


| 代理方法 | 是否必选 | 描述 |
| --- | --- | ---
| *LMJDropdownMenuDataSource* | --- | ---
| - numberOfOptionsInDropdownMenu: | 必选 | 获取下拉列表选项个数
| - dropdownMenu:heightForOptionAtIndex: | 必选 | 获取每个下拉选项的高度
| - dropdownMenu:titleForOptionAtIndex: | 必选 | 获取每个下拉选项的文字
| - dropdownMenu:iconForOptionAtIndex: | 可选 | 获取每个下拉选项的图标
| *LMJDropdownMenuDelegate* | --- | ---
| - dropdownMenuWillShow: | 可选 | 下拉菜单将要显示
| - dropdownMenuDidShow: | 可选 | 下拉菜单已经显示
| - dropdownMenuWillHidden: | 可选 | 下拉菜单将要隐藏
| - dropdownMenuDidHidden: | 可选 | 下拉菜单已经隐藏
| - dropdownMenu:didSelectOptionAtIndex:optionTitle: | 可选 | 点击下拉列表某个选项


## 更新日志

- **2020.12.25（3.0.4）：**                                                                     
本次更新添加选项文字左侧边距。                        
- **2020.12.18（3.0.3）：**                                                                     
本次更新修复下拉菜单分割线展示问题。                                        
- **2020.10.27（3.0.2）：**                                                                     
本次更新增加了多个属性：旋转箭头的右侧边距和颜色、选项图标的右侧边距、选项分割线的高度。                       
- **2020.10.22（3.0.1）：**                                                                     
本次更新增加选项列表的高度限制属性，以及相关设置。当选项过多时，可通过滚动选项列表展示所有选项。                      
- **2020.10.15（3.0.0）：**                                                                    
🎉 最新的 3.0.0 版本已经支持各种场景，包括导航栏、storyboard、UITableViewCell等，并且无论父视图空间是否足够，都可正常显示！！！             
本次更新重构下拉列表以适配父控件空间不足的情况，并满足多种场景的使用需求。                                           
⚠️ 由 2.x.x 版本升级为 3.0.0 版本的同学需要注意：Api接口无变化，但下拉列表内部的展示方式已经完全不同，请注意替换过程中对下拉列表展示空间的处理（3.0.0版本无需考虑父视图空间是否足够的问题）。                     
- **2019.12.23（2.1.0）：**                                                                    
修复控件在xib和storyboard中的使用。                       
增加了控件在storyboard中使用的演示Demo。                 
- **2019.7.1（2.0.3）：**                                                                    
本次更新，修复页面跳转过程中菜单消失的bug。                       
增加了，当页面上有多个菜单时，打开菜单的时候会关闭其他已经展开的菜单。                    
- **2019.6.21（2.0.2）：**                                                            
本次更新，在demo中增加了同一个视图存在多个下拉菜单的使用方法，并且增加新的菜单样式设置演示。                
优化下拉选项的布局效果。                          
- **2019.6.5（2.0.1）：**                                                     
本次更新修改了代理方法：由 `dropdownMenu:didSelectOptionAtIndex:`变更为 `dropdownMenu:didSelectOptionAtIndex:optionTitle:icon:`。                     
⚠️ 请升级版本的同学注意修改代码中的代理方法！                        
- **2019.5.26（2.0.0）：**                                          
全新的2.0版本来啦！🎉🎉🎉               
本次更新增加了大家一直要求的cocoapods安装，并完善了demo模块的文件结构以及全新的中英文文档。         
本次更新增加多个自定义样式属性，并改为通过DataSource代理获取列表数据。              
- **2016.8.22（1.0.0）：**                               
可以自定义下拉菜单的样式。                        
可以设置选项标题和行高。                                        
