//
//  JFTextField.h
//  JFTextFiled
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 pengjf. All rights reserved.
//
#define BUTTON_SIZE CGSizeMake(self.bounds.size.height, self.bounds.size.height)
#import <UIKit/UIKit.h>
@interface JFTextField : UITextField


@property (nonatomic,strong)UIButton *leftImageButton;
@property (nonatomic,strong)UIButton *rightImageButton;
//占位符的偏移量
@property (nonatomic,assign)CGFloat placehoderOffset;
//编辑的时候光标的偏移量
@property (nonatomic,assign)CGFloat editingCursorOffset;
//placehoder字体大小,默认17.0
@property (nonatomic,assign)CGFloat placehoderFont;
//编辑完成后文本的偏移量
@property (nonatomic,assign)CGFloat textOffset;
//placehoder颜色
@property (nonatomic,strong)UIColor *placehoderColor;
//  改变前的内容
@property (nonatomic, copy) NSString    *previousTextFieldContent;
//改变前的光标
@property (nonatomic, copy) UITextRange *previousTextFieldTextRange;
//是否将手机号码用空格分开，是否是手机号码还需要自己去判断使用正则表达式
@property (nonatomic,assign)BOOL isPhoneSpace;


//确认按钮的样式
//UIReturnKeyType *returnKeyType;

/**
 *  创建一个两边都有button的按钮
 *
 *  @param frame      frame description
 *  @param leftImage  leftImage description
 *  @param rightImage rightImage description
 *
 *  @return 左右都有button的按钮的textFiled
 */
- (id)initWithLeftButton:(NSString *)leftImage rightButton:(NSString *)rightImage selector:(SEL)sel target:(id)target;

#pragma mark -- 此方法添加左右btn，xib文件拉取的需要自己手动添加
- (void)setedImageButton:(NSString *)imageName isRight:(BOOL)isRight selector:(SEL)sel target:(id)target;

- (void)shakeWithView:(UIView *)view duration:(NSTimeInterval)duration;
@end
