//
//  ViewController.m
//  Example
//
//  Created by Heping on 2017/8/3.
//  Copyright © 2017年 BONC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)changeBackGroundWithColor:(UIColor*)color
{
    self.view.backgroundColor=color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
