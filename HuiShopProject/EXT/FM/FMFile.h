//
//  FMFile.h
//  FMBaseProject
//
//  Created by shanjin on 16/9/18.
//  Copyright © 2016年 付新明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMFile : NSObject
/**
 *	@brief	应用程序沙盒主目录.
 *
 *	@return	主目录路径.
 */
+ (NSString *)fileHomeDir;

/**
 *	@brief	Resource目录.
 *
 *	@return	Resource目录路径.
 */
+ (NSString *)fileResourceDir;

/**
 *	@brief	Resource + path路径.
 *
 *	@param 	path 	相对路径.
 *
 *	@return	Resource + path完整路径.
 */
+ (NSString *)fileResourceDir:(NSString *)path;

/**
 *	@brief	Documents目录.
 *
 *	@return	Documents目录路径.
 */
+ (NSString *)fileDocDir;

/**
 *	@brief	Documents + path路径.
 *
 *	@param 	path 	相对路径.
 *
 *	@return	Documents + path完整路径.
 */
+ (NSString *)fileDocDir:(NSString *)path;

/**
 *	@brief	Caches目录.
 *
 *	@return	Caches目录路径.
 */
+ (NSString *)fileCacheDir;

/**
 *	@brief	Caches + path路径.
 *
 *	@param 	path 	相对路径.
 *
 *	@return	Caches + path完整路径.
 */
+ (NSString *)fileCacheDir:(NSString *)path;

/**
 *	@brief	tmp目录.
 *
 *	@return	tmp目录路径.
 */
+ (NSString *)fileTempDir;

/**
 *	@brief	tmp + path路径.
 *
 *	@param 	path 	相对路径.
 *
 *	@return	tmp + path完整路径.
 */
+ (NSString *)fileTempDir:(NSString *)path;

/**
 *	@brief	读取本地路径数据.
 *
 *	@param 	path 	相对路径.
 *
 *	@returndata.
 */
+ (NSData *)readFileFromDir:(NSString *)path;

/**
 *	@brief	创建path目录或文件.
 *
 *	@param 	path 	目录或文件路径.
 *
 *	@return	是否创建成功.
 */
+ (BOOL)fileCreateDir:(NSString *)path;

/**
 *	@brief	目录或文件是否存在.
 *
 *	@param 	path 	目录或文件路径.
 *
 *	@return	目录或文件是否存在.
 */
+ (BOOL)fileExistAtPath:(NSString *)path;

/**
 *	@brief	保存data到path目录.
 *
 *	@param 	path 	保存目录.
 *	@param 	data 	待保存数据.
 *
 *	@return 写文件是否成功.
 */
+ (BOOL)fileWriteAtPath:(NSString *)path data:(NSData *)data;

/**
 *	@brief	删除目录或文件.
 *
 *	@param 	path 	待删除目录或文件.
 *
 *	@return	目录或文件是否删除成功.
 */
+ (BOOL)fileDel:(NSString *)path;

/**
 *	@brief	查询path目录子文件名称.
 *
 *	@param 	path 	待查询目录.
 *
 *	@return	子文件名称列表(注: 可能包含系统隐藏文件, ".DS_Store").
 */
+ (NSArray *)fileSubFileNames:(NSString *)path;

/**
 *	@brief	拷贝fromPath文件或目录到toPath目录下.
 *
 *	@param 	fromPath 	源文件或目录.
 *	@param 	toPath 	保存文件或目录路径.
 *
 *	@return	是否拷贝成功.
 */
+ (BOOL)fileCopy:(NSString *)fromPath toPath:(NSString *)toPath;
@end
