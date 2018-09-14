


#import "MyKeyChainHelper.h"

@implementation MyKeyChainHelper

+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)service {  
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:  
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,  
            service, (id)kSecAttrAccount,  
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,  
            nil];  
}  

+ (void) saveUserName:(NSString*)userName 
      userNameService:(NSString*)userNameService 
             psaaword:(NSString*)pwd 
      psaawordService:(NSString*)pwdService
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];  
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:userName] forKey:(id)kSecValueData];  
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL); 
    
    keychainQuery = [self getKeyChainQuery:pwdService];  
    SecItemDelete((CFDictionaryRef)keychainQuery);  
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:pwd] forKey:(id)kSecValueData];  
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL); 
}

+ (void) deleteWithUserNameService:(NSString*)userNameService 
                   psaawordService:(NSString*)pwdService
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];  
    SecItemDelete((CFDictionaryRef)keychainQuery); 
    
    keychainQuery = [self getKeyChainQuery:pwdService];  
    SecItemDelete((CFDictionaryRef)keychainQuery); 
}

+ (NSString*) getUserNameWithService:(NSString*)userNameService
{
    NSString* ret = nil;  
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];  
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];  
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];  
    CFDataRef keyData = NULL;  
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) 
    {  
        @try 
        {  
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)CFBridgingRelease(keyData)];
        } 
        @catch (NSException *e) 
        {  
            NSLog(@"Unarchive of %@ failed: %@", userNameService, e);  
        }
        @finally 
        {  
        }  
    }  
    if (keyData)   
        CFRelease(keyData);  
    return ret; 
}

+ (NSString*) getPasswordWithService:(NSString*)pwdService
{
    NSString* ret = nil;  
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:pwdService];  
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];  
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];  
    CFDataRef keyData = NULL;  
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) 
    {  
        @try 
        {  
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)CFBridgingRelease(keyData)];
        } 
        @catch (NSException *e) 
        {  
            NSLog(@"Unarchive of %@ failed: %@", pwdService, e);  
        }
        @finally 
        {  
        }  
    }  
    if (keyData)   
        CFRelease(keyData);  
    return ret;
}

+ (void)savePassword:(NSString *)password withAccount:(NSString *)account
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:account];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:password] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}


+ (void)deletePasswordWithAccount:(NSString *)account
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:account];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}
@end
