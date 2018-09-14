
//
//  UIAlertView+Blocks.m
//  UIKitCategoryAdditions
//

#import "UIAlertView+Blocks.h"

static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;

@implementation UIAlertView (Blocks)

+ (UIAlertView*) showAlertViewWithTitle:(NSString*) title
                                message:(NSString*) message
                      cancelButtonTitle:(NSString*) cancelButtonTitle
                      otherButtonTitles:(NSArray*) otherButtons
                              onDismiss:(DismissBlock) dismissed
                               onCancel:(CancelBlock) cancelled {
    
    _cancelBlock  = [cancelled copy];
    
    _dismissBlock  = [dismissed copy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self self]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    for(NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
    return alert;
}

+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
	if(buttonIndex == [alertView cancelButtonIndex]) {
        
		_cancelBlock ? _cancelBlock() : nil;
	}
    else {
        _dismissBlock ? _dismissBlock(buttonIndex - 1) : nil; // cancel button is button 0
    }  
}

+ (void) showMessage:(NSString*) message
{
    [UIAlertView showAlertViewWithTitle:@"提示" message:message cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(NSInteger buttonIndex) {
        
    } onCancel:^{
        
    }];
}

+ (void) showMessage:(NSString *)msg withCancle:(CancelBlock)cancle
{
    [UIAlertView showAlertViewWithTitle:@"提示" message:msg cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(NSInteger buttonIndex) {
        
    } onCancel:cancle];
}


@end