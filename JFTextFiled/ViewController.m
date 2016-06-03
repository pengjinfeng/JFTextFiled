//
//  ViewController.m
//  JFTextFiled
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 pengjf. All rights reserved.
//

#import "ViewController.h"
#import "JFTextField.h"
@interface ViewController ()<JFTextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    JFTextField *text = [[JFTextField alloc] initWithLeftButton:@"pp_search" rightButton:@"pj_photo"];
    text.delegate = self;
    text.frame = CGRectMake(60, 200, 200, 30);
    text.backgroundColor  = [UIColor colorWithRed:233/255.0f green:233/255.0f blue:233/255.0f alpha:1.0f];
    text.placeholder = @"请输入...";
    text.placehoderOffset = 30.0f;
    text.editingCursorOffset = 30.0f;
    text.placehoderFont = 14.0f;
    [self.view addSubview:text];
}
- (void)textFiledButton:(UITextField *)textFiled atIndex:(NSInteger)index{
    if (index == 0) {
        NSLog(@"点击左边的按钮");
    }else if (index == 1){
        NSLog(@"点击右边的按钮");
    }else{
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
