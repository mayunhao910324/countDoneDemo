//
//  ViewController.m
//  countDownDemo
//
//  Created by XiaoYun on 16/3/9.
//  Copyright © 2016年 XiaoYun. All rights reserved.
//

#import "ViewController.h"
#import "VBSMSDown.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)click:(VBSMSDown *)sender {
    //开始倒计时
    [sender countDone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
