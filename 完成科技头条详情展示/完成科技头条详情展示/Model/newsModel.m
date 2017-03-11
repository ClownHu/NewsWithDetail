//
//  newsModel.m
//  01 - 科技头条界面
//
//  Created by 胡卓 on 2017/3/8.
//  Copyright © 2017年 胡卓. All rights reserved.
//

#import "newsModel.h"
#import "YYModel.h"

@implementation newsModel

//重写description方法，返回对象的描述信息

-(NSString *)description {
    
    return [self yy_modelDescription];
}



@end
