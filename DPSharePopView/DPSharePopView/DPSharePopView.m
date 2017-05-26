//
//  DPSharePopView.m
//  DPSharePopView
//
//  Created by dp on 17/5/26.
//  Copyright © 2017年 dp. All rights reserved.
//
static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define DPRGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define DPSCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define DPSCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define DPSCREEN_BOUNDS         [UIScreen mainScreen].bounds
#define DPAdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define DPAdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
//适配iOS10字体变大的缘故
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0)? (YES):(NO))

#define DPAdapationLabelFont(n) (IOS_VERSION_10_OR_LATER?((n-1)*([[UIScreen mainScreen]bounds].size.width/375.0f)):(n*([[UIScreen mainScreen]bounds].size.width/375.0f)))
#import "DPSharePopView.h"
#import "TriangleView.h"
@interface DPSharePopView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) DPSharePopViewCellDidClickBlock cellDidClickBlock;
@property (nonatomic,strong) UIButton *maskView;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *nameArray;
@property (nonatomic,strong) NSArray *imageNameArray;

@property (nonatomic,strong) UIView *superView;

@property (nonatomic,strong) TriangleView *topTriangleView;
@property (nonatomic,strong) TriangleView *bottomTriangleView;

@property (nonatomic,strong) UIView *myView;
@end

@implementation DPSharePopView
-(UIButton *)maskView{
    if (_maskView==nil) {
        _maskView = [UIButton buttonWithType:UIButtonTypeCustom];
        _maskView.frame = [UIScreen mainScreen].bounds;
        _maskView.backgroundColor = [UIColor blackColor];
        [_maskView addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskView;
}
-(UIView *)myView{
    if (_myView==nil) {
        _myView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DPSCREEN_WIDTH, 244)];
        _myView.backgroundColor=[UIColor clearColor];
    }
    return _myView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 12, DPSCREEN_WIDTH, 220) style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.layer.cornerRadius = 4.0;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.scrollEnabled=NO;
    }
    return _tableView;
}

+(instancetype)initWithSuperView:(UIView *)superView menuCellNameArray:(NSArray<NSString *> *)nameArray imageNameArray:(NSArray<NSString *>*)imageNameArray cellDidClickBlock:(DPSharePopViewCellDidClickBlock)cellDidClickBlock{
    
    return [[self alloc]initWithSuperView:superView menuCellNameArray:nameArray imageNameArray:imageNameArray cellDidClickBlock:cellDidClickBlock];
}
-(instancetype)initWithSuperView:(UIView *)superView menuCellNameArray:(NSArray<NSString *> *)nameArray imageNameArray:(NSArray<NSString *>*)imageNameArray cellDidClickBlock:(DPSharePopViewCellDidClickBlock)cellDidClickBlock{
    if (self = [super initWithFrame:DPSCREEN_BOUNDS]) {
        _cellDidClickBlock=cellDidClickBlock;
        _nameArray=[NSArray array];
        _nameArray=nameArray;
        _imageNameArray=[NSArray array];
        _imageNameArray=imageNameArray;
        _superView=superView;
        
    }
    return self;
}
-(void)show{
    [self addSubview:self.maskView];

    [self layoutBottomSubViews];
    [self animationWithView:self duration:0.3];
    
    self.maskView.alpha= 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 0.5;
    }];
    
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
    
    
}
-(void)hiddenView{
    [self.maskView removeFromSuperview];
    [self removeFromSuperview];
    
    
}
#pragma mark-添加底部视图的子视图
-(void)layoutBottomSubViews{
    
    [self addSubview:self.myView];
    
    
    if (_nameArray.count>=1) {
        
    }else{
        return;
    }
    self.tableView.frame=CGRectMake(0, 12, DPSCREEN_WIDTH, 44*_nameArray.count);
    self.myView.frame=CGRectMake(0, 0, DPSCREEN_WIDTH, 24+self.tableView.frame.size.height);
    
    _topTriangleView = [[TriangleView alloc]initWithFrame:CGRectMake(DPSCREEN_WIDTH-35, 4,8, 8)];
    _topTriangleView.transform = CGAffineTransformMakeRotation((180.0f * M_PI) / 180.0f);
    [self.myView addSubview:_topTriangleView];
    
    [self.myView addSubview:self.tableView];

    
    _bottomTriangleView = [[TriangleView alloc]initWithFrame:CGRectMake(DPSCREEN_WIDTH-35, 12+self.tableView.frame.size.height,8, 8)];
    [self.myView addSubview:_bottomTriangleView];
    
    CGRect newRect = [_superView convertRect:_superView.bounds toView:[UIApplication sharedApplication].keyWindow];
    if (CGRectGetMaxY(newRect)<=DPSCREEN_HEIGHT/2) {
        
        if (CGRectGetMinY(newRect)>=self.myView.frame.size.height+64) {
            self.myView.frame=CGRectMake(0, CGRectGetMinY(newRect)-self.myView.frame.size.height, DPSCREEN_WIDTH, self.myView.frame.size.height);
            _topTriangleView.hidden=YES;
            
            
        }else{
            self.myView.frame=CGRectMake(0, CGRectGetMaxY(newRect), DPSCREEN_WIDTH, self.myView.frame.size.height);
            _bottomTriangleView.hidden=YES;
        }
        
        
    }else{
        if ((DPSCREEN_HEIGHT-CGRectGetMaxY(newRect))>=(64+self.myView.frame.size.height)) {
            self.myView.frame=CGRectMake(0, CGRectGetMaxY(newRect), DPSCREEN_WIDTH, self.myView.frame.size.height);
            _bottomTriangleView.hidden=YES;
            
        }else{
            self.myView.frame=CGRectMake(0, CGRectGetMinY(newRect)-self.myView.frame.size.height, DPSCREEN_WIDTH, self.myView.frame.size.height);
            _topTriangleView.hidden=YES;
        }
    
    }
    
    
}
//datasource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _nameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"tableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:Identifier];
        // 点击cell的时候不要变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryNone;
    }

    cell.imageView.image=[UIImage imageNamed:[_imageNameArray objectAtIndex:indexPath.row]];
    
    cell.textLabel.text = [_nameArray objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:DPAdapationLabelFont(16)];
    cell.textLabel.textColor=[UIColor blackColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.cellDidClickBlock) {
        self.cellDidClickBlock(indexPath.row);
    }
    [self hiddenView];
}
- (void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [view.layer addAnimation:animation forKey:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
