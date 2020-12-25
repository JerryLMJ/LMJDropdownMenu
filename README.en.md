![(logo)](https://avatars2.githubusercontent.com/u/15794032?s=460&v=4)

[简体中文](./README.md) | English                 

# LMJDropdownMenu

![podversion](https://img.shields.io/cocoapods/v/LMJDropdownMenu.svg?style=flat)
![](https://img.shields.io/cocoapods/p/LMJDropdownMenu.svg?style=flat)
![](https://img.shields.io/badge/language-oc-orange.svg)
![](https://img.shields.io/cocoapods/l/LMJDropdownMenu.svg?style=flat)

- A simple and easy to use drop-down menu control                     

🎉 Welcome to use the latest 3.0.0 version, at the same time, also please you developers found problems in using the new version, in order to help this control to be more perfect, thank you!                    


## Effect
![](https://github.com/JerryLMJ/LMJDropdownMenu/raw/master/demo1.gif)  


## Support what kinds of scenarios to use
- The 3.0.0 version already supports a variety of scenarios, including navigation bars, storyboards, UITableViewCell, etc., and displays normally regardless of whether the superview space is sufficient or not.                        
- ⚠️ If you are using the 2.x.x version, make sure that the superview that USES this control has enough space to display a drop-down list of controls.                    
         
          
## Usage
 * Use cocoapods:                     
`pod 'LMJDropdownMenu'`                  

* Manual import:                
    * Drag All files in the `LMJDropdownMenu` folder to project                
    * Import the main file：`#import "LMJDropdownMenu.h"`       
    
    
## Properties and methods
| Attribute | Description |
| --- | ---
| dataSource | dataSource proxy object
| delegate | delegate object
| --- | ---
| title | title, default 'Please Select'. When the option value is selected, it represents the currently selected option
| titleFont | titleFont
| titleColor | titleColor
| titleAlignment | title alignment
| titleEdgeInsets | title boundary inner space
| titleBgColor | title background color
| --- | ---
| rotateIcon | drop-down rotation arrow icon
| rotateIconSize | drop-down rotation arrow size
| rotateIconMarginRight | right margin of the drop-down rotation arrow, default 7.5
| rotateIconTint | drop-down rotation arrow tint
| --- | ---
| optionBgColor | option background color
| optionFont | option font
| optionTextColor | option font color
| optionTextAlignment | option text alignment
| optionTextMarginLeft | option left margin of text, default 15
| optionNumberOfLines | option number of lines of text, default 0 (multiple lines)
| optionIconSize | option icon size, default (15,15)
| optionIconMarginRight | option icon right margin, default 15
| optionLineColor | option to divide line color
| optionLineHeight | option to divide line height, default 0.5
| --- | ---
| optionsListLimitHeight | The maximum height of the drop-down list, beyond which the options can be scrolled.  default 0.（When optionsListLimitHeight <= 0, the drop-down list shows all options）
| showsVerticalScrollIndicatorOfOptionsList | Whether to display a Scroll Indicator for optionsList
| --- | ---
| animateTime | animateTime, default 0.25

| Method | Description |
| --- | ---
| - reloadOptionsData | refreshes the drop-down list data
| - showDropDown | displays drop-down list
| - hideDropDown | hide drop-down list

| Deleget Method | Optional | Description |
| --- | --- | ---
| *LMJDropdownMenuDataSource* | --- | -- -
| - numberOfOptionsInDropdownMenu: | required | for the drop-down list
| - dropdownMenu: heightForOptionAtIndex: | required | for the height of each drop-down options
| - dropdownMenu: titleForOptionAtIndex: | required | text for each drop-down options
| - dropdownMenu: iconForOptionAtIndex: | optional | optional icon for each drop-down options
| *LMJDropdownMenuDelegate* | --- | ---
| - dropdownMenuWillShow: | optional | drop-down menu will be displayed
| - dropdownMenuDidShow: | optional | drop-down menu has been displayed
| - dropdownmenuhidden: | optional | drop-down menu will be hidden
| - dropdownMenuDidHidden: | optional | drop-down menu has been hidden
| - dropdownMenu: didSelectOptionAtIndex: optionTitle: | optional | click drop-down list some options


## Update log      

- **2020.12.25 (3.0.4) ：**                 
This update adds the left margin of the option text.                            
- **2020.12.18 (3.0.3) ：**                 
This update fixes the dropdown menu splitter display issue.                         
- **2020.10.27（3.0.2）：**             
This update adds several properties: the right margin and color of the rotation arrow, the right margin of the option icon, and the height of the option divider.              
- **2020.10.22（3.0.1）：**             
This update adds a height limiting property to the list of options, as well as related Settings. When there are too many options, you can scroll through the options list to show all the options.                                               
- **2020.10.15（3.0.0）：**             
🎉 latest 3.0.0 version has support for various scenarios, including navigation, storyboard, UITableViewCell, etc, and whether the parent view space enough, can be normal !!!                 
This update reconstructs the drop-down list to accommodate the lack of space in the parent control and to meet the needs of a variety of scenarios.                   
⚠️ By 2.x.x Version upgraded to 3.0.0 version of the developers need to pay attention to: the Api interface no change, but the inside of the drop-down list display is completely different, please pay attention to in the process of replacing handling of drop-down list display space (3.0.0 version do not need to consider the question of whether a parent view space enough).                  
- **2019.12.23（2.1.0）：**                      
Fixed the use of controls in xib and storyboard.                     
Added a Demo for the use of controls in storyboard.                     
- **2019.7.1（2.0.3）：**              
This update, fix the page push process menu disappeared bug.                       
Added, when there are multiple menus on the page, it will close other menus that have been expanded when the menu is opened.                
- **2019.6.21（2.0.2）：**                  
In this update, the demo adds a way to use multiple drop-down menus for the same view, and a new demonstration of menu style Settings.                                  
Optimize the layout of drop-down options.                            
- **2019.6.5（2.0.1）：**                 
The update changed the proxy method: by ` dropdownMenu:didSelectOptionAtIndex:` change to ` dropdownMenu:didSelectOptionAtIndex:optionTitle:icon:`.                        
⚠️ please upgrade version of the proxy method users pay attention to modify the code!    
- **2019.5.26（2.0.0）：**                                      
The new 2.0 version is here! 🎉 🎉 🎉                     
This update adds the installation of cocoapods that you have been asking for, and improves the file structure of demo module as well as new Chinese and English documents.        
This update adds multiple custom style properties and changes to get the list data through the DataSource agent.                  
- **2016.8.22（1.0.0）：**                               
You can customize the style of the drop-down menu.               
You can set the option title and line height.                       
