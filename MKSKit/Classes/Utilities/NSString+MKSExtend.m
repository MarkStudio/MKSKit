//
//  NSString+MKSExtend.m
//  Pods
//
//  Created by Mark Yang on 12/4/15.
//
//

#import "NSString+MKSExtend.h"

@implementation NSString (MKSExtend)

+ (NSString *)stringWithTokenData:(NSData *)deviceTokenData
{
    NSMutableString *deviceID = [NSMutableString string];
    unsigned char *ptr = (unsigned char *)[deviceTokenData bytes];
    for (NSInteger i = 0; i < 32; i++) {
        [deviceID appendString:[NSString stringWithFormat:@"%02x", ptr[i]]];
    }
    
    return [deviceID copy];
}//

@end
