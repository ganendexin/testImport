//
//  XBScrollPlay.h
//  图片轮播器
//  Created by 王国栋 on 15/12/20.
//  Copyright © 2015年 xiaobai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XBScrollPlay;
/**
 *  实现功能：根据设置的图片自动滚动，默认0.5秒。滚动到左右两端自动回滚。手动滚动时定时器不启动，停止时继续自动
 滚动。
 */

@protocol XBScrollPlayItmeSelectDelegate <NSObject>
@optional
-(void)scrollPlayItmeSelected:(NSInteger)index;

@end

@interface XBScrollPlay : UIView

@property (nonatomic,weak) id<XBScrollPlayItmeSelectDelegate> delegate;
/**
 *  滚动的图片
 */
@property (nonatomic,strong) NSMutableArray* pics;
/**
 *  滚动时间间隔
 */
@property (nonatomic,assign) CGFloat interval;

/**
 *  开始滚动
 */
-(void)startScroll;
/**
 *  停止滚动
 */
-(void)endScroll;

@end
