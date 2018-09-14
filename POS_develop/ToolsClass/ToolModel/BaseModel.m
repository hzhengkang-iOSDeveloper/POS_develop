//
//  BaseModel.m
//

#import "BaseModel.h"

@implementation BaseModel


#pragma mark - 初始化方法

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        
        // KVC 赋值
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}


#pragma mark - 遍历构造器
+ (instancetype)baseModelWithDictionary:(NSDictionary *)dictionary {
    
    id model = [[[self class] alloc] initWithDictionary:dictionary];
    
    return model;
}

#pragma mark - 数组套字典 -> 数组套model
+ (NSMutableArray *)arrayWithModelByArray:(NSArray *)array {
    // 创建一个可变数组 保存model 返回结果
    NSMutableArray *arr = [NSMutableArray array];
    
    
    // 遍历参数数组
    for (NSDictionary *dictionary in array) {
        
        // 自动释放池
        @autoreleasepool {
            // 创建对象
            id model = [[self class] baseModelWithDictionary:dictionary];
            
            // 添加至数组
            [arr addObject:model];
        }
        
    }
    
    return arr;
}

#pragma mark - KVC容错方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

#pragma mark  只舍不入 position小数点后位数
+(NSString *)notRounding:(double)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

+ (NSString *)boundForDoubleStr:(NSDictionary *)dic withKey:(NSString *)key
{
    CGFloat f1 = [[dic objectForKey:key] doubleValue];
    NSString *s1 = [NSString stringWithFormat:@"%f",f1];
    NSString *str;
    if ([[[dic objectForKey:key]stringValue] containsOnlyNumbers]) {
        str = [NSString stringWithFormat:@"%.2f",f1];
    } else {
        str = [s1 substringToIndex:[s1 rangeOfString:@"."].location+3];
    }
//    str = [BaseModel notRounding:[str doubleValue] afterPoint:2];
    return str;
}
@end
