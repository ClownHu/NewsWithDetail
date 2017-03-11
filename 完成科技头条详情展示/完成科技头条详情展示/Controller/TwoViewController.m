//
//  TwoViewController.m
//  完成科技头条详情展示
//
//  Created by 胡卓 on 2017/3/11.
//  Copyright © 2017年 胡卓. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //实例化
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    
    //设置滚动速度和背景颜色
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    _webView.backgroundColor = [UIColor purpleColor];
    
    [self loadDetail];
    
}


-(void)loadDetail {
    
    //拼接新闻的url的字符串
    NSString *urlString = [NSString stringWithFormat:@"http://news.coolban.com/Api/Index/get_news/app/2/id/%@",_model.id];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            
            return;
        }
        
        //解析json
        NSDictionary *newsDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        //设置模型的content
        _model.content = [NSString stringWithFormat:@"<h2>%@</h2><br>%@",_model.title,newsDict[@"content"]];
        
       //主线程里加载htm的字符串
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_webView loadHTMLString:_model.content baseURL:nil];
        });
    }] resume];
}
@end
