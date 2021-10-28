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
	
	CGSize asize = [self size];
	
	/*
	if (asize.width <= size.width && asize.height <= size.height) {
		// SMALLER IMAGE
		return self;
	}
	*/
	
	float oldRatio = asize.width / asize.height;
	float newRatio = size.width / size.height;
	if (oldRatio < newRatio) {
		oldRatio = size.height / asize.height;
		asize.width = oldRatio * asize.width;
		asize.height = size.height;
	} else {
		oldRatio = size.width / asize.width;
		asize.height = oldRatio * asize.height;
		asize.width = size.width;
	}
	
	{
		CGFloat scale = 1;
		NSScreen *screen = [NSScreen mainScreen];
		NSRect backing = [screen convertRectToBacking:screen.frame];
		NSRect running = screen.frame;
		scale = backing.size.width / running.size.width;
		
		asize = (CGSize){asize.width / scale, asize.height / scale};
	}
	
	NSImage *image = [[NSImage alloc] initWithSize:(NSSize){asize.width, asize.height}];
	
	[image lockFocus];
	[self setSize:asize];
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
	[self drawAtPoint:NSZeroPoint fromRect:(NSRect){0.0f, 0.0f, asize.width, asize.height} operation:NSCompositingOperationCopy fraction:1.0f];
	[image unlockFocus];
	
	return image;
}

@end
