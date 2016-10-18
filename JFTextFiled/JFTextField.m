//
//  JFTextField.m
//  JFTextFiled
//
//  Created by apple on 16/5/21.
//  Copyright © 2016年 pengjf. All rights reserved.
//

#import "JFTextField.h"

@implementation JFTextField

- (id)initWithLeftButton:(NSString *)leftImage rightButton:(NSString *)rightImage selector:(SEL)sel target:(id)target{
    if (self = [super init]) {
        [self addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        if (leftImage) {
            [self setedImageButton:leftImage isRight:NO selector:sel target:target];
        }
        if (rightImage) {
            [self setedImageButton:rightImage isRight:YES selector:sel target:target];
        }
    }
    return self;
}
- (void)awakeFromNib{
    [self addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
}
#pragma mark -- 此方法添加左右btn，xib文件拉取的需要自己手动添加
- (void)setedImageButton:(NSString *)imageName isRight:(BOOL)isRight selector:(SEL)sel target:(id)target{
    if (!isRight) {
        self.leftImageButton = [self createImageButton:imageName selector:sel target:target];
        self.leftView = self.leftImageButton;
        self.leftViewMode = UITextFieldViewModeAlways;
    }else{
        self.rightImageButton = [self createImageButton:imageName selector:sel target:target];
        self.rightView = self.rightImageButton;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
}
- (UIButton *)createImageButton:(NSString *)imageName selector:(SEL)sel target:(id)target{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0, 0, BUTTON_SIZE.width, BUTTON_SIZE.height);
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark -- 自动添加空格的
- (void)textFieldChange:(UITextField *)textField{
    NSLog(@"test");
    if (self.isPhoneSpace) {
        //当前光标位置
        NSUInteger nowPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:self.selectedTextRange.start];
        //留下纯数字
        NSString *pureNumberString = [self pureNumberWithString:textField.text nowPosition:&nowPosition];
        
        if (pureNumberString.length > 11) {
            //超过限制位数结束
            textField.text = self.previousTextFieldContent;
            textField.selectedTextRange = self.previousTextFieldTextRange;
            return;
        }else{
            self.previousTextFieldContent =  textField.text;
            self.previousTextFieldTextRange = textField.selectedTextRange;
        }
        
        //插入空格
        NSString *numberAndSpaceString = [self insertSpace:pureNumberString nowPosition:&nowPosition];
        
        textField.text = numberAndSpaceString;
        
        UITextPosition *textPosition = [textField positionFromPosition:textField.beginningOfDocument offset:nowPosition];
        textField.selectedTextRange = [textField textRangeFromPosition:textPosition toPosition:textPosition];
    }
    
}
/**
 *  除掉非数字字符，移动光标到相应的位置上
 *
 *  @param string      字符串
 *  @param nowPosition 当前光标位置
 *
 *  @return 纯数字
 */
- (NSString *)pureNumberWithString:(NSString *)string nowPosition:(NSUInteger *)nowPosition{
    //原始数据
    NSUInteger originalPosition = *nowPosition;
    NSMutableString *pureNumber = [NSMutableString string];
    
    for (NSUInteger i = 0; i < string.length; i++) {
        unichar charCobj = [string characterAtIndex:i];
        //提取c字符
        if (isdigit(charCobj)) {
            //位数字就添加
            //将c字符转化为oc字符串
            NSString *charString = [NSString stringWithCharacters:&charCobj length:1];
            [pureNumber appendString:charString];
        }else{
            if (i < originalPosition) {
                //修改原来指针上的内容
                (*nowPosition)--;
            }
        }
    }
    return pureNumber;
    
}
/**
 *  在相应的位置插入空格
 *
 *  @param string      字符串
 *  @param nowPosition 当前光标位置
 *
 *  @return 处理后的字符串
 */
- (NSString *)insertSpace:(NSString *)string nowPosition:(NSUInteger *)nowPosition{
    //原始数值
    NSUInteger originalPosition = *nowPosition;
    //加入空格
    NSMutableString *numberAndSpaceString = [NSMutableString string];
    
    for (NSUInteger i = 0; i < string.length; i++) {
        if (i==3||i==7) {
            //添加空格
            [numberAndSpaceString appendString:@" "];
            if (i<originalPosition) {
                //修改原指针上的内容（添加空格，光标后移一位）
                (*nowPosition)++;
            }
        }
        
        unichar charCobj = [string characterAtIndex:i];
        NSString *charString = [NSString stringWithCharacters:&charCobj length:1];
        [numberAndSpaceString appendString:charString];
        
    }
    return numberAndSpaceString;
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
    if (self.editingCursorOffset!= 0) {
        editingRect.origin.x = self.editingCursorOffset;
    }
    return editingRect;
}
//让Placeholder居中显示
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
    _placehoderFont = placehoderFont;
}
//setTextFiled的字体大小
- (void)setPlacehoderColor:(UIColor *)placehoderColor{
    _placehoderColor = placehoderColor;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_placehoderColor}];
    
}
//停止编辑时文本的位置
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect textRect = [super textRectForBounds:bounds];
    if (self.textOffset != 0) {
        textRect.origin.x = self.textOffset;
    }
    return textRect;
}

@end
