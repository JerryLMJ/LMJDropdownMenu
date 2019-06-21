![(logo)](https://avatars2.githubusercontent.com/u/15794032?s=460&v=4)

简体中文 | [English](./README.en.md)             

# LMJDropdownMenu

![podversion](https://img.shields.io/cocoapods/v/LMJDropdownMenu.svg?style=flat)
![](https://img.shields.io/cocoapods/p/LMJDropdownMenu.svg?style=flat)
![](https://img.shields.io/badge/language-oc-orange.svg)
![](https://img.shields.io/cocoapods/l/LMJDropdownMenu.svg?style=flat)

- 一个简单好用的下拉菜单控件
       
          
## 效果                              
![](https://github.com/JerryLMJ/LMJDropdownMenu/raw/master/demo1.gif)        


## 使用场景
- ⚠️请确保使用此控件的父视图有足够的空间显示控件的下拉列表


## 使用
* 使用cocoapods安装：               
`pod 'LMJDropdownMenu'`
* 手动导入:             
    * 将 `LMJDropdownMenu` 文件拖拽到工程中
    * 导入头文件`#import "LMJDropdownMenu.h"`
    

## 更新日志
- **2019.6.21（2.0.2）：**                                                            
本次更新，在demo中增加了同一个视图存在多个下拉菜单的使用方法，并且增加新的菜单样式设置演示。                
优化下拉选项的布局效果。                          

- **2019.6.5（2.0.1）：**                                                     
本次更新修改了代理方法：由 `dropdownMenu:didSelectOptionAtIndex:`变更为 `dropdownMenu:didSelectOptionAtIndex:optionTitle:icon:`。                     
⚠️请升级版本的同学注意修改代码中的代理方法！                        

- **2019.5.26（2.0.0）：**                                          
全新的2.0版本来啦！🎉🎉🎉               
本次更新增加了大家一直要求的cocoapods安装，并完善了demo模块的文件结构以及全新的中英文文档。         
本次更新增加多个自定义样式属性，并改为通过DataSource代理获取列表数据。              

- **2016.8.22（1.0.0）：**                               
可以自定义下拉菜单的样式。                        
可以设置选项标题和行高。                                        
