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
    OSCApiObjSignIn *param = [OSCApiObjSignIn new];
    param.email = @"youremail";
    param.password = @"yourpassword";
    [[param apiRequest] startWithCompletionBlock:^(CNRequest * _Nonnull request, id  _Nonnull data, NSError * _Nonnull error) {
        
    }];
}

@end
