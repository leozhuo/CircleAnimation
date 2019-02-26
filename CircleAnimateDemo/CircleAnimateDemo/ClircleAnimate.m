//
//  ClircleAnimate.m
//  CircleAnimateDemo
//
//  Created by qiuyu wang on 16/7/19.
//  Copyright © 2016年 qiuyu wang. All rights reserved.
//

#import "ClircleAnimate.h"
#import "UIBezierPath+points.h"
#import <Foundation/Foundation.h>

@interface ClircleAnimate()
@end

@implementation ClircleAnimate

-(void)createCircle:(float)startAngle andEndAngle:(float)endAngle
{
//    //过程中的计算，我是把屏幕是左上角作为坐标系原点来计算的
//    //控制点坐标
    CGFloat kx = [UIScreen mainScreen].bounds.size.width / 2;
    CGFloat ky = [UIScreen mainScreen].bounds.size.height * 2 / 3 * -1;
    
    //起点
    CGFloat x1 = 0.0;
    CGFloat y1 = [UIScreen mainScreen].bounds.size.height * -1;
    
    //终点
    CGFloat x3 = [UIScreen mainScreen].bounds.size.width;
    CGFloat y3 = [UIScreen mainScreen].bounds.size.height * -1;
    
    //计算顶点坐标
    CGFloat x2 = 0.5 * kx + 0.25 * x3;
    CGFloat y2 = (0.25 * -1 * y1 + 0.5 * -1 * ky + 0.25 * -1 * y3) * -1;
    
    //计算抛物线公式系数
    CGFloat a = (((y2 - y3) * x1 - (x2 - x3) * y1 + x2 * y3 - x3 * y2) / ((x2 - x3) * (x1 - x2) * (x1 - x3))) * -1;
    CGFloat b = ((y2 - y3) * x1 * x1 + x2 * x2 * y3 - x3 * x3 * y2 - (x2 * x2 - x3 * x3) * y1) / ((x2 - x3) * (x1 - x2) * (x1 - x3));
    CGFloat c = ((x2 * y3 - x3 * y2) * x1 * x1 - (x2 * x2 - x3 * x3) * x1 + (x2 * x2 * x3 - x2 * x3 * x3) * y1) / ((x2 - x3) * (x1 - x2) * (x1 - x3));
    
    /*-------------计算左边三分之一处和三分之二处的坐标--------------*/
    //算出左半边第一个点坐标
    CGFloat lx1 = [UIScreen mainScreen].bounds.size.width / 6;
    CGFloat ly1 = (a * lx1 * lx1 + b * lx1 + c);
    
    CGFloat lx2 = [UIScreen mainScreen].bounds.size.width / 3;
    CGFloat ly2 = (a * lx2 * lx2 + b * lx2 + c);
    
    NSLog(@"(%f,%f)(%f,%f)(%f,%f)",lx1,ly1,lx2,ly2,x2,y2);
    
    //左边的控制点
    CGFloat lkx = (lx2 - (0.25 * lx1) - (0.25 * x2)) * 2;
    CGFloat lky = (ly2 - (0.25 * ly1) - (0.25 * y2)) * 2;
    
    NSLog(@"%f-%f",lkx,lky);
    
    UIGraphicsBeginImageContext(self.frame.size);
    
    UIColor *color1 = [UIColor yellowColor];
    [color1 set];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 5.0;
    path1.lineCapStyle = kCGLineCapRound;
    path1.lineJoinStyle = kCGLineJoinRound;
    [path1 moveToPoint:CGPointMake(lx1,ly1 * -1)];
    [path1 addQuadCurveToPoint:CGPointMake(x2, y2 * -1) controlPoint:CGPointMake(lkx, lky * -1)];
    [path1 stroke];
    
    UIGraphicsEndImageContext();
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path1.CGPath;
    // 动画时间间隔
    animation.duration = 3.0f;
    // 重复次数为最大值
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    UIImageView * circleView1 = [[UIImageView alloc] init];
    circleView1.frame = CGRectMake(160, 130, 20, 20);
    [circleView1.layer setCornerRadius:10];
    circleView1.backgroundColor = [UIColor yellowColor];
    //设置运转的动画
    [circleView1.layer addAnimation:animation forKey:@"moveTheCircleOne"];
    [self addSubview:circleView1];
}
//贝塞尔
- (void)drawRect:(CGRect)rect {

    UIColor *color = [UIColor redColor];
    [color set];

    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path moveToPoint:CGPointMake(0,[UIScreen mainScreen].bounds.size.height)];
    [path addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) controlPoint:CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height * 2 / 3)];
    [path stroke];

}

-(void)setCircleAnimationBackgroundColor:(UIColor *)aColor
{
    self.backgroundColor = aColor;
    [self createCircle: M_PI / 6 andEndAngle:M_PI / 6 + 2 * M_PI];

}


@end
