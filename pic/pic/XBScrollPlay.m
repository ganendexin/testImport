//
//  XBScrollPlay.m
//  我的乐校
//
//  Created by 小白 on 15/12/20.
//  Copyright © 2015年 xiaobai. All rights reserved.
//

#import "XBScrollPlay.h"
#import <UIKit/UIKit.h>
@interface XBScrollPlay ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView* scrollView;//滚动视图；
@property (nonatomic,strong) UIPageControl* pageCtrl;//滚动视图
@property (nonatomic,strong) NSMutableArray* scrollArr;
@property (nonatomic,strong) NSTimer* timer;
@end
@implementation XBScrollPlay

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.interval=0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
        
        [tap addTarget:self action:@selector(click)];
        
        tap.numberOfTapsRequired=1;
        
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void) click
{
    if ([self.delegate respondsToSelector:@selector(scrollPlayItmeSelected:)]) {
        
        [self.delegate scrollPlayItmeSelected:self.pageCtrl.currentPage];
    }
}
/**
重写Pics的set方法
 */
- (void)setPics:(NSMutableArray *)pics
{
    
    _pics = [NSMutableArray arrayWithArray:pics];
    
    [_pics insertObject:[pics lastObject] atIndex:0];
    
    [_pics addObject:pics[0]];
    
    //1.添加scrollView
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.frame =self.bounds;
    self.scrollView.delegate=self;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.pagingEnabled=YES;
    for (int i=0; i<self.pics.count; i++) {
        UIImageView * imaV = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width,self.frame.size.height)];
        imaV.tag=i+1;
        imaV.contentMode=UIViewContentModeScaleToFill;
        imaV.image =(UIImage*)self.pics[i];
        [self.scrollView addSubview:imaV];
    }
    self.scrollView.contentSize =CGSizeMake(self.frame.size.width*_pics.count, 0) ;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
    [self addSubview:self.scrollView];
    
    
    //2.添加pageControl
    CGFloat pW = 50;
    CGFloat pH = 30;
    CGFloat pX = (self.frame.size.width-pW)/2;
    CGFloat pY = (self.frame.size.height-pH);
    self.pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(pX,pY,pW,pH)];
    self.pageCtrl.numberOfPages=self.pics.count-2;
    self.pageCtrl.currentPage=0;
    self.pageCtrl.pageIndicatorTintColor=[UIColor blueColor];
    self.pageCtrl.currentPageIndicatorTintColor=[UIColor redColor];
    [self addSubview:self.pageCtrl];
    
}
- (void)startScroll
{
    if (self.timer == nil && self.pics.count>1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(scrollPic) userInfo:nil repeats:YES];
        // 获取当前的消息循环对象
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        // 改变self.timer对象的优先级
        [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
- (void)scrollPic
{
    NSInteger page = self.pageCtrl.currentPage;
    
    CGFloat offsetX ;
    if (page == self.pics.count - 3) {
        page = 0;
    } else{
        page++;
    }
    offsetX = (1+page)*self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
-(void)endScroll;
{
    [self.timer invalidate];
    self.timer=nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // 如何计算当前滚动到了第几页？
    // 1. 获取滚动的x方向的偏移值
    CGFloat offsetX = scrollView.contentOffset.x;
    // 用已经偏移了得值, 加上半页的宽度
    offsetX = offsetX + (scrollView.frame.size.width * 0.5);
    // 2. 用x方向的偏移的值除以一张图片的宽度(每一页的宽度)，取商就是当前滚动到了第几页（索引）
    int page = offsetX / scrollView.frame.size.width;
    // 3. 将页码设置给UIPageControl
    if (page == self.pics.count-1) {
        self.pageCtrl.currentPage = 0;
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
    }
    else if(page ==0)
    {
        self.pageCtrl.currentPage = self.pics.count-3;
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*(self.pageCtrl.currentPage+1), 0)];
    }
    else
    {
        self.pageCtrl.currentPage=page-1;
    }
}
// 实现即将开始拖拽的时候就停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endScroll];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startScroll];
}
@end
