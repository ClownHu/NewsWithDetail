//
//  newsModel.h
//  01 - 科技头条界面
//
//  Created by 胡卓 on 2017/3/8.
//  Copyright © 2017年 胡卓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newsModel : NSObject

//新闻ID
@property(nonatomic,copy)NSString *id;

//新闻标题
@property(nonatomic,copy)NSString *title;

//新闻图片
@property(nonatomic,copy)NSString *src_img;

//新闻来源
@property (nonatomic, copy) NSString *sitename;

//新闻发布时间
@property(nonatomic,copy)NSString *addtime;

//新闻详情页面内容
@property(nonatomic,copy)NSString *content;

@end
