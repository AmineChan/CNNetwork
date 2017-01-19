//
//  CNNetworkManager.h
//  iEcoalAmb
//
//  Created by czm on 15/12/5.
//  Copyright © 2015年 czm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNNetwork.h"

@interface NetworkManager : NSObject <CNNetworkAgentDelegate, CNNetworkErrorSerializer>

+ (NetworkManager *)sharedInstance;

@end
