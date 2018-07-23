//
//  main.m
//  iOSAppIcon
//
//  Created by Luo Yu on 2018/7/19.
//  Copyright © 2018 Luo Yu. All rights reserved.
//  Mozilla Public License Version 2.0
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "NSImage+Resize.h"
#import "IAFileMgr.h"


int main(int argc, const char * argv[]) {
	@autoreleasepool {
	    // insert code here...
	    NSLog(@"\n\n\n\tWELCOME TO iOS APP ICON EXPORTER\n\n.");
		
		NSFileManager *mgr = [NSFileManager defaultManager];
		
		NSString *directory = [mgr currentDirectoryPath];
		
		NSArray *contents = [mgr contentsOfDirectoryAtPath:directory error:NULL];
		
		if ([contents count] == 0) {
			NSLog(@"SOMETHING WENT WRONG.");
		} else {
			NSLog(@"\n\nLIST OF FILES: %@", contents);
		}
		
		NSArray *targetSize = @[
								@20, @40, @60,
								@29, @58, @87,
								@80, @120,
								@180,
								@76, @152,
								@167,
								];
		
		for (NSString *one in contents) {
			if ([one hasSuffix:@".png"]) {
				
				// READ A PNG FILE
				
				// CHECK SIZE
				NSImage *image = [[NSImage alloc] initWithContentsOfFile:[directory stringByAppendingFormat:@"/%@", one]];
				
				if (image.size.width == 1024 && image.size.height == 1024) {
					NSLog(@"\n\nGOT A RIGHT IMAGE");

					
					for (NSNumber *side in targetSize) {
						CGSize size = (CGSize){(CGFloat)[side integerValue], (CGFloat)[side integerValue]};
						NSImage *new = [image resize:size];
						
						// DONE: WRITE IMAGE FILE
						NSString *iconpath = [directory stringByAppendingFormat:@"/icon-%@.png", side];
						
						NSBitmapImageRep *imgRep = [NSBitmapImageRep imageRepWithData:[new TIFFRepresentation]];
						[imgRep setSize:size];
						[[imgRep representationUsingType:NSPNGFileType properties:@{}] writeToFile:iconpath atomically:YES];
						
						imgRep = nil;
						new = nil;
					}
					
					image = nil;
				} else {
					NSLog(@"IMAGE SIZE %@ NOT RIGHT.", NSStringFromSize([image size]));
					image = nil;
					continue;
				}
			}
		}
		
		
	}
	return 0;
}
