//
//  ViewController.m
//  LMJDropdownMenuExample
//
//  Created by LiMingjie on 2019/5/24.
//  Copyright © 2019 LMJ. All rights reserved.
//

#import "ViewController.h"
#import "Demo-BaseVC.h"
#import "Demo-StoryboardVC.h"
#import "Demo-TableViewCellVC.h"
#import "Demo-LayoutByMasonryVC.h"

@interface ViewController ()
@end

@implementation ViewController
- (IBAction)clickDemoAddToBasePage:(id)sender {
    Demo_BaseVC *baseVC = [[Demo_BaseVC alloc] init];
    [self.navigationController pushViewController:baseVC animated:YES];
}

- (IBAction)clickDemoAddToXibPage:(id)sender {
    Demo_StoryboardVC * vc = [[UIStoryboard storyboardWithName:@"Demo" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Demo_StoryboardVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)clickDemoAddToTableViewCell:(id)sender {
    Demo_TableViewCellVC *vc = [[UIStoryboard storyboardWithName:@"Demo_TableView" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Demo_TableViewCellVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)clickDemoLayoutByMasonry:(id)sender {
    Demo_LayoutByMasonryVC *vc = [[Demo_LayoutByMasonryVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
