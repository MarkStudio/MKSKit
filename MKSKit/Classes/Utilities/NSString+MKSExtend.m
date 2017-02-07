//
//  NSString+MKSExtend.m
//  Pods
//
//  Created by Mark Yang on 12/4/15.
//
//

#import "NSString+MKSExtend.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

@implementation NSString (MKSExtend)

+ (NSString *)mksHelloString
{
    return @"Hello NSString+MKSExtend";
}//

+ (NSString *)stringWithTokenData:(NSData *)deviceTokenData
{
    NSMutableString *deviceID = [NSMutableString string];
    unsigned char *ptr = (unsigned char *)[deviceTokenData bytes];
    for (NSInteger i = 0; i < 32; i++) {
        [deviceID appendString:[NSString stringWithFormat:@"%02x", ptr[i]]];
    }
    
    return [deviceID copy];
}//

#pragma mark -
#pragma mark DES Encrypt

+ (NSString *)mksEncryptUseDES:(NSString *)plainText key:(NSString *)key
{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte iv[] = {1,2,3,4,5,6,7,8};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          textBytes,
                                          dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data]
                                           encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    
    return ciphertext;
}

// 解密
+ (NSString *)mksDecryptUseDES:(NSString*)cipherText key:(NSString*)key
{
    NSData *cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString *plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer
                                      length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data
                                          encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    
    return plainText;
}

#pragma mark -
#pragma mark AES Encrypt

+ (NSString *)AES256EncryptPlainText:(NSString *)plainText withKey:(NSString *)key
{
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          textBytes,
                                          dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        NSString *ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data]
                                                     encoding:NSUTF8StringEncoding];
        
        return ciphertext;
    }
    free(buffer);
    
    return nil;
}//

- (NSString *)AES256DecryptCipherText:(NSString *)cipherText WithKey:(NSString *)key
{
    NSData *cipherData = [GTMBase64 decodeString:cipherText];
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [cipherData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [cipherData bytes],
                                          dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    NSString *plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer
                                            length:numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data
                                          encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    
    return plainText;
}//

#pragma mark -
#pragma mark MD5 Encrypt

- (NSString *)mksLowercaseMD5
{
    NSString *md5string = [NSString string];
    const char *cStr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)[self length], buffer);
    
    int i;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        md5string = [md5string stringByAppendingString:[NSString stringWithFormat:@"%02x", buffer[i]]];
    
    return md5string;
}//

- (NSString *)mksUppercaseMD5
{
    return [[self lowercaseString] uppercaseString];
}

@end

#pragma mark - Pinyin

@implementation NSString (MKSPinyin)

- (NSString *)mksPinyinString
{
    if (self.length < 1 || nil == self) {
        return nil;
    }
    
    NSMutableString *pinyin = [self mutableCopy];
//    CFStringTransform((__bridge CFMutableStringRef)pinyin, 0, kCFStringTransformMandarinLatin, NO);
//    CFStringTransform((__bridge CFMutableStringRef)pinyin, 0, kCFStringTransformStripDiacritics, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, 0, kCFStringTransformToLatin, NO);    // 可转非汉字
    return [pinyin copy];
}//

- (NSString *)mksContactPinyinString
{
    NSString *strTMP = [self mksPinyinString];
    return [strTMP familyLeach];
}//

- (NSString *)familyLeach
{
    NSString *firstChar = [self substringWithRange:NSMakeRange(0, 1)];
    if ([firstChar isEqualToString:@"曾"]) {
        // zeng、ceng
        return [self stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@"zeng"];
    }
    else if ([firstChar isEqualToString:@"仇"]) {
        // chou、qiu
        return [self stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@"qiu"];
    }
    
    return self;
}//

@end

