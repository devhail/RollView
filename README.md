# HelenNewsRollView
帮你快速的把消息滚动起来！
==================================================
![github](https://github.com/xiaoguo.png "github")

1.让您心动❤️的点
---------------------------------------------
### 1.1可以自定义用来滚动的view. 
### 1.2通过block回调方式对自定义view进行数据设置.
### 1.3通过block回调方式告知当前被点击的位置.
<br>

2.一句代码让消息滚动起来
--------------------------------------------------
### 2.1初始化.
- (instancetype)initWithContentView1:(UIView *)contentView1;
- (instancetype)initWithContentView1:(UIView *)contentView1 contentView2:(UIView *)contentView2;
### 2.2开始/暂停动画.
- (void)stopAnimation;
- (void)animationWithItems:(NSArray *)items;
### 2.3通过block回调方式对自定义view进行数据设置.
@property (copy, nonatomic) void(^setItemInfoBlock)(UIView *view,NSInteger index);
### 2.4通过block回调方式告知当前被点击的位置.
@property (copy, nonatomic) void(^itemOnClickBlock)(NSInteger index);
