# DPSharePopView
仿QQ空间的弹出视图



![image](https://github.com/dongpeng66/DPSharePopView/blob/master/example.gif)

</br>

#我感觉QQ空间的点击按钮根据点击的位置自适应视图是在上方还是下方的效果的用户体验比较好，就自己尝试做一下


#usage</br>
#把DPSharePopView文件导入项目中</br>
DPSharePopView *view=[DPSharePopView initWithSuperView:btn menuCellNameArray:@[@"QQ好友",@"QQ空间",@"微信好友",@"微信朋友圈"]       imageNameArray:@[@"share_qq_friend",@"share_qq_kongjian",@"share_wx_friend",@"share_wx_pengyouquan"] cellDidClickBlock:^(NSInteger index) {</br>
        
}];</br>
[view show];</br>
#此处的btn即为参考的视图
