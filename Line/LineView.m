//
//  LineView.m
//  Line
//
//  Created by liqunfei on 16/4/20.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "LineView.h"
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation LineView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        xWidth = self.bounds.size.width / 7;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawLine];
    [self drawCoordinate];
}

- (void)drawCoordinate {
    CGContextRef currentCtx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentCtx, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(currentCtx, 0.5f);
    CGPoint points[] = {CGPointMake(20, 0),CGPointMake(20, self.bounds.size.height - 20),CGPointMake(self.bounds.size.width, self.bounds.size.height - 20)};
    CGContextAddLines(currentCtx, points, 3);
    CGContextStrokePath(currentCtx);
    
}

- (void)nslog {
    NSLog(@"%@",self.dataArray);
}

- (CGPoint)getPointWithPoint:(CGPoint)point {
    return  CGPointMake(20 + point.x * xWidth, self.bounds.size.height - 30 - point.y * 20);
}

- (void)drawLine {
  
    CGPoint points[20] = {0};
    for (int i = 0; i < self.dataArray.count; i++) {
        points[i] = [self getPointWithPoint:[self.dataArray[i] CGPointValue]];
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.dataArray.count; i++) {
        if (i == 0) {
            [path moveToPoint:points[0]];
        }
        else {
            [path addLineToPoint:points[i]];
        }
    }
    [self setXAndYValue];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 0.5f;
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = nil;
    [self.layer addSublayer:shapeLayer];
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    baseAnimation.duration = 1.0;
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    baseAnimation.fromValue = @0.0;
    baseAnimation.toValue = @1.0;
    [shapeLayer addAnimation:baseAnimation forKey:@"strokeEndAnimation"];
}

- (void)setXAndYValue {
    
    //单位
    UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 200, 20)];
    baseLabel.font = [UIFont systemFontOfSize:11.0f];
    baseLabel.text = @"单位:万分之一(‱)";
    baseLabel.textColor = RGBA(171, 171, 171, 1.0);
    baseLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:baseLabel];
    
    //x
    NSArray *arr = [self getTodayAndTommorrowDay:[NSDate date]];
    for (int i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, xWidth, 20);
        label.center = CGPointMake((6 - i) * xWidth + 20, 190);
        label.font = [UIFont systemFontOfSize:12.0];
        label.textColor = RGBA(171, 171, 171, 1.0);
        label.text = arr[i];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20 + xWidth * i, 175,0.5, 5)];
        view.backgroundColor = RGBA(171, 171, 171, 1.0);
        [self addSubview:view];
    }
    
    //y
    for (int i = 0; i < 8; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, 20, 20);
        label.center = CGPointMake(10, self.bounds.size.height - 30 - 20 * i);
        label.font = [UIFont systemFontOfSize:12.0];
        label.textColor = RGBA(171, 171, 171, 1.0);
        label.textAlignment = NSTextAlignmentCenter;
        label.contentMode = UIViewContentModeCenter;
        label.text = [NSString stringWithFormat:@"%d",i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, self.bounds.size.height - 30 - 20 * i, 5,0.5)];
        view.backgroundColor = RGBA(171, 171, 171, 1.0);
        [self addSubview:view];
        [self addSubview:label];
    }
}

- (NSMutableArray *)getTodayAndTommorrowDay:(NSDate *)aDate {
    NSMutableArray *returnArr = [NSMutableArray array];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *componets = [gregorian components:NSWeekCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:aDate];
    NSDateFormatter *dateDay = [[NSDateFormatter alloc] init];
    [dateDay setDateFormat:@"MM-dd"];
    for (int i = 1; i < 8; i++) {
        [componets setDay:([componets day] - 1)];
        NSDate *mydate = [gregorian dateFromComponents:componets];
        [returnArr addObject:[dateDay stringFromDate:mydate]];
    }
    return returnArr;
}

@end
