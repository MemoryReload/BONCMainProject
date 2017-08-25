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
    id<BONCHTTPRequestServiceProtocol> httpService=[[BONCCore shareInstance]createService:@protocol(BONCHTTPRequestServiceProtocol)];
    [httpService sendGETReqeustWithURL:@"https://qixin.bonc.com.cn/qixin/oauth/authorize.do?response_type=code&appId=client&secrityId=client" parameters:nil progress:^(NSProgress* progress){
        NSLog(@"\nprogress:%@\ntotalCount:%lld\ncompletedCount:%lld\nfraction:%g",progress.localizedDescription,progress.totalUnitCount,progress.completedUnitCount,progress.fractionCompleted);
    }success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@">>>>responseObject: %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        NSLog(@">>>>error: %@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
