# ImageFormatInspector

## Installation:

### Cocoapods

Add to your Podfile:

`pod ImageFormatInspector`

then `pod install`

### Non-Cocoapods

Drop ImageFormatInspector.{h,m} into your project.


## Usage

    #import ImageFormatInspector.h
    
    NSData *imageData = /* some NSData from a web service or something */
    
    ImageFormat format = imageFormatForImageData(imageData);
    
    if (format != ImageFormatUnkown) {
        NSLog(@"It's got some kind of known valid image header.");
    }
    
    if (format == ImageFormatJPEG) {
        NSLog(@"Its a JPEG!");
    }
    // Also detects ImageFormatPNG, ImageFormatTIF.
    // If you need to know other formats, feel free 
    // to add them and submit a PR!

## Sample Project

There's a sample project too.


## License

MIT
