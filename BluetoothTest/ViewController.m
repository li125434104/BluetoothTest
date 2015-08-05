//
//  ViewController.m
//  BluetoothTest
//
//  Created by LXJ on 15/8/3.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic) CBCentralManager *manager;
@property(nonatomic, strong) NSMutableArray *peripheralArray;
@property (nonatomic, strong) CBPeripheral *discoverdPeriparals;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.manager.delegate= self;
    self.peripheralArray = [NSMutableArray array];
    
}
//检查central蓝牙开启状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSString * state = nil;
    
    switch ([central state])
    {
        case CBCentralManagerStateUnsupported:
            state = @"The platform/hardware doesn't support Bluetooth Low Energy.";
            break;
        case CBCentralManagerStateUnauthorized:
            state = @"The app is not authorized to use Bluetooth Low Energy.";
            break;
        case CBCentralManagerStatePoweredOff:
            state = @"Bluetooth is currently powered off.";
            break;
        case CBCentralManagerStatePoweredOn:
            state = @"work";
            break;
        case CBCentralManagerStateUnknown:
        default:
            ;
    }
    
    NSLog(@"Central manager state: %@", state);
}

//扫描周围蓝牙设备
- (IBAction)scanClick:(UIButton *)sender {
    [self.manager scanForPeripheralsWithServices:nil options:nil];
}

//扫面到的蓝牙设备信息
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSString *str = [NSString stringWithFormat:@"Did discover peripheral. central: %@ peripheral: %@ rssi: %@, name: %@ advertisementData: %@ ", central, peripheral, RSSI, peripheral.name, advertisementData];
    NSLog(@"%@",str);
    
    if ([peripheral.name isEqualToString:@"Bracelet-8183"]) {
        self.discoverdPeriparals = peripheral;
        [self.manager stopScan];
    }
    
    
    
}
//连接蓝牙设备
- (IBAction)connectClick:(UIButton *)sender {
    NSLog(@"%@",self.discoverdPeriparals);
    
    [self.manager connectPeripheral:self.discoverdPeriparals options:nil];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Did connect to peripheral: %@", peripheral);
    peripheral.delegate = self;
    [central stopScan];
    [peripheral discoverServices:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
