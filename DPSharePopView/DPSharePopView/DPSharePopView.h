//
//  DPSharePopView.h
//  DPSharePopView
//
//  Created by dp on 17/5/26.
//  Copyright © 2017年 dp. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DPSharePopViewCellDidClickBlock)(NSInteger index);
@interface DPSharePopView : UIView
+(instancetype)initWithSuperView:(UIView *)superView menuCellNameArray:(NSArray<NSString *> *)nameArray imageNameArray:(NSArray<NSString *>*)imageNameArray cellDidClickBlock:(DPSharePopViewCellDidClickBlock)cellDidClickBlock;
-(void)show;
@end
