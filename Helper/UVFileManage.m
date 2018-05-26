//
//  UVFileManage.m
//  UVCocoaLibrary
//
//  Created by selectersky on 15/11/10.
//  Copyright © 2015 Selectersky. All rights reserved.
//

#import "UVFileManage.h"

@implementation UVFileManage

- (BOOL)valid:(NSString*)full_ realSize:(float)size_
{
    //判断文件是否有效
    NSError *error;
    NSFileManager *m = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    if(![m fileExistsAtPath:full_ isDirectory:&isDirectory])
    {
        return NO;
    }
    if(isDirectory)
    {
        return NO;
    }
    
    NSDictionary *attr = [m attributesOfItemAtPath:full_ error:&error];
    if(error)
    {
        return NO;
    }
    NSNumber  *size = attr[NSFileSize];
    if(size.floatValue <= 0.f)
    {
        return NO;
    }
    if(size.floatValue != size_ && size_ > 0)
    {
        return NO;
    }

    return YES;
}

- (NSString*)formatFileSize:(double)size_
{
    NSString *f;
    if (size_ > 1024 * 1024 * 1024)
    {
        f = [NSString stringWithFormat:@"%.2fG", size_ / 1024 / 1024 / 1024];
    }
    else if (size_ > 1024 * 1024)
    {
        f = [NSString stringWithFormat:@"%.2fM", size_ / 1024 / 1024];
    }
    else
    {
        f = [NSString stringWithFormat:@"%.2fK", size_ / 1024];
    }
    return f;
}
@end
