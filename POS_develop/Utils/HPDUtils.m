//
//  HPDUtils.m
//  HePanDai
//
//  Created by HePanDai on 14-7-4.
//  Copyright (c) 2014 www.hepandai.com All rights reserved.
//

#import "HPDUtils.h"

@implementation HPDUtils

@end


@implementation NSString (HPDString)

- (NSString *)removeCommas
{
    return [self stringByReplacingOccurrencesOfString:@"," withString:@""];
}

- (BOOL)checkMatchRegex:(NSString *)regex
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:self];
}

- (BOOL)isMoneyFormmat
{
    return [self checkMatchRegex:@"^(([1-9]\\d{0,9})|0)(\\.\\d{1,2})?$"];
}

- (BOOL)isEmailFormat
{
    return [self checkMatchRegex:@"^(\\w+([-+.]\\w+)*@\\w+([-.]\\\\w+)*\\.\\w+([-.]\\w+)*)|(\\?)$"];
}

- (BOOL)isPhoneNumberFormat
{
//    return [self checkMatchRegex:@"((\\(\\d{3}\\))|(\\d{3}\\-))?1(1|2|3|4|5|6|7|8|9)\\d{9}|(\\?){1,1}|(10000000000)$"];
    return [self checkMatchRegex:@"0?(13|14|15|18|17|19|16)[0-9]{9}"];
}

- (BOOL)isIDCardFormart
{
    return [self checkMatchRegex:@"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X|x)$"];
}

- (BOOL)containSubstring:(NSString*)substring
{
    if (!substring || substring.length == 0) {
        return  NO;
    }
    return [self rangeOfString:substring].location != NSNotFound;
}

- (NSString *)phoneNoCover
{
    if (self.length > 3+4) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(3, self.length - 3 - 4) withString:@"****"];
    }
    else {
        return self;
    }
}

- (NSString *)bankCardNoCover
{
    if (self.length == 19) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(4, 11) withString:@"***********"];
    }
    else if (self.length >= 16) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(4, self.length - 4 - 4) withString:@"*********"];;
    }
    return self;
}

- (NSString *)bankCardFormat
{
    if (self.length<=4||self == nil) {
        return @"****";
    }
    NSUInteger len = self.length - 4;
    NSString* formatString;
    formatString = [self substringFromIndex:len];
    NSLog(@"%@",formatString);
    return [NSString stringWithFormat:@"尾号%@",formatString];
}


- (NSString *)append:(NSString *)otherStr
{
    return [self stringByAppendingString:otherStr];
}

+ (NSString*)transformToInteger:(NSString*)string
{
    NSString *substring = @".";
    NSRange range = [string rangeOfString:substring];
    NSInteger location = range.location;
    if (location != NSNotFound) {
        NSString *substr = [string substringWithRange:NSMakeRange(0, location)];
        return substr;
    }else{
        return string;
    }
}



@end


@implementation NSDictionary (URLParams)

- (NSString *)urlParamsString
{
    NSMutableArray *pairs = [NSMutableArray array];
    for (NSString *key in [self allKeys]) {
        id value = [self objectForKey:key];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
    return [pairs componentsJoinedByString:@"&"];
}

@end

@implementation NSString (MD5)

- (NSString *)md5Encrypt {
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

- (NSString*)MD5With32Byte{
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


- (NSString*)MD5With16Byte{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end


#ifdef __CORETEXT__

@implementation NSAttributedString (Height)
- (CGFloat)boundingHeightForWidth:(CGFloat)inWidth
{
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, inWidth, 1000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 1000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
}

@end

#endif


@implementation UIImage(Circle)

- (UIImage *)circleMaskWithCenterX:(float)x centerY:(float)y radius:(float)radius
{
    UIGraphicsBeginImageContext(self.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGRect rect = CGRectMake(x - radius, y - radius, radius * 2, radius * 2);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    [self drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return circleImage;
}

@end

@implementation UIImage(Scale)


-(UIImage *)TransformtoSize:(CGSize)aSize
{
    UIGraphicsBeginImageContext(aSize);
    [self drawInRect:CGRectMake(0, 0, aSize.width, aSize.height)];
    UIImage *TransformedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return TransformedImg;
}

@end


@implementation UIHyperlinksButton

+ (UIHyperlinksButton*) hyperlinksButton {
    UIHyperlinksButton* button = [[UIHyperlinksButton alloc] init];
    return button;
}

-(void)setColor:(UIColor *)color{
    lineColor = [color copy];
    [self setNeedsDisplay];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    isHighlight = YES;
    [self setColor:self.titleLabel.textColor];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    isHighlight = NO;
    //    [self setColor:self.titleLabel.highlightedTextColor];
    [self setColor:lineColor];
    
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    //    [self setColor:self.titleLabel.highlightedTextColor];
    [self setColor:lineColor];
}

- (void) drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    if (isHighlight) {
        CGContextSetRGBFillColor(contextRef, 0.8, 0.8, 0.8, 0.8);
        CGContextFillRect(contextRef, textRect);
        CGContextStrokePath(contextRef);
    }
    CGFloat descender = self.titleLabel.font.descender;
    if([lineColor isKindOfClass:[UIColor class]]){
        CGContextSetStrokeColorWithColor(contextRef, lineColor.CGColor);
    }
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender+1);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender+1);
    
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}

@end


@implementation NSString(HPDFormat)

- (NSArray *)componentsSeparatedByFormatCharSet:(NSCharacterSet *)charset
{
    
    NSMutableArray *array = [NSMutableArray array];
    NSCharacterSet *numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    BOOL preIsNumber = NO;
    for (size_t i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if ([numberCharSet characterIsMember:c]) {
            preIsNumber = YES;
            break;
        }
        else if ([charset characterIsMember:c]) {
            preIsNumber = NO;
            break;
        }
    }
    NSMutableString *string = [NSMutableString string];
    for (size_t i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (preIsNumber) {
            if ([charset characterIsMember:c]) {
                preIsNumber = NO;
                [array addObject:string];
                string = [NSMutableString string];
                [string appendString:[NSString stringWithFormat:@"%c", c]];
            }
            else if ([numberCharSet characterIsMember:c]) {
                preIsNumber = YES;
                [string appendString:[NSString stringWithFormat:@"%c", c]];
            }
        }
        else {
            if ([charset characterIsMember:c]) {
                preIsNumber = NO;
                [string appendString:[NSString stringWithFormat:@"%c", c]];
            }
            else if ([numberCharSet characterIsMember:c]) {
                preIsNumber = YES;
                [array addObject:string];
                string = [NSMutableString string];
                [string appendString:[NSString stringWithFormat:@"%c", c]];
            }
        }
    }
    [array addObject:string];
    return array;
}

- (NSString *)resetStringWithFormat:(NSString *)format withCharSet:(NSCharacterSet *)charset
{
    NSArray *array = [format componentsSeparatedByFormatCharSet:charset];
    __block NSInteger location = 0;
    NSMutableString *str = [NSMutableString string];
    [array enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
        if ([charset characterIsMember:[obj characterAtIndex:0]]) {
            [str appendString:obj];
        }
        else {
            NSRange range;
            if ((location + [obj integerValue]) > self.length) {
                range = NSMakeRange(location, self.length - location);
                location += range.length;
            }
            else {
                range = NSMakeRange(location, [obj integerValue]);
                location += [obj integerValue];
            }
            [str appendString:[self substringWithRange:range]];
            if (location == self.length) {
                *stop = YES;
            }
        }
    }];
    return str;
}

- (NSString *)stringByRemovingCharacterSet:(NSCharacterSet *)charset
{
    NSArray *array = [self componentsSeparatedByCharactersInSet:charset];
    return [array componentsJoinedByString:@""];
}

@end


@implementation NSDictionary(Keys)

- (BOOL)containsKey:(id)obj
{
    return [[self allKeys] containsObject:obj];
}

@end


@implementation UIView(HPDDraw)

- (void)drawLineWithWidth:(CGFloat)lineWidth color:(UIColor *)lineColor formPoint:(CGPoint)point toPoint:(CGPoint)toPoint
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(MIN(point.x, toPoint.x), MIN(point.y, toPoint.y), (ABS(point.x - toPoint.x)>lineWidth?ABS(point.x - toPoint.x):lineWidth), (ABS(point.y - toPoint.y)>lineWidth?ABS(point.y - toPoint.y):lineWidth));
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(point.x-MIN(point.x, toPoint.x), point.y-MIN(point.y, toPoint.y))];
    [path addLineToPoint:CGPointMake(toPoint.x-MIN(point.x, toPoint.x), toPoint.y-MIN(point.y, toPoint.y))];
    layer.path = path.CGPath;
    layer.strokeColor = lineColor.CGColor;
    layer.lineWidth = lineWidth;
    [self.layer addSublayer:layer];
}


@end


@implementation UILabel(HPDLabel)


+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)size alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.textAlignment = alignment;
    label.textColor = defaultObject(textColor, C090909);
    label.backgroundColor = defaultObject(backgroundColor, ClearColor);
    return label;
}

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)size alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor
{
    return [UILabel labelWithFrame:frame text:text fontSize:size alignment:alignment textColor:textColor backgroundColor:nil];
}

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)size alignment:(NSTextAlignment)alignment
{
    return [UILabel labelWithFrame:frame text:text fontSize:size alignment:alignment textColor:nil backgroundColor:nil];
}

@end


@implementation UIButton (HPDButton)


- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)text titleSize:(CGFloat)titleSize titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)bgColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:titleSize];
    
    button.backgroundColor = bgColor;
    
    return button;
}


@end


@implementation NSDate(Interval)

+ (NSTimeInterval)intervalFromDate:(NSString *)fd toDate:(NSString *)td formaterString:(NSString *)format
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:format];
    NSDate *fDate = [formater dateFromString:fd];
    NSDate *tDate = [formater dateFromString:td];
    NSTimeInterval interval = [tDate timeIntervalSinceDate:fDate];
    return interval;
}

+ (NSTimeInterval)intervalFromDate:(NSString *)fd toDate:(NSString *)td formater:(NSDateFormatter *)format
{
    NSDate *fDate = [format dateFromString:fd];
    NSDate *tDate = [format dateFromString:td];
    NSTimeInterval interval = [tDate timeIntervalSinceDate:fDate];
    return interval;
}



+ (NSString *)interval2String:(NSTimeInterval)interval
{
    NSInteger intervalI = (NSInteger)interval;
    NSInteger seconds = intervalI % 60;
    NSInteger minutes = (intervalI / 60) % 60;
    NSInteger hours = intervalI / 3600;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours, (long)minutes, (long)seconds];
}


@end

NSString * interval2String(NSTimeInterval interval);
NSString * interval2String(NSTimeInterval interval) {
    NSInteger intervalI = (NSInteger)interval;
    NSInteger seconds = intervalI % 60;
    NSInteger minutes = (intervalI / 60) % 60;
    NSInteger hours = intervalI / 3600;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours, (long)minutes, (long)seconds];
}

NSTimeInterval interval(NSString *fd, NSString *td, NSString *fromat) ;
NSTimeInterval interval(NSString *fd, NSString *td, NSString *fromat) {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fDate = [formater dateFromString:fd];
    NSDate *tDate = [formater dateFromString:td];
    NSTimeInterval interval = [tDate timeIntervalSinceDate:fDate];
    return interval;
}

NSTimeInterval intervalWithFormat(NSString *fd, NSString *td, NSDateFormatter *fromat) ;
NSTimeInterval intervalWithFormat(NSString *fd, NSString *td, NSDateFormatter *fromat) {
    NSDate *fDate = [fromat dateFromString:fd];
    NSDate *tDate = [fromat dateFromString:td];
    NSTimeInterval interval = [tDate timeIntervalSinceDate:fDate];
    return interval;
}

