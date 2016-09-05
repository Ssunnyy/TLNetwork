//
//  ViewController.m
//  NetwrokDemo
//
//  Created by Ted Liu on 16/5/4.
//  Copyright © 2016年 Ted Liu. All rights reserved.
//

#import "ViewController.h"
#import "TLNetwrok.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)actionTouchTest:(id)sender {
    
    [[TLAsiNetworkHandler sharedInstance] requestURL:@"http://192.168.1.124:8080/BuildCloud/api/user/profile/1/password?" networkType:TLAsiNetWorkPATCH params:@{@"password":@"123454",@"code":@"23"} delegate:nil showHUD:YES successBlock:^(NSDictionary *returnData) {
        
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
