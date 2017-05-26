//
//  TableViewCell.m
//  DPSharePopView
//
//  Created by dp on 17/5/26.
//  Copyright © 2017年 dp. All rights reserved.
//

#import "TableViewCell.h"
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
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//230
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _downButton=[[UIButton alloc]initWithFrame:CGRectMake(DPSCREEN_WIDTH-40, 12,18, 18)];
        [_downButton setImage:[UIImage imageNamed:@"zhaoyun-71"] forState:UIControlStateNormal];
        [self.contentView addSubview:_downButton];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 30, DPSCREEN_WIDTH, 200)];
        imageView.image=[UIImage imageNamed:@"timg"];
        [self.contentView addSubview:imageView];
        
        
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
