//
//  ViewController.m
//  TouchKitDemo
//
//  Created by Adusa on 15/8/27.
//  Copyright (c) 2015年 Adusa. All rights reserved.
//

#import "ViewController.h"
#import "DragView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DragView *dragView=[[DragView alloc]initWithImage:[UIImage imageNamed:@"icotrip-toyz-20.png"]];
  
    dragView.frame=CGRectMake(0, 50, 400, 300);
    [self.view addSubview:dragView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
