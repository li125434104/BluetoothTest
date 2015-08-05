//
//  ViewController.h
//  BluetoothTest
//
//  Created by LXJ on 15/8/3.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>
@end

