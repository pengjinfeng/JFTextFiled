//
//  JFTextField.h
//  JFTextFiled
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 pengjf. All rights reserved.
//
#define BUTTON_SIZE CGSizeMake(30, 30)
#import <UIKit/UIKit.h>
@protocol JFTextFieldDelegate;
@interface JFTextField : UITextField

@property (nonatomic,weak)id<JFTextFieldDelegate>delegate;

@property (nonatomic,strong)UIButton *leftImageButton;
@property (nonatomic,strong)UIButton *rightImageButton;
//占位符的偏移量
@property (nonatomic,assign)CGFloat placehoderOffset;
//编辑的时候光标的偏移量
@property (nonatomic,assign)CGFloat editingCursorOffset;
//文字显示的偏移量
@property (nonatomic,assign)CGFloat textOffset;
//placehoder字体大小,默认17.0
@property (nonatomic,assign)CGFloat placehoderFont;


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
- (id)initWithLeftButton:(NSString *)leftImage rightButton:(NSString *)rightImage;
@end
@protocol JFTextFieldDelegate <UITextFieldDelegate>
//左边按钮index为0，右边为1
- (void)textFiledButton:(UITextField *)textFiled atIndex:(NSInteger)index;

@end