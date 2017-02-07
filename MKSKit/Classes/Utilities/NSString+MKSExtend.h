//
//  NSString+MKSExtend.h
//  Pods
//
//  Created by Mark Yang on 12/4/15.
//
//

#import <Foundation/Foundation.h>

@interface NSString (MKSExtend)

// for test
+ (NSString *)mksHelloString;

/**
 *	@brief	根据APNS Token转换成相应字符串
 *
 *	@param 	deviceTokenData
 *
 *	@return	APNS Token String
 *
 *	Created by Mark on 2015-12-04 16:52
 */
+ (NSString *)stringWithTokenData:(NSData *)deviceTokenData;

#pragma mark -
#pragma mark DES Encrypt

/**
 *	@brief	根据指定DES_KEY加密指定明文
 *
 *	@param 	plainText 	明文信息
 *	@param 	key 	DES_KEY值
 *
 *	@return	DES加密后密文
 *
 *	Created by Mark on 2015-05-25 09:07
 */
+ (NSString *)mksEncryptUseDES:(NSString *)plainText key:(NSString *)key;

/**
 *	@brief	根据指定DES_KEY解密指定密文
 *
 *	@param 	cipherText 	密文信息
 *	@param 	key 	DES_KEY值
 *
 *	@return	DES解密后明文
 *
 *	Created by Mark on 2015-05-25 09:07
 */
+ (NSString *)mksDecryptUseDES:(NSString*)cipherText key:(NSString*)key;

#pragma mark -
#pragma mark AES Encrypt

+ (NSString *)AES256EncryptPlainText:(NSString *)plainText withKey:(NSString *)key;     //加密
- (NSString *)AES256DecryptCipherText:(NSString *)cipherText WithKey:(NSString *)key;   //解密

#pragma mark -
#pragma mark MD5 Encrypt

/**
 *	@brief	Get MD5 encrpyt string (Lowercase)
 *
 *	@return	MD5 string
 *
 *	Created by Mark on 2014-12-18 14:01
 */
- (NSString *)mksLowercaseMD5;

/**
 *	@brief	Get MD5 encrpyt string (Uppercase)
 *
 *	@return	MD5 string
 *
 *	Created by Mark on 2014-12-18 14:01
 */
- (NSString *)mksUppercaseMD5;

@end


#pragma mark - Pinyin

@interface NSString (MKSPinyin)

- (NSString *)mksPinyinString;
- (NSString *)mksContactPinyinString;

@end
