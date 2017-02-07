//
//  NSDictionary+MKSExtend.m
//  Pods
//
//  Created by Mark Yang on 20/12/2016.
//
//

#import "NSDictionary+MKSExtend.h"

@implementation NSDictionary (MKSExtend)

+ (NSDictionary *)mksDictionaryFromQuery:(NSString *)query encoding:(NSStringEncoding)encoding
{
    // character <;> is must be, comment by mark 16-12-20
    NSCharacterSet *delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary *pairs = [NSMutableDictionary dictionary];
    NSScanner *scanner = [[NSScanner alloc] initWithString:query];
    while (![scanner isAtEnd]) {
        NSString *pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray *kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString *key = [kvPair[0] stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString *value = [kvPair[1] stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
//            // 创建
//            self.<#var#> = [NSTimer scheduledTimerWithTimeInterval:1.5
//                                                            target:self
//                                                          selector:@selector(<#handle#>)
//                                                          userInfo:nil
//                                                           repeats:YES];
//            // 取消
//            [self.<#var#> invalidate];
//            
//            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                     selector:@selector(<#handle#>)
//                                                         name:<#name#>
//                                                       object:nil];
//            [[NSNotificationCenter defaultCenter] removeObserver:self];
//            // post notification
//            [[NSNotificationCenter defaultCenter] postNotificationName:<#name#>
//                                                                object:self
//                                                              userInfo:<#userInfo#>];
//            [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                            name:<#name#>
//                                                          object:<#(nullable id)#>];
//            // should remove in observer
//            - (void)handleNotification:(NSNotification *)noti
//            {
//                <#handle block#>
//            }
            

            

            

            
        }
    }
    
    return [pairs copy];
}//

@end
