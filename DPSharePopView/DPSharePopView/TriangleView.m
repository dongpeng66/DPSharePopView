//
//  TriangleView.m
//  DPSharePopView
//
//  Created by dp on 17/5/26.
//  Copyright © 2017年 dp. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawRect:self.frame];

        self.backgroundColor=[UIColor clearColor];
        
        
    }
    return self;
}
-(void)drawRect:(CGRect)rect

{
    
    //设置背景颜色
    
    [[UIColor clearColor]set];
    
    UIRectFill(rect);
    
    //拿到当前视图准备好的画板
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    
    CGContextMoveToPoint(context,0, 0);//设置起点
    
    CGContextAddLineToPoint(context,8, 0);
    
    CGContextAddLineToPoint(context,4, 8);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [ [UIColor whiteColor] setFill]; //设置填充色
    
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,kCGPathFillStroke);//绘制路径path
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
