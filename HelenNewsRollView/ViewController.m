//
//  ViewController.m
//  HelenNewsRollView
//
//  Created by 还带大道 on 16/10/21.
//  Copyright © 2016年 还带大道. All rights reserved.
//

#import "ViewController.h"
#import "HelenNewsRollView.h"
#import "RZHomeView_index.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) HelenNewsRollView *newsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RZHomeView_index *view_index1 = [RZHomeView_index new];
        view_index1.backgroundColor = [UIColor blueColor];
    RZHomeView_index *view_index2 = [RZHomeView_index new];
        view_index2.backgroundColor = [UIColor yellowColor];
    HelenNewsRollView *newsView = [[HelenNewsRollView alloc] initWithContentView1:view_index1 contentView2:view_index2];
//    HelenNewsRollView *newsView = [[HelenNewsRollView alloc] initWithContentView1:view_index1];
    _newsView = newsView;
    newsView.backgroundColor = [UIColor redColor];
    [self.view addSubview:newsView];
    [newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(self.view.frame.size.width*0.5);
        make.height.mas_equalTo(77);
    }];
    
    NSArray *items = @[@"这是第1条",@"这是第2条",@"这是第3条"];
    //设置数据
    newsView.setItemInfoBlock = ^(UIView *view,NSInteger index) {
        RZHomeView_index *view_index = (RZHomeView_index *)view;
        view_index.title.text = items[index];
        
    };
    //点击了item
    newsView.itemOnClickBlock = ^(NSInteger index) {
        NSLog(@"点击了--%@",items[index]);
    };
    [newsView animationWithItems:items];
}


- (IBAction)stopBtnClick {
   [_newsView stopAnimation];
}


@end
