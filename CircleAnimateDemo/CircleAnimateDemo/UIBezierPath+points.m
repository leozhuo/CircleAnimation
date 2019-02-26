//
//  UIBezierPath+points.m
//  CircleAnimateDemo
//
//  Created by HaoSheng on 2018/9/21.
//  Copyright © 2018年 qiuyu wang. All rights reserved.
//

#import "UIBezierPath+points.h"
#define VALUE(_INDEX_) [NSValue valueWithCGPoint:points[_INDEX_]]

@implementation UIBezierPath (points)


void getPointsFromBezier(void *info,const CGPathElement *element){
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPathElementType type = element->type;
    CGPoint *points = element->points;
    
    if (type != kCGPathElementCloseSubpath) {
        [bezierPoints addObject:VALUE(0)];
        if ((type != kCGPathElementAddLineToPoint) && (type != kCGPathElementMoveToPoint)) {
            [bezierPoints addObject:VALUE(1)];
        }
    }
    
    if (type == kCGPathElementAddCurveToPoint) {
        [bezierPoints addObject:VALUE(2)];
    }
    
}

- (NSArray *)points
{
    NSMutableArray *points = [NSMutableArray array];
    CGPathApply(self.CGPath, (__bridge CGPoint *)points, getPointsFromBezier);
    return points;
}

@end
