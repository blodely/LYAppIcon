//
//  NSImage+Resize.m
//  iOSAppIcon
//
//  Created by Luo Yu on 2018/7/19.
//  Copyright © 2018 Luo Yu. All rights reserved.
//  Mozilla Public License Version 2.0
//

#import "NSImage+Resize.h"

@implementation NSImage (Resize)

- (NSImage *)resize:(CGSize)size {
	
	CGFloat actualHeight = self.size.height;
	CGFloat actualWidth = self.size.width;
	if (actualWidth <= size.width && actualHeight <= size.height) {
		// SMALLER IMAGE
		return self;
	}
	
	float oldRatio = actualWidth / actualHeight;
	float newRatio = size.width / size.height;
	if (oldRatio < newRatio) {
		oldRatio = size.height / actualHeight;
		actualWidth = oldRatio * actualWidth;
		actualHeight = size.height;
	} else {
		oldRatio = size.width / actualWidth;
		actualHeight = oldRatio * actualHeight;
		actualWidth = size.width;
	}
	
	NSImage *image = [[NSImage alloc] initWithSize:(NSSize){actualWidth, actualHeight}];
	
	[image lockFocus];
	[self setSize:(NSSize){actualWidth, actualHeight}];
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
	[self drawAtPoint:NSZeroPoint fromRect:(NSRect){0.0f, 0.0f, actualWidth, actualHeight} operation:NSCompositingOperationCopy fraction:1.0f];
	[image unlockFocus];
	
	return image;
}

@end
