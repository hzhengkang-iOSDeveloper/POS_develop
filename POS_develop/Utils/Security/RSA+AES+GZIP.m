//
//  RSA+AES+GZIP.m
//  HePanDai2_0
//
//  Created by 123 on 2017/3/20.
//  Copyright © 2017年 HePanDai. All rights reserved.
//

#import "RSA+AES+GZIP.h"
#import "NSData+AES.h"
#import "LFCGzipUtillity.h"
#import "RSA.h"
static NSString *base64_encode_data(NSData *data){
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

static NSData *base64_decode(NSString *str){
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}
@implementation RSA_AES_GZIP
{
    NSString *pubkey;
    NSString *privkey;
}
- (NSString *)returnencryptStringtoString:(NSString *)paramStr andisEncrypt:(NSString *)isEncrypt andisCompress:(NSString *)isCompress{
    //pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkAX4r9mfA1h7go5pDIdIYNDDMs6UEteiDsHK09xEsLKXXh/Dp+9dfJYbapemtlSXsA14UnDIatTDSdBi5oDj7OwkQW5QIyLi351h4JZG+giyp//\n2VWJ1yfBgTmCXJxjttCTdEsfNSMc+Pero0M9jdPJhrwDP3GERoVysrKnKUGQIDAQAB\n-----END PUBLIC KEY-----";
    
    pubkey = @"-----BEGIN PUBLIC KEY----- \nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDqGTLvHhU2DxuVmO4oupNZi1ay\nblmCNwnYrHxfjBmJ66SSC17WvatB3jFfDYQ+AVrF5G6OTDqr4wYrItctFwWWgScg CFM6qpKJunBBIIJaJU9N76BWVIsv9oi35rGVwsO2RGOevyxk/3z228gOtOx1K7y+\ntcyR1N9zfJENZ6VwTQIDAQAB \n-----END PUBLIC KEY-----";
    //随机16位AES key
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 16; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    NSString *returnStr = @"";
    returnStr = paramStr;
    NSLog(@"%@", string);
    if ([isCompress isEqualToString:@"true"]) {
        NSString *GzipStr = [self GzipWith:returnStr];
        GzipStr = [GzipStr stringByReplacingOccurrencesOfString:@"+" withString:@"_-"];
        GzipStr = [GzipStr stringByReplacingOccurrencesOfString:@"/" withString:@"!_"];
        returnStr = GzipStr;
    }
    if ([isEncrypt isEqualToString:@"true"]) {
      
        //RSA加密AES key
        NSString *str1 = [self encryptString:string publicKey:pubkey];
        NSString *str2 = [self AESEncryptWith:returnStr with:string] ;
        returnStr = [NSString stringWithFormat:@"%@%@",str1,str2];
        returnStr = [returnStr stringByReplacingOccurrencesOfString:@"+" withString:@"_-"];
        returnStr = [returnStr stringByReplacingOccurrencesOfString:@"/" withString:@"!_"];
    }
    return returnStr;
}
- (NSString *)returndecryptStringtoString:(NSString *)paramStr andisEncrypt:(BOOL)isEncrypt andisCompress:(BOOL)isCompress{

    privkey = @"-----BEGIN RSA PRIVATE KEY-----\nMIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALZkLU+A+YVA2cNMF0tvTHR5hyqTXYNftR1G3Z325xQAZoIsw8M2a+IjnInYlF5exroOzUSEhi4vVSNy63FrwUfC//DyMOTg1TIAOH0Inr07UmLLKeiGdHzgGvqZe63TxMeheDFv5INQZoYiA5LxLbYsAG4otEbL3GMEKidl6eoJAgMBAAECgYAGscBq/lzKLAeXcDPGWEWvXGWJEG3FJw5hTnWkY7NMC+QMoO180lgdLaREIp+heMDlA9WQufzTIE1zlrchtiwwG6CbuA0Ip/zUgypfv7Ui+IcP5yuEB+0ddrdhFfImXfGdFJHLM9aszuwSgeTrv2a7ZznyrGLuFWEpDpMMh1E37QJBAMyWtqd/jOFG0iTtLZsKLRDEgiQFaO0KUSma6x25KspI55CVgjeMCh8P271sZqrXYjjoBER3dAroMKlZiXEFfg0CQQDkOX55+PAWmVPW+m9tWByWXFfqHr0nyfded38ZXHgDDleUxSha1PoMDsFidfPqDMXG8bh19bvLdI3EkKBCTxjtAkAQXgJQ1iB0KVFIiPz8CU1fqQjsTs59IDUsCevDXfvxYPG9nGhlfzuUDpW6ysBP7Jk8CjvFKnVLJhY2hiY7t3/FAkAl1D3Zm+C37jxOYv57QmKirbXI0cWKxdhh6S7BFmmyH/t2ZmO1Ap5bx0pYtrJydiGGQ2TO8KdrJuukzFA0DYZVAkBIMT7smas/ceSzXTDrbHQM0w/jwiV6NMHjK7HToeupeiRXyRS+ATQ0HTTitDYjbxcuOg1S33t+lTB7ppFvQSow\n-----END RSA PRIVATE KEY-----";
    NSString *str4 = paramStr;
    if (isEncrypt) {
        str4 = [str4 stringByReplacingOccurrencesOfString:@"!_" withString:@"/"];
        str4 = [str4 stringByReplacingOccurrencesOfString:@"_-" withString:@"+"];
       NSString * str1 = [str4 substringToIndex:172];
       NSString* str2 = [self decryptString:str1 privateKey:privkey];
       NSString *str3 = [str4 stringByReplacingOccurrencesOfString:str1 withString:@""];
        str4 = [self AESDescrptWith:str3 with:str2];
        NSLog(@"%@",str4);
    }
    if (isCompress) {
        str4 = [str4 stringByReplacingOccurrencesOfString:@"!_" withString:@"/"];
        str4 = [str4 stringByReplacingOccurrencesOfString:@"_-" withString:@"+"];
        str4 = [self uncompressWith:str4];
        NSLog(@"%@",str4);
    }
    return str4;
}

- (NSString *)getAppRequestIdentifier{
    //pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC2fNqcQbdJXEzIc98HEQw+XztRueTssnv+Raof2P4M1TA93LsGgAuBxDlT2gPRj8FSfR6T/i605oS4/\nTnQoGLZwNPJjVCqDudC6TMQ0jJW1+JwfdoMPWmtGEiYKTo3ci7BCsesq\nHht4HXz5OGEucr43oFNLFbCAZjIw8zcXvkVMwIDAQAB\n-----END PUBLIC KEY-----";
    
    // privkey = @"-----BEGIN RSA PRIVATE KEY-----\nMIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBALZ82pxBt0lcTMhz\n3wcRDD5fO1G55Oyye/5Fqh/Y/gzVMD3cuwaAC4HEOVPaA9GPwVJ9HpP\n+LrTmhLj9OdCgYtnA08mNUKoO50LpMxDSMlbX4nB92gw9aa0YSJgpOjdyLsEKx6yoe\nG3gdfPk4YS5yvjegU0sVsIBmMjDzNxe\n+RUzAgMBAAECgYAO5aZa9yplPLmv63WbeBLNzKxlAY3knLVujnVS4D3tAkJL6ocCAt\nXto/0iETwakWewujIS1r8tWVwgVduwYkdvZ/\niXUGoLcW05K1NrhBqa8y8y1ZHAcsMGzELsQVVJfEFJUIFN65+WfEa2xQ2qkDRLpU\ns3CRgUoq7TWn\n+UchaSMQJBANx5wyXstNmaUYCAvwIl0lfL3A07C3U1B2W11sXQWmPjjF789P3nBawO\nN5oKbqfJUMUvO7xaWinGUotquC59qg8CQQDT5CfZ4SQ5AEIO/\nyCMq20ozUWkLQW74qcSSZ18/\nNIq95VvR325Ctio6Vw4QNqlcMXJLX6eD3aLYgLu1yNwjZadAkEAjFvQCsLI14dQv5g3Aa0GXfJgYuPmBXX/\nAZdj5YchJFpmsMolRcbfa4uZhi2CCLs2+nF5fA2hPNsPDcag/\nqftrQJBAI6Jbl1c3HcTu1xHN2gpcVb/\nLxfPyYmoYGcm6jBICkEpJ3ciCmrN5w1JXeXhirO79vDsD77X/BCrL/\nnm80ollOkCQQCq9DB7vO2xivuYUtYCZm\n+C2xgMST24dhONFWLUyP2bTlmLCo4wZRcyRf/bpSu4dW288wF02ZZ51qjsEEafzEwB\n-----END RSA PRIVATE KEY-----";
    
    //RSA加密公钥
    pubkey = @"-----BEGIN PUBLIC KEY----- MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDqGTLvHhU2DxuVmO4oupNZi1ay blmCNwnYrHxfjBmJ66SSC17WvatB3jFfDYQ+AVrF5G6OTDqr4wYrItctFwWWgScg CFM6qpKJunBBIIJaJU9N76BWVIsv9oi35rGVwsO2RGOevyxk/3z228gOtOx1K7y+ tcyR1N9zfJENZ6VwTQIDAQAB -----END PUBLIC KEY-----";
    
    //随机16位AES key
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 16; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    NSLog(@"%@", string);
    
    //RSA加密AES key
    NSString *str1 = [self encryptString:string publicKey:pubkey];
    NSDictionary *dict = @{@"time":[self getCurrentStandarTime],@"bundleID":@"com.hepanlicai.hepanlicai"};
    
    //AES加密词典
    NSString *str2 = [self AESEncryptWith:[self GlobalStringWithDictionary:dict] with:string] ;
    
    //拼接字符串
    return [NSString stringWithFormat:@"%@%@",str1,str2];
    
}

//压缩
- (NSString *)GzipWith:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data1 = [LFCGzipUtillity gzipData:data];
    return base64_encode_data(data1);
}
//解压
- (NSString *)uncompressWith:(NSString *)str
{
    NSData *data = base64_decode(str);
    NSData* data1 = [LFCGzipUtillity uncompressZippedData:data];
    NSString* str1 = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    return str1;
    
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *data1 = [LFCGzipUtillity uncompressZippedData:data];
//    return base64_encode_data(data1);
}
//AES加密
- (NSString *)AESEncryptWith:(NSString *)str with:(NSString *)AESKey
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data2 = [data AES128EncryptWithKey:AESKey];
    NSLog(@"AES加密:%@",base64_encode_data(data2));
    return base64_encode_data(data2);
}
//AES解密
- (NSString *)AESDescrptWith:(NSString *)str with:(NSString *)AESKey
{
    NSData *data2 = [base64_decode(str) AES128DecryptWithKey:AESKey];
    return [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
}
-(NSString*)GlobalStringWithDictionary:(NSDictionary*)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (NSString *)getCurrentStandarTime
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

- (NSData *)stripPublicKeyHeader:(NSData *)d_key{
    // Skip ASN.1 public key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx	 = 0;
    
    if (c_key[idx++] != 0x30) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30,   0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);
    
    idx += 15;
    
    if (c_key[idx++] != 0x03) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    if (c_key[idx++] != '\0') return(nil);
    
    // Now make a new NSData from this buffer
    return([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

//credit: http://hg.mozilla.org/services/fx-home/file/tip/Sources/NetworkAndStorage/CryptoUtils.m#l1036
- (NSData *)stripPrivateKeyHeader:(NSData *)d_key{
    // Skip ASN.1 private key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx	 = 22; //magic byte at offset 22
    
    if (0x04 != c_key[idx++]) return nil;
    
    //calculate length of the key
    unsigned int c_len = c_key[idx++];
    int det = c_len & 0x80;
    if (!det) {
        c_len = c_len & 0x7f;
    } else {
        int byteCount = c_len & 0x7f;
        if (byteCount + idx > len) {
            //rsa length field longer than buffer
            return nil;
        }
        unsigned int accum = 0;
        unsigned char *ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount) {
            accum = (accum << 8) + *ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }
    
    // Now make a new NSData from this buffer
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}

- (SecKeyRef)addPublicKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [self stripPublicKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PubKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

- (SecKeyRef)addPrivateKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END RSA PRIVATE KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [self stripPrivateKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PrivKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *privateKey = [[NSMutableDictionary alloc] init];
    [privateKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)privateKey);
    
    // Add persistent version of the key to system keychain
    [privateKey setObject:data forKey:(__bridge id)kSecValueData];
    [privateKey setObject:(__bridge id) kSecAttrKeyClassPrivate forKey:(__bridge id)
     kSecAttrKeyClass];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [privateKey removeObjectForKey:(__bridge id)kSecValueData];
    [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

/* START: Encryption & Decryption with RSA private key */

- (NSData *)encryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef{
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    void *outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyEncrypt(keyRef,
                               kSecPaddingPKCS1,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            [ret appendBytes:outbuf length:outlen];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

- (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey{
    NSData *data = [self encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] privateKey:privKey];
    NSString *ret = base64_encode_data(data);
    return ret;
}

- (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey{
    if(!data || !privKey){
        return nil;
    }
    SecKeyRef keyRef = [self addPrivateKey:privKey];
    if(!keyRef){
        return nil;
    }
    return [self encryptData:data withKeyRef:keyRef];
}

- (NSData *)decryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef{
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    UInt8 *outbuf = malloc(block_size);
    size_t src_block_size = block_size;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyDecrypt(keyRef,
                               kSecPaddingNone,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            //the actual decrypted data is in the middle, locate it!
            int idxFirstZero = -1;
            int idxNextZero = (int)outlen;
            for ( int i = 0; i < outlen; i++ ) {
                if ( outbuf[i] == 0 ) {
                    if ( idxFirstZero < 0 ) {
                        idxFirstZero = i;
                    } else {
                        idxNextZero = i;
                        break;
                    }
                }
            }
            
            [ret appendBytes:&outbuf[idxFirstZero+1] length:idxNextZero-idxFirstZero-1];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}


- (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [self decryptData:data privateKey:privKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

- (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey{
    if(!data || !privKey){
        return nil;
    }
    SecKeyRef keyRef = [self addPrivateKey:privKey];
    if(!keyRef){
        return nil;
    }
    return [self decryptData:data withKeyRef:keyRef];
}

/* END: Encryption & Decryption with RSA private key */

/* START: Encryption & Decryption with RSA public key */

- (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey{
    NSData *data = [self encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] publicKey:pubKey];
    NSString *ret = base64_encode_data(data);
    return ret;
}

- (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey{
    if(!data || !pubKey){
        return nil;
    }
    SecKeyRef keyRef = [self addPublicKey:pubKey];
    if(!keyRef){
        return nil;
    }
    return [self encryptData:data withKeyRef:keyRef];
}

- (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [self decryptData:data publicKey:pubKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

- (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey{
    if(!data || !pubKey){
        return nil;
    }
    SecKeyRef keyRef = [self addPublicKey:pubKey];
    if(!keyRef){
        return nil;
    }
    return [self decryptData:data withKeyRef:keyRef];
}

@end
