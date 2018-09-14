//
//  UITextField+Format.m
//  HePanDai2_0
//
//  Created by 123 on 2017/9/2.
//  Copyright © 2017年 HePanDai. All rights reserved.
//

#import "UITextField+Format.h"
#import <objc/runtime.h>

static NSString *formatType = @"formatType";

@implementation UITextField (Format)
@dynamic textFormatType;

- (void)setTextFormatType:(HBTextFieldFormatType)textFormatType{
    objc_setAssociatedObject(self,&formatType,@(textFormatType),OBJC_ASSOCIATION_COPY);
    
    [self addTarget:self action:@selector(reformatAsBankNumber:) forControlEvents:UIControlEventEditingChanged];
}

- (HBTextFieldFormatType )textFormatType{
    NSString *textFormatType = (NSString *)objc_getAssociatedObject(self, &formatType);
    return [textFormatType integerValue];
}

- (NSString *)textContainsNoCharset
{
    
    return [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(void)reformatAsBankNumber:(UITextField *)textField {
    
    /**
     *  判断正确的光标位置
     */
    NSUInteger targetCursorPostion = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *numberWithoutSpaces = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPostion];
    
    NSString *numberWithSpaces;
    if(self.textFormatType == kHBTextFieldTypeFormatBankCard){
        numberWithSpaces = [self insertSpacesEveryFourDigitsIntoString:numberWithoutSpaces andPreserveCursorPosition:&targetCursorPostion];
    }else if (self.textFormatType == kHBTextFieldTypeFormatPhoneNO){
        numberWithSpaces = [self insertSpacesIntoPhoneNumberString:numberWithoutSpaces andPreserveCursorPosition:&targetCursorPostion];
    }else if (self.textFormatType == kHBTextFieldTypeFormatIDNO){
        numberWithSpaces = [self insertSpacesIntoIDNOString:numberWithoutSpaces andPreserveCursorPosition:&targetCursorPostion];
    }
    
    textField.text = numberWithSpaces;
    UITextPosition *targetPostion = [textField positionFromPosition:textField.beginningOfDocument offset:targetCursorPostion];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPostion toPosition:targetPostion]];
}

/**
 *  除去非数字字符，确定光标正确位置
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理过后的string
 */
- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i=0; i<string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if(isdigit(characterToAdd)) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if(i<originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
    
}

#pragma 银行卡格式
/**
 *  将空格插入我们现在的string 中，并确定我们光标的正确位置，防止在空格中
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理后有空格的string
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i=0; i<string.length; i++) {
        if(i>0)
        {
            if(i%4 == 0) {
                [stringWithAddedSpaces appendString:@" "];
                
                if(i<cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}

#pragma 手机号码格式
- (NSString *)insertSpacesIntoPhoneNumberString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i=0; i<string.length; i++) {
        if(i>0)
        {
            if(i == 3 || i == 7) {
                [stringWithAddedSpaces appendString:@" "];
                
                if(i<cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}

#pragma 身份证格式
- (NSString *)insertSpacesIntoIDNOString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i=0; i<string.length; i++) {
        if(i>0)
        {
            if(i == 6 || i == 10 || i == 14) {
                [stringWithAddedSpaces appendString:@" "];
                
                if(i<cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}


@end
