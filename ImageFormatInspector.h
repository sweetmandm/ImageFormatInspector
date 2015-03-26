//
//  ImageFormatInspector.h
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ImageFormat) {
    ImageFormatUnknown,
    ImageFormatPNG,
    ImageFormatJPEG,
    ImageFormatTIF
};

/**
 *  Detect the image format of NSData based on header data
 *  @return the detected ImageFormat
 */
ImageFormat imageFormatForImageData(NSData *data);

/**
 *  @return the file extension, or nil if the format is unkown
 */
NSString* fileExtensionForImageFormat(ImageFormat format);

/**
 *  @return the image format for a given file extension
 */
ImageFormat imageFormatForFileExtension(NSString *fileExtension);