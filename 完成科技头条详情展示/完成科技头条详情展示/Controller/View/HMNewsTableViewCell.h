//
//  HMNewsTableViewCell.h
//  01 - 科技头条界面
//
//  Created by 胡卓 on 2017/3/8.
//  Copyright © 2017年 胡卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newsModel.h"


@interface HMNewsTableViewCell : UITableViewCell


//需要在cell里定义一个属性，接受数据
@property(nonatomic,strong)newsModel *model;




@property (weak, nonatomic) IBOutlet UILabel *newsTitle;

@property (weak, nonatomic) IBOutlet UILabel *newsSource;

@property (weak, nonatomic) IBOutlet UILabel *newsTime;

@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@end
