//
//  HelenNewsRollView.h
//  HelenNewsRollView
//
//  Created by 还带大道 on 16/10/21.
//  Copyright © 2016年 还带大道. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HelenNewsRollView;

@interface HelenNewsRollView : UIView

@property (copy, nonatomic) void(^setItemInfoBlock)(UIView *view,NSInteger index);
@property (copy, nonatomic) void(^itemOnClickBlock)(NSInteger index);

- (void)stopAnimation;
- (void)animationWithItems:(NSArray *)items;
- (instancetype)initWithContentView1:(UIView *)contentView1;
- (instancetype)initWithContentView1:(UIView *)contentView1 contentView2:(UIView *)contentView2;
@end
