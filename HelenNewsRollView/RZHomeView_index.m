//
//  RZHomeView_index.m
//  zhongliangang
//
//  Created by 还带大道 on 2018/1/15.
//  Copyright © 2018年 还带大道. All rights reserved.
//

#import "RZHomeView_index.h"
#import "Masonry.h"

@interface RZHomeView_index()

@end

@implementation RZHomeView_index

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        UILabel *title = [UILabel new];
        _title = title;
        title.text = @"xxxx指数";
        title.textColor = [UIColor orangeColor];
        title.font = [UIFont systemFontOfSize:12];
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(title.font.pointSize);
            
        }];
        
        UILabel *num1 = [UILabel new];
        num1.text = @"22";
        num1.textColor = [UIColor redColor];;
        num1.font = [UIFont systemFontOfSize:20];
        [self addSubview:num1];
        [num1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(title.mas_bottom).mas_offset(9);
            make.height.mas_equalTo(num1.font.pointSize);
        }];
        
        UILabel *num2 = [UILabel new];
        num2.text = @"+0.95";
        num2.textColor = [UIColor redColor];;
        num2.font = [UIFont systemFontOfSize:11];
        [self addSubview:num2];
        [num2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(32);
            make.bottom.mas_equalTo(-8);
            make.height.mas_equalTo(num2.font.pointSize);
        }];
        
        UILabel *num3 = [UILabel new];
        num3.text = @"1.14%";
        num3.textColor = [UIColor redColor];;
        num3.font = [UIFont systemFontOfSize:11];
        [self addSubview:num3];
        [num3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-21);
            make.bottom.mas_equalTo(-8);
            make.height.mas_equalTo(num3.font.pointSize);
        }];
    }
    return self;
}

@end
