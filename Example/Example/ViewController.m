//
//  ViewController.m
//  Example
//
//  Created by czm on 15/11/15.
//  Copyright © 2015年 czm. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
#import "CNNetworkAgent.h"
#import <Api/OSCAuthApi.h>

@interface ViewController ()
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NetworkManager *networkManager;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onLoginBtnClick:(UIButton *)sender
{
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://pre.im/app/553d5ee930823445cd79709793df529f"]];
//
//    CNRequestApi *api = [[CNRequestApi alloc] init];
//    api.requestAsssistant.customUrlRequest = request;
//    [api startWithCompletionBlock:^(CNRequestApi *requestApi, id data, NSError *error) {
//        
//        ResultData *resultData = data;
//        NSString *str = [[NSString alloc] initWithData:resultData.originData encoding:NSUTF8StringEncoding];
//
//        NSLog(@"%@", str);
//    }];
//    return;
    
    OSCApiObjSignIn *param = [OSCApiObjSignIn new];
    param.email = @"youremail";
    param.password = @"yourpassword";
    [[param apiRequest] startWithCompletionBlock:^(CNRequest * _Nonnull request, id  _Nonnull data, NSError * _Nonnull error) {
        
    }];
}

@end
