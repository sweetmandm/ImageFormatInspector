//
//  ImageFormatInspector.m
//

#import "ImageFormatInspector.h"

#pragma mark - File Extension String <-> ImageFormat

NSDictionary* extensionToType() {
    return @{@"jpg"  : @(ImageFormatJPEG),
             @"jpeg" : @(ImageFormatJPEG),
             @"png"  : @(ImageFormatPNG),
             @"tif"  : @(ImageFormatTIF),
             @"tiff" : @(ImageFormatTIF)};
}

NSDictionary* typeToExtension() {
    return @{@(ImageFormatJPEG) : @"jpg",
             @(ImageFormatPNG)  : @"png",
             @(ImageFormatTIF) : @"tif"};
}

NSString* fileExtensionForImageFormat(ImageFormat format) {
    return typeToExtension()[@(format)];
}

ImageFormat imageFormatForFileExtension(NSString *fileExtension) {
    return [extensionToType()[fileExtension] integerValue];
}

#pragma mark - Format Checkers

BOOL isJPEG (const UInt8 *buffer, NSUInteger totalBytes) {
    // JPEG: http://www.mikekunz.com/image_file_header.html
    return (totalBytes > 3 &&
            buffer[0] == 0xFF &&
            buffer[1] == 0xD8 &&
            buffer[2] == 0xFF &&
            (buffer[3] == 0xE0 || // JFIF
             buffer[3] == 0xE1)); // EXIF
}

BOOL isTIFF (const UInt8 *buffer, NSUInteger totalBytes) {
    // TIFF: http://www.mikekunz.com/image_file_header.html
    //       http://partners.adobe.com/public/developer/en/tiff/TIFF6.pdf (header = page 13)
    return (totalBytes > 2 &&
            ((buffer[0] == 0x49 && buffer[1] == 0x49) ||     // Intel format tiff
             (buffer[0] == 0x4D && buffer[1] == 0x4D)) &&    // Macintosh integer format tiff
            buffer[2] == 0x2A);
}

BOOL isPNG (const UInt8 *buffer, NSUInteger totalBytes) {
    // PNG: http://stackoverflow.com/a/16780784
    return (totalBytes > 11 &&
            buffer[0] == 0x89 && // PNG
            buffer[1] == 0x50 &&
            buffer[2] == 0x4e &&
            buffer[3] == 0x47 &&
            buffer[4] == 0x0d &&
            buffer[5] == 0x0a &&
            buffer[6] == 0x1a &&
            buffer[7] == 0x0a &&
            buffer[totalBytes - 12] == 0x00 && // IEND
            buffer[totalBytes - 11] == 0x00 &&
            buffer[totalBytes - 10] == 0x00 &&
            buffer[totalBytes - 9]  == 0x00 &&
            buffer[totalBytes - 8]  == 0x49 &&
            buffer[totalBytes - 7]  == 0x45 &&
            buffer[totalBytes - 6]  == 0x4e &&
            buffer[totalBytes - 5]  == 0x44 &&
            buffer[totalBytes - 4]  == 0xae &&
            buffer[totalBytes - 3]  == 0x42 &&
            buffer[totalBytes - 2]  == 0x60 &&
            buffer[totalBytes - 1]  == 0x82);
}

ImageFormat imageFormatForImageData(NSData *data) {
    const UInt8 *buffer = [data bytes];
    NSUInteger totalBytes = [data length];
    
    ImageFormat format = ImageFormatUnknown;
    if (isJPEG(buffer, totalBytes)) {
        
        format = ImageFormatJPEG;
        
    } else if (isTIFF(buffer, totalBytes)) {
        
        format = ImageFormatTIF;
        
    } else if (isPNG(buffer, totalBytes)) {
        
        format = ImageFormatPNG;
        
    }
    return format;
}
