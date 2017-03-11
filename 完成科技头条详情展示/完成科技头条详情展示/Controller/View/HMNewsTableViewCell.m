//
//  HMNewsTableViewCell.m
//  01 - 科技头条界面
//
//  Created by 胡卓 on 2017/3/8.
//  Copyright © 2017年 胡卓. All rights reserved.
//

#import "HMNewsTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HMNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}




/**
 重写setter方法，给cell子控件赋值
 */
-(void)setModel:(newsModel *)model {
    
    _model = model;
    
    
    //给cell里每个子控件赋值
    _newsTitle.text = model.title;
    _newsSource.text = model.sitename;
    _newsTime.text = [NSDate dateWithTimeIntervalSince1970:[model.addtime doubleValue]].description;
    [_newsImage sd_setImageWithURL:[NSURL URLWithString:model.src_img] placeholderImage:[UIImage imageNamed:@"xzq.jpg"]];
    
}

@end
