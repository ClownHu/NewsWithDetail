//
//  ViewController.m
//  01 - 科技头条界面
//
//  Created by 胡卓 on 2017/3/8.
//  Copyright © 2017年 胡卓. All rights reserved.


#import "ViewController.h"
#import "HMNewsTableViewCell.h"
#import "YYModel.h"
#import "newsModel.h"
#import "MJRefresh.h"
#import "TwoViewController.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//下拉控件属性
@property(nonatomic,strong)MJRefreshNormalHeader *refreshHeader;

//上拉控件属性
@property(nonatomic,strong)MJRefreshAutoNormalFooter *refreshFooter;
@end


static NSString *rid = @"news";

@implementation ViewController {
    
    //保持数据源的数据
    NSMutableArray <newsModel *> *_modelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    //初始化
    _modelList = [NSMutableArray array];
    
    _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    _tableView.mj_header = _refreshHeader;
    _tableView.mj_footer = _refreshFooter;
    
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"HMNewsTableViewCell" bundle:nil] forCellReuseIdentifier:rid];
    
    //设置数据源和代理
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //给它自动行高
    _tableView.estimatedRowHeight = 200;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self loadData];
}


/**
 加载网络数据
 */
-(void)loadData {
    
    NSInteger type = 0;
    NSString *time = @"0";
    //判断下拉刷新还是上拉刷新
    //下拉
    if (_refreshHeader.isRefreshing) {
        
        time = _modelList.count >0 ? [_modelList.firstObject addtime] :@"0";
    }
    
    //上拉
    if (_refreshFooter.isRefreshing) {
        
        type = 1;
        time = _modelList.count >0 ? [_modelList.lastObject addtime] :@"0";
    }
    
    
    NSString *urlStr = [NSString stringWithFormat:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/%@/type/%ld",time,type];
    
    //1.创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //2.创建request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.发起网络请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //请求错误会执行的代码
        if (error != nil) {
            
            NSLog(@"%@",error);
            return;
        }
        
        //反序列化
        NSArray *newsArr =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        
        NSLog(@"%@",newsArr);
        
        
        //字典数组转模型数组
        NSArray *newsModelArr = [NSArray yy_modelArrayWithClass:[newsModel class] json:newsArr];
        
        NSMutableArray *receiveNewsArr = [NSMutableArray arrayWithArray:newsModelArr];
        
        //        NSLog(@"%@",newsModelArr);
        
        //说明是下拉
        if (type == 0) {
            
            _modelList = receiveNewsArr;
            
        } else { //说明是上拉
            
            [_modelList addObjectsFromArray:receiveNewsArr];
        }
        
        //        //将获取的数据加到数组里
        //        [_modelList addObjectsFromArray:newsModelArr];
        
        
        //在主线程里刷新tbView
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //判断是上拉还是下拉，该结束哪个
            
            if (type == 0) {  //下拉结束
                
                [_refreshHeader endRefreshing];
                
            } else {    //上拉结束
                
                [_refreshFooter endRefreshing];
            }
            
            [self.tableView reloadData];
        });
        
        //默认是挂起的
    }] resume];
    
}


#pragma mark - 实现数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _modelList.count;
}

-(HMNewsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HMNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
    
    
    //将模型数据传给cell，让cell更新
    newsModel *model = _modelList[indexPath.row];
    
    cell.model = model;
    
//    cell.textLabel.text = @"我们好像在哪见过  ";
    return cell;
    
}

//选中一行会来调用，即实现详情新闻的跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TwoViewController *detailVC = [[TwoViewController alloc]init];
    
    //设置数据
    detailVC.model = _modelList[indexPath.row];
    
    //push
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
