//
//  VBSMSDown.m
//  loadingView
//
//  Created by XiaoYun on 16/3/8.
//  Copyright © 2016年 XiaoYun. All rights reserved.
//

#import "VBSMSDown.h"
#import <pop/POP.h>
@interface VBSMSDown ()

#pragma mark - private
/**
 *  添加loading动画
 */
-(void)addLoading;
/**
 *  添加倒计时动画
 */
-(void)addDoneAnimation;

@end
@implementation VBSMSDown
-(void)awakeFromNib{
    [super awakeFromNib];
    _title=@"发送验证码";
    _lastString=@"s后重发";
    _loadingTitle=@"发送中";


}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _title=@"发送验证码";
        _lastString=@"s后重发";
        _loadingTitle=@"发送中";

    }
    return self;
}
-(instancetype)init{
    if (self=[super init]) {
        _title=@"发送验证码";
        _lastString=@"s后重发";
        _loadingTitle=@"发送中";

    }
    return self;
}

-(void)startLoading{
    self.enabled=NO;
    [self addLoading];
}
-(void)countDone{
    self.enabled=NO;
    [self addDoneAnimation];
}
-(void)changeStatus{
     [self setTitle:_title forState:UIControlStateNormal];
 
}
-(void)stop{
    [self setTitle:_title forState:UIControlStateNormal];
    self.enabled=YES;
    [self pop_removeAllAnimations];
}
-(void)setTitle:(NSString *)title{
    _title=title;
    if (_title &&_title.length>0) {
          [self setTitle:_title forState:UIControlStateNormal];
    }
}
-(void)setLastString:(NSString *)lastString{
    _lastString=lastString;
}
-(void)setLoadingTitle:(NSString *)loadingTitle{
    _loadingTitle=loadingTitle;
}
-(void)addLoading{

    POPBasicAnimation *anim = [POPBasicAnimation animation];
    anim.duration = 3;
    anim.repeatCount=CGFLOAT_MAX;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"loading" initializer:^(POPMutableAnimatableProperty *prop) { prop.readBlock = ^(id obj, CGFloat values[]) {
        values[0] = [[obj description] floatValue];
        
  //      NSLog(@"TWXT:%@",((UILabel*)obj).text

    };
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
                   //     NSLog(@"value:%d",(int)values[0]%3);
            NSLog(@"loading:%@",_loadingTitle);
                        int value =(int)values[0]%3;
                        NSString *title;
                        if (value==0) {
                            title=[NSString stringWithFormat:@"%@.",_loadingTitle];
                            //title=@"发送中.";
                        }else if (value==1){
                            //title=@"发送中..";
                            title=[NSString stringWithFormat:@"%@..",_loadingTitle];
                        }else if(value==2){
                         //   title=@"发送中...";
                             title=[NSString stringWithFormat:@"%@...",_loadingTitle];
                        }
                        [obj setTitle:title forState:UIControlStateNormal];
            
        };
        prop.threshold = 0.0;}];
    anim.property = prop;
    anim.fromValue = @(0);
    anim.toValue = @(3);
    anim.beginTime = CACurrentMediaTime();    //延迟0秒开始
  //  anim.delegate=self;
    [self pop_addAnimation:anim forKey:@"loading"];
}
-(void)addDoneAnimation{
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj,const CGFloat values[])
        {
            
            NSLog(@"%d",(int)values[0]);
            NSString *timestring = [NSString stringWithFormat:@"%02d秒后重新发送",(int)values[0]%60];
            [obj setTitle:timestring forState:UIControlStateNormal];
        };
        prop.threshold=1;
    }];
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(1*60);   //从0开始
    anBasic.toValue = @(0);  //180秒
    anBasic.duration = 1*60;    //持续3分钟
    anBasic.beginTime = CACurrentMediaTime();    //延迟1秒开始
    [self pop_addAnimation:anBasic forKey:@"countdown"];
    anBasic.completionBlock=^(POPAnimation *pop,BOOL fiish){
        self.enabled=YES;
        [self setTitle:_title forState:UIControlStateNormal];
    };

    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [super touchesBegan:touches withEvent:event];
        NSLog(@"touchBegin");
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    NSLog(@"touchEnded");
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
        NSLog(@"touchMoved");
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
        NSLog(@"touchcanCelled");
}

-(void)dealloc{
    NSLog(@"buttonDealloc");
    [self pop_removeAllAnimations];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
