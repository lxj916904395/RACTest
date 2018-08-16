//
//  ViewController.m
//  RACTest
//
//  Created by lxj on 2018/8/16.
//  Copyright © 2018年 lxj. All rights reserved.
//

#import "ViewController.h"

#import <ReactiveObjC.h>
#import <RACReturnSignal.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self funcrac];
    //[self datarac];
   // [self uirac];
}

- (void)funcrac{
    @weakify(self);
    
//    //合并
//    RACSignal *signal1 = self.accountTF.rac_textSignal;
//    RACSignal *signal2 = [self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
//    //合并的信号任意一个触发都会收到信号
//    [[signal1 merge:signal2] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    
//    //过滤
//    [[self.accountTF.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
//        @strongify(self);
//        return self.accountTF.text.length>5;
//    }] subscribeNext:^(NSString * _Nullable x) {
//           @strongify(self);
//        self.statusLabel.text = @"用户名长度符合要求";
//    }] ;
    
    
    //映射
    //    [[[self.accountTF.rac_textSignal skip:1] flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
    //
    //        NSLog(@"%@",value);
    //        return [RACReturnSignal return: [NSString stringWithFormat:@" %@",value]];
    //    }] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@",x);
    //    }] ;
    
    //    [[self.accountTF.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
    //        return [NSString stringWithFormat:@"输出:%@",value];
    //    }] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@",x);
    //    }];
}

- (void)datarac{
    //数组遍历
//    NSArray *names = @[@"name1",@"name2",@"name3"];
    //rac_sequence ：序列
    //开辟新线程
//    [names.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"数组遍历==%@",x);
//        NSLog(@"%@",[NSThread currentThread]);
//    }];

    //字典遍历
    //开辟新线程
    NSDictionary *dict = @{@"name":@"lxj",@"sex":@"man",@"age":@(18)};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        //x : 元祖
        //NSLog(@"字典遍历==%@",x);
         // NSLog(@"%@",[NSThread currentThread]);
    }];
    
    //定时器,每隔一秒执行
    //开辟新线程
    //重复执行
//    [[RACSignal interval:1 onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate * _Nullable x) {
//        NSLog(@"%@",[NSThread currentThread]);
//    }];
    
}

- (void)uirac{
    @weakify(self);
    //监控textfield 内容变化
    [[self.accountTF.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"x==%@",x);
    }];
    
    //按钮点击事件
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        NSLog(@"点击登录");
        @strongify(self);
        if ([self.accountTF.text isEqualToString:@"123"]
            && [self.pwdTF.text isEqualToString:@"123"]) {
            self.statusLabel.text = @"登录成功";
        }else{
            self.statusLabel.text = @"登录失败";
        }
    }];
    
    //手势rac
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        NSLog(@"rac手势");
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
