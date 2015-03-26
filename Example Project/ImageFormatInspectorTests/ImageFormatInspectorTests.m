//
//  ImageFormatInspectorTests.m
//  ImageFormatInspectorTests
//
//  Created by David Sweetman on 3/25/15.
//  Copyright (c) 2015 davidsweetman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ImageFormatInspector.h"

@interface ImageFormatInspectorTests : XCTestCase
@end

@implementation ImageFormatInspectorTests

#pragma mark - Helpers

- (NSData*)sampleImageDataForExtension:(NSString*)ext
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:ext];
    return [NSData dataWithContentsOfFile:filePath];
}

#pragma mark - Tests

- (void)testJPG
{
    NSString *ext = @"jpg";
    NSData *jpgData = [self sampleImageDataForExtension:ext];
    XCTAssert(imageFormatForImageData(jpgData) == ImageFormatJPEG);
    XCTAssert(imageFormatForFileExtension(ext) == ImageFormatJPEG);
    XCTAssert([fileExtensionForImageFormat(ImageFormatJPEG) isEqualToString:ext]);
}

- (void)testPNG
{
    NSString *ext = @"png";
    NSData *pngData = [self sampleImageDataForExtension:ext];
    XCTAssert(imageFormatForImageData(pngData) == ImageFormatPNG);
    XCTAssert(imageFormatForFileExtension(ext) == ImageFormatPNG);
    XCTAssert([fileExtensionForImageFormat(ImageFormatPNG) isEqualToString:ext]);
}

- (void)testTIF
{
    NSString *ext = @"tif";
    NSData *tifData = [self sampleImageDataForExtension:ext];
    XCTAssert(imageFormatForImageData(tifData) == ImageFormatTIF);
    XCTAssert(imageFormatForFileExtension(ext) == ImageFormatTIF);
    XCTAssert([fileExtensionForImageFormat(ImageFormatTIF) isEqualToString:ext]);
}

- (void)testUnkown
{
    NSString *ext = @"txt";
    NSData *tifData = [self sampleImageDataForExtension:ext];
    XCTAssert(imageFormatForImageData(tifData) == ImageFormatUnknown);
    XCTAssert(imageFormatForFileExtension(ext) == ImageFormatUnknown);
    XCTAssert(fileExtensionForImageFormat(ImageFormatUnknown) ==  nil);
}

@end
