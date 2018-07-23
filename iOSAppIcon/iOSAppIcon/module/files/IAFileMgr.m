//
//  IAFileMgr.m
//  iOSAppIcon
//
//  Created by Luo Yu on 2018/7/23.
//  Copyright © 2018 Luo Yu. All rights reserved.
//  Mozilla Public License Version 2.0
//

#import "IAFileMgr.h"

@implementation IAFileMgr

+ (instancetype)manager {
	static IAFileMgr *sharedMgr;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedMgr = [[IAFileMgr alloc] init];
	});
	return sharedMgr;
}

// MARK: - METHODS

- (NSString *)currentDirectory {
	return [[NSFileManager defaultManager] currentDirectoryPath];
}

- (BOOL)hasFileInCurrentDirectory {
	return [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[NSFileManager defaultManager] currentDirectoryPath] error:NULL] count] > 0;
}

- (NSArray *)filenamesInCurrentDirectory {
	return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[NSFileManager defaultManager] currentDirectoryPath] error:NULL];
}

@end
