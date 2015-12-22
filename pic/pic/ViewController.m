//
//  ViewController.m
//  pic
//
//  Created by 王国栋 on 15/12/22.
//  Copyright © 2015年 xiaobai. All rights reserved.
//

#import "ViewController.h"
#import "XBScrollPlay.h"
@interface ViewController ()<XBScrollPlayItmeSelectDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XBScrollPlay * scroll = [[XBScrollPlay alloc]initWithFrame:CGRectMake(100, 20, 200, 100)];
    [self.view addSubview:scroll];
    
    NSMutableArray * arrPic = [NSMutableArray arrayWithCapacity:4];
    for (int i=1; i<=4; i++) {
        
        UIImage * ima = [UIImage imageNamed:[NSString stringWithFormat:@"%03d.jpg",i]];
        [arrPic addObject:ima];
    }
    scroll.interval=1.0f;
    scroll.delegate = self;
    scroll.pics = arrPic;
    [scroll startScroll];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)scrollPlayItmeSelected:(NSInteger)index
{
    NSLog(@"%d",index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
