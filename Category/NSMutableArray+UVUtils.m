//
//  NSMutableArray+UVUtils.m
//  UVCocoaLibrary
//
//  Created by selectersky on 15/9/10.
//  Copyright (c) 2015 Selectersky. All rights reserved.
//

#import "NSMutableArray+UVUtils.h"

@implementation NSMutableArray (UVUtils)

- (void)uv_randromSort
{
    int count = (int)[self count];
    for (int i = 0; i < count; ++i)
    {
        int n = (arc4random() % (count - i)) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}
@end
