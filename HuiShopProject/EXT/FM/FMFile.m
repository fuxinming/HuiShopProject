//
//  FMFile.m
//  FMBaseProject
//
//  Created by shanjin on 16/9/18.
//  Copyright © 2016年 付新明. All rights reserved.
//

#import "FMFile.h"

@implementation FMFile

+ (NSString *)fileHomeDir{
    NSString *path = NSHomeDirectory();
    return path;
}

+ (NSString *)fileResourceDir{
    NSString *path = [[NSBundle mainBundle] resourcePath];
    return path;
}

+ (NSString *)fileResourceDir:(NSString *)path{
    NSString *resPath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resPath stringByAppendingPathComponent:path];
    return filePath;
}

+ (NSString *)fileDocDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return docDir;
}

+ (NSString *)fileDocDir:(NSString *)path {
    NSString *docDir = [FMFile fileDocDir];
    NSString *filePath = [docDir stringByAppendingPathComponent:path];
    return filePath;
}

+ (NSString *)fileCacheDir{
    NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cache objectAtIndex:0];
    return cachePath;
}

+ (NSString *)fileCacheDir:(NSString *)path{
    NSString *cacheDir = [FMFile fileCacheDir];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:path];
    return filePath;
}

+ (NSString *)fileTempDir {
    return NSTemporaryDirectory();
}

+ (NSString *)fileTempDir:(NSString *)path {
    NSString *tempDir = [FMFile fileTempDir];
    NSString *filePath = [tempDir stringByAppendingPathComponent:path];
    return filePath;
}

+ (NSData *)readFileFromDir:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *data = [fileManager contentsAtPath:path];
    return data;
}

+ (BOOL)fileCreateDir:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
    if (!success) {
        NSLog(@"fileCreateDir Error : %@", [error localizedDescription]);
    }
    return success;
}

+ (BOOL)fileExistAtPath:(NSString *)path {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    return [filemanager fileExistsAtPath:path];
}

+ (BOOL)fileWriteAtPath:(NSString *)path data:(NSData *)data {
    return [data writeToFile:path atomically:NO];
}

+ (BOOL)fileDel:(NSString *)path {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSError *error;
    if ([FMFile fileExistAtPath:path]) {
        BOOL success = [filemanager removeItemAtPath:path error:&error];
        if (!success) {
            NSLog(@"fileDel Error : %@", [error localizedDescription]);
        }
        return success;
    }
    return YES;
}

+ (NSArray *)fileSubFileNames:(NSString *)path{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *names = [filemanager contentsOfDirectoryAtPath:path error:&error];
    if (nil == names) {
        NSLog(@"fileSubFileNames Error : %@", [error localizedDescription]);
    }
    return names;
}

+ (BOOL)fileCopy:(NSString *)fromPath toPath:(NSString *)toPath{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [filemanager copyItemAtPath:fromPath toPath:toPath error:&error];
    if (!success) {
        NSLog(@"fileCopy Error : %@", [error localizedDescription]);
    }
    return success;
}

@end
