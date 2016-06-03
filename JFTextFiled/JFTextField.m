//
//  JFTextField.m
//  JFTextFiled
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 pengjf. All rights reserved.
//

#import "JFTextField.h"

@implementation JFTextField
- (id)initWithLeftButton:(NSString *)leftImage rightButton:(NSString *)rightImage{
    if (self = [super init]) {
        if (leftImage) {
            [self setedImageButton:leftImage isRight:NO];
        }
        if (rightImage) {
            [self setedImageButton:rightImage isRight:YES];
        }
    }
    return self;
}
- (void)setedImageButton:(NSString *)imageName isRight:(BOOL)isRight{
    if (!isRight) {
        self.leftImageButton = [self createImageButton:imageName tag:0];
        self.leftView = self.leftImageButton;
        self.leftViewMode = UITextFieldViewModeAlways;
    }else{
        self.rightImageButton = [self createImageButton:imageName tag:1];
        self.rightView = self.rightImageButton;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
}
- (UIButton *)createImageButton:(NSString *)imageName tag:(NSInteger)tag{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.tag = tag;
    button.frame = CGRectMake(0, 0, BUTTON_SIZE.width, BUTTON_SIZE.height);
    [button addTarget:self action:@selector(searchTextButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
#pragma mark -- 左右按钮的点击事件
- (void)searchTextButton:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(textFiledButton:atIndex:)]) {
        [self.delegate textFiledButton:self atIndex:sender.tag];
    }
}
//  重写占位符的x值
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
    if (self.placehoderOffset != 0) {
        placeholderRect.origin.x = self.placehoderOffset;
    }
    return placeholderRect;
}
//  重写文字输入时的X值
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect editingRect = [super editingRectForBounds:bounds];
    if (self.editingCursorOffset!=0) {
        editingRect.origin.x = self.editingCursorOffset;
    }
    return editingRect;
}
//让文字居中显示
- (void)drawPlaceholderInRect:(CGRect)rect {
    [super drawPlaceholderInRect:CGRectMake(0, self.bounds.size.height * 0.5 - 1, 0, 0)];
}
//setTextFiled的字体大小
- (void)setPlacehoderFont:(CGFloat)placehoderFont{
    if(_placehoderFont == placehoderFont){
         self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:placehoderFont]}];
    }else{
         self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:placehoderFont]}];
    }
                                       
}

@end
