//
//  ViewController.m
//  JFTextFiled
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 pengjf. All rights reserved.
//

#import "ViewController.h"
#import "JFTextField.h"
@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic,weak)IBOutlet JFTextField * text;
@property (nonatomic,weak)IBOutlet UILabel * label;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.text.delegate = self;
    self.text.placeholder = @"请输入手机号码";
    self.text.textOffset = 40.0f;
    self.text.placehoderOffset = 40.0;
    self.text.editingCursorOffset = 40.0f;
    self.text.placehoderColor = [UIColor redColor];
    
    //开启空格分隔
    self.text.isPhoneSpace = YES;
    [self.text setedImageButton:@"pj_photo" isRight:NO selector:@selector(left:) target:self];
     [self.text setedImageButton:@"pp_search" isRight:YES selector:@selector(left:) target:self];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.label.text = [self.text.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}
- (void)left:(UIButton *)sender{
    NSLog(@"test success");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.text resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
