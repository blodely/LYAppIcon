//
//  IAFileMgr.h
//  iOSAppIcon
//
//  Created by Luo Yu on 2018/7/23.
//  Copyright © 2018 Luo Yu. All rights reserved.
//  Mozilla Public License Version 2.0
//

#import <Foundation/Foundation.h>

@interface IAFileMgr : NSObject

+ (instancetype)manager;

- (NSString *)currentDirectory;

- (BOOL)hasFileInCurrentDirectory;

- (NSArray *)filenamesInCurrentDirectory;

@end
