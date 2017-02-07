//
//  MemoryWarningTest.h
//  Pods
//
//  Created by Mark Yang on 07/02/2017.
//
//

#import <Foundation/Foundation.h>

@interface MemoryWarningTest : NSObject

+ (instancetype)sharedInstance;

#pragma mark -

/**
 *	@brief	Invoke private API to simulate Memory Warning in physics device.
 *          If you use simulator, use Hardware -> Simulate Memory Warning to do the test.
 *
 *	@return N/A
 *
 *	Created by Mark on 2017-02-07 09:54
 */
- (void)simulateMemoryWarning;

@end
