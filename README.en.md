![(logo)](https://avatars2.githubusercontent.com/u/15794032?s=460&v=4)

[简体中文](./README.md) | English                 

# LMJDropdownMenu

![podversion](https://img.shields.io/cocoapods/v/LMJDropdownMenu.svg?style=flat)
![](https://img.shields.io/cocoapods/p/LMJDropdownMenu.svg?style=flat)
![](https://img.shields.io/badge/language-oc-orange.svg)
![](https://img.shields.io/cocoapods/l/LMJDropdownMenu.svg?style=flat)

- A simple and easy to use drop-down menu control


## Effect
![](https://github.com/JerryLMJ/LMJDropdownMenu/raw/master/demo1.gif)  


## Support what kinds of scenarios to use
- ⚠️Make sure that the parent view that USES this control has enough space to display the control's drop-down list                      


## Usage
 * Use cocoapods:                     
`pod 'LMJDropdownMenu'`                  

* Manual import:                
    * Drag All files in the `LMJDropdownMenu` folder to project                
    * Import the main file：`#import "LMJDropdownMenu.h"`       
    
    
## Properties and methods
| Attribute | Description |
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
| --- | ---
| optionBgColor | option background color
| optionFont | option font
| optionTextColor | option font color
| optionTextAlignment | option text alignment
| optionNumberOfLines | optionNumberOfLines of text, default 0 (multiple lines)
| optionLineColor | option to divide line color
| optionIconSize | optionIconSize, default (15,15)
| --- | ---
| animateTime | animateTime, default 0.25

| Method | Description |
| --- | ---
| - reloadOptionsData | refreshes the drop-down list data
| - showDropDown | displays drop-down list
| - hideDropDown | hide drop-down list

| Deleget Method | Optional | Description |
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
- **2019.7.1 （2.0.3） ：**              
This update, fix the page push process menu disappeared bug.                       
Added, when there are multiple menus on the page, it will close other menus that have been expanded when the menu is opened.                

- **2019.6.21 （2.0.2）：**                  
In this update, the demo adds a way to use multiple drop-down menus for the same view, and a new demonstration of menu style Settings.                                  
Optimize the layout of drop-down options.                            

- **2019.6.5 （2.0.1）：**                 
The update changed the proxy method: by ` dropdownMenu:didSelectOptionAtIndex:` change to ` dropdownMenu:didSelectOptionAtIndex:optionTitle:icon:`.                        
⚠️please upgrade version of the proxy method users pay attention to modify the code!    
                
- **2019.5.26（2.0.0）：**                                      
The new 2.0 version is here! 🎉 🎉 🎉                     
This update adds the installation of cocoapods that you have been asking for, and improves the file structure of demo module as well as new Chinese and English documents.        
This update adds multiple custom style properties and changes to get the list data through the DataSource agent.                  
          
- **2016.8.22（1.0.0）：**                               
You can customize the style of the drop-down menu.               
You can set the option title and line height.                       
