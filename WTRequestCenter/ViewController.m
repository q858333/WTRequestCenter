//
//  ViewController.m
//  WTRequestCenter
//
//  Created by song on 14-7-19.
//  Copyright (c) 2014年 song. All rights reserved.
//

#import "ViewController.h"
#import "WTRequestCenter.h"
#import "UIKit+WTRequestCenter.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//  设置响应失效日期
//    NSLog(@"%f",[WTRequestCenter expireTimeInterval]);
//    [WTRequestCenter setExpireTimeInterval:0];
    NSLog(@"%@",NSHomeDirectory());
    
//    NSLog(@"uuid:%@",[UIDevice WTUUID]);
    
//    NSLog(@"%@",[NSBundle mainBundle].executableArchitectures);
    
//    GET请求
//    [self get];
    
//    POST请求
//    [self post];
//    下载图片
//    [self loadImage];
//    [WTRequestCenter cancelAllRequest];
//    gif
//    [self loadGif];
    
//    [self gifButton];
//    [WTRequestCenter clearAllCache];

    
    
    NSLog(@"%@",[[NSBundle mainBundle] URLsForResourcesWithExtension:nil subdirectory:nil]);
    NSURL *url = [[[NSBundle mainBundle] URLsForResourcesWithExtension:nil subdirectory:nil] lastObject];
    [WTDataSaver dataWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        NSLog(@"%@",string);
    }];
    
    
//    存取数据
//    [self saveAndWrite];
    
//    查看内存用量 单位是byte
//    Returns the current size of the receiver’s in-memory cache, in bytes.
//    NSLog(@"当前内存用量  %u KB",[[WTRequestCenter sharedCache] currentMemoryUsage]/1024);
    
//    查看缓存（Cache）用量,单位是byte
//    The current size of the receiver’s on-disk cache, in bytes.
//    NSLog(@"缓存用量  %u KB",[WTRequestCenter currentDiskUsage]/1024);
}



-(void)get
{
//    http://www.baidu.com/s?wd=aaa&rsv_spt=1&issp=1&rsv_bp=0&ie=utf-8&tn=baiduhome_pg&inputT=733
    
//    __block NSInteger index = 0;
    for (int i=0; i<1; i++) {

        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/s?wd=aaa&rsv_spt=1&issp=1&rsv_bp=0&ie=utf-8&tn=baiduhome_pg&inputT=733"];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
   
        
        [WTRequestCenter getWithURL:url
                         parameters:parameters
                  completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                      index++;
//                      NSLog(@"index:%d",index);
//                      id obj = [WTRequestCenter JSONObjectWithData:data];
//                      NSLog(@"result is %@",obj);
                  }];

    }
    
    
    
}

-(void)post
{
    NSURL *url = [NSURL URLWithString:[WTRequestCenter urlWithIndex:0]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"1" forKey:@"a"];
    [parameters setValue:@"2" forKey:@"b"];
    [parameters setValue:@"3" forKey:@"c"];
    [WTRequestCenter postWithURL:url
                      parameters:parameters completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                          id obj = [WTRequestCenter JSONObjectWithData:data];
                          NSLog(@"result is %@",obj);
                          
                      }];
}

-(void)loadImage
{
    NSURL *url = [NSURL URLWithString:@"http://img0.bdstatic.com/img/image/shouye/dengni47.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.frame = self.view.bounds;
    imageView.frame = CGRectMake(0, 0, 320, 480/2);
    UIImage *placeHolderImage = [UIImage imageNamed:@"image.jpg"];
    [imageView setImageWithURL:url placeholderImage:placeHolderImage];
    
    [self.view addSubview:imageView];
}

-(void)loadGif
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.frame = CGRectMake(0, 480/2, 320, 480/2);
    imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:imageView];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"aaa" withExtension:@"gif"];
    [UIImage gifImageWithURL:url
                  completion:^(UIImage *image) {
                      imageView.image = image;
                  }];
    
    
}

-(void)gifButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 480/2, 320, 480/2);
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"aaa@2x" withExtension:@"gif"];
    NSURL *url2 = [NSURL URLWithString:@"http://img2.duitang.com/uploads/item/201208/28/20120828224017_MZtRh.gif"];
    button.contentMode = UIViewContentModeCenter;
//    [button setImage:[UIImage animatedImageWithAnimatedGIFURL:url2] forState:UIControlStateNormal];
    
    [UIImage gifImageWithURL:url2
                  completion:^(UIImage *image) {
                      [button setImage:image forState:UIControlStateNormal];
                  }];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)button:(UIButton*)sender
{
    NSLog(@"pressed");
}

-(void)saveAndWrite
{
    
    NSLog(@"%@",NSHomeDirectory());
    NSData *data = [@"狂拽酷眩叼炸天" dataUsingEncoding:NSUTF8StringEncoding];
    [WTDataSaver saveData:data withName:@"data"];
    [WTDataSaver dataWithName:@"data" completion:^(NSData *data) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
    }];
    
    [WTDataSaver fileSizeComplection:^(NSInteger size) {
        NSLog(@"%d",size);
    }];
    [WTDataSaver removeAllData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
