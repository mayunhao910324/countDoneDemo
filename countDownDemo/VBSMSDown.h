//
//  VBSMSDown.h
//  loadingView
//
//  Created by XiaoYun on 16/3/8.
//  Copyright © 2016年 XiaoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBSMSDown : UIButton
/**
 *  标题
 */
@property(nonatomic,copy)NSString *title;//defaulr 发送验证码
/**
 *  末尾字符串
 */
@property(nonatomic,copy)NSString *lastString;//default s后重发
/**
 *  加载中文字
 */
@property(nonatomic,copy)NSString *loadingTitle;//default 发送中


/**
 *  开始loading
 */
-(void)startLoading;
-(void)countDone;
/**
 *  刷新状态
 */
-(void)changeStatus;
/**
 *  停止动画
 */
-(void)stop;

-(instancetype)initWithFrame:(CGRect)frame;

-(instancetype)init;

@end
