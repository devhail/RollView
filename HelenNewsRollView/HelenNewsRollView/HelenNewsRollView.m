//
//  HelenNewsRollView.m
//  HelenNewsRollView
//
//  Created by 还带大道 on 16/10/21.
//  Copyright © 2016年 还带大道. All rights reserved.
//

#import "HelenNewsRollView.h"

#define DEALY_WHEN_NEWS_IN_MIDDLE  2.0
#define DEALY_WHEN_NEWS_IN_BOTTOM  DEALY_WHEN_NEWS_IN_MIDDLE

typedef NS_ENUM(NSUInteger,HelenNewsRollViewPosition) {
    HelenNewsRollViewPositionTop    = 1,
    HelenNewsRollViewPositionMiddle = 2,
    HelenNewsRollViewPositionBottom = 3
};

@interface HelenNewsRollView ()
@property (strong, nonatomic) UIView *contentView1;
@property (strong, nonatomic) UIView *contentView2;
@property (nonatomic, strong) NSArray *contentsAry;
@property (nonatomic, assign) CGPoint topPosition;
@property (nonatomic, assign) CGPoint middlePosition;
@property (nonatomic, assign) CGPoint bottomPosition;
@property (nonatomic, assign) CGFloat needDealy;
@property (nonatomic, assign) NSInteger currentIndex;  /*当前播放到那个标题了*/
@property (nonatomic, assign) BOOL shouldStop;         /*是否停止*/

@end

@implementation HelenNewsRollView

- (instancetype)initWithContentView1:(UIView *)contentView1
{
    if (self = [super init]) {

        //交给父控件处理事件
        contentView1.userInteractionEnabled = NO;
        _shouldStop = NO;
        _currentIndex = 0;
        _contentView1 = contentView1;
        self.clipsToBounds = YES;   /*保证文字不跑出视图*/
        _needDealy = DEALY_WHEN_NEWS_IN_MIDDLE;    /*控制第一次显示时间*/
        //设置锚点（决定着CALayer身上的哪个点会在position属性所指的位置）  默认值为（0.5, 0.5）
        contentView1.layer.anchorPoint = CGPointMake(0, 0);
        [self addSubview:contentView1];
    }
    return self;
}


- (instancetype)initWithContentView1:(UIView *)contentView1 contentView2:(UIView *)contentView2
{
    if (self = [super init]) {
        
        //交给父控件处理事件
        contentView1.userInteractionEnabled = NO;
        contentView2.userInteractionEnabled = NO;
        _shouldStop = NO;
        _currentIndex = 0;
        contentView1.tag = 1;
        contentView2.tag = 2;
        _contentView1 = contentView1;
        _contentView2 = contentView2;
        self.clipsToBounds = YES;   /*保证文字不跑出视图*/
        _needDealy = DEALY_WHEN_NEWS_IN_MIDDLE;    /*控制第一次显示时间*/
        //设置锚点（决定着CALayer身上的哪个点会在position属性所指的位置）  默认值为（0.5, 0.5）
        contentView1.layer.anchorPoint = CGPointMake(0, 0);
        contentView2.layer.anchorPoint = CGPointMake(0, 0);
        [self addSubview:contentView2];
        [self addSubview:contentView1];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置视图在各位置的点
    self.topPosition    = CGPointMake(0, -self.frame.size.height);
    self.middlePosition = CGPointMake(0, 0);
    if(_contentView2){
        self.bottomPosition = CGPointMake(0, self.frame.size.height);
    }else{
        self.bottomPosition = CGPointMake(0, 0);
    }
    
    //view1
    _contentView1.frame = self.bounds;
    //position 用来设置CALayer在父层中的位置 以父层的左上角为原点(0, 0)
    _contentView1.layer.position = self.middlePosition;
    
    //view2
    _contentView2.frame = self.bounds;
    //position 用来设置CALayer在父层中的位置 以父层的左上角为原点(0, 0)
    _contentView2.layer.position = self.bottomPosition;
}



//设置需要滚动的内容（可多条）
- (void)animationWithItems:(NSArray *)items
{
    _contentsAry = items;
    !_setItemInfoBlock ? :_setItemInfoBlock(_contentView1,0);
    [self startAnimationWithView:_contentView1];
    
    if(_contentView2){
        _currentIndex++;
        !_setItemInfoBlock ? :_setItemInfoBlock(_contentView2,_currentIndex);
        [self startAnimationWithView:_contentView2];
    }
}



//开始动画
- (void)startAnimationWithView:(UIView *)view
{
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:1 delay:self.needDealy options:UIViewAnimationOptionCurveEaseInOut animations:^{

        if ([weakSelf currentTitlePositionWithView:view] == HelenNewsRollViewPositionMiddle) {
            view.layer.position = weakSelf.topPosition;
            
        } else if ([weakSelf currentTitlePositionWithView:view] == HelenNewsRollViewPositionBottom) {
            view.layer.position = weakSelf.middlePosition;
            
        }
    } completion:^(BOOL finished) {
        if ([weakSelf currentTitlePositionWithView:view] == HelenNewsRollViewPositionTop) { //动画完成后处在顶部
            view.layer.position = weakSelf.bottomPosition;
            weakSelf.needDealy = DEALY_WHEN_NEWS_IN_BOTTOM;
            weakSelf.currentIndex ++;
            !_setItemInfoBlock ? :_setItemInfoBlock(view,[self realCurrentIndex]);
            
        } else {
            weakSelf.needDealy = DEALY_WHEN_NEWS_IN_MIDDLE;
        }
        
        if (!weakSelf.shouldStop) {//继续动画
            [weakSelf startAnimationWithView:view];
        } else { //停止动画后，要设置label位置和label显示内容
            view.layer.position = weakSelf.middlePosition;
            !_setItemInfoBlock ? :_setItemInfoBlock(view,[self realCurrentIndex]);
            
        }
    }];
}



//当前滚动消息的位置
- (HelenNewsRollViewPosition)currentTitlePositionWithView:(UIView *)view
{
    if (view.layer.position.y == self.topPosition.y) {
        return HelenNewsRollViewPositionTop;
    } else if (view.layer.position.y == self.middlePosition.y) {
        return HelenNewsRollViewPositionMiddle;
    }
    return HelenNewsRollViewPositionBottom;
}



//停止滚动
- (void)stopAnimation
{
    self.shouldStop = YES;
}


//当前滚动的是第几条消息
- (NSInteger)realCurrentIndex
{
    return self.currentIndex % [self.contentsAry count];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSInteger index;
    if(_contentView2){
        index = (self.currentIndex-1) % [self.contentsAry count];
    }else{
        index = [self realCurrentIndex];
    }
    
    !_itemOnClickBlock ? :_itemOnClickBlock(index);
}

@end
