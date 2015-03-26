//
//  ViewController.m
//  ImageFormatInspector
//
//  Created by David Sweetman on 3/25/15.
//  Copyright (c) 2015 davidsweetman. All rights reserved.
//

#import "ViewController.h"
#import "ImageFormatInspector.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray *sampleFileExtensions;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIButton *button;
@end

@implementation ViewController

- (NSArray*)sampleFileExtensions
{
    if (_sampleFileExtensions == nil) {
        _sampleFileExtensions = @[@"jpg", @"tif", @"png", @"txt"];
    }
    return _sampleFileExtensions;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setup];
    self.currentIndex = 0;
}

- (void)setup
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 200, 300)];
    self.imageView.center = CGPointMake(self.view.frame.size.width/2.0,
                                        self.imageView.center.y);
    [self.view addSubview:self.imageView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                           CGRectGetMaxY(self.imageView.frame) + 60,
                                                           self.view.frame.size.width,
                                                           30.0)];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = self.view.bounds;
    [self.button addTarget:self action:@selector(incrementCurrentIndex) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}

- (void)incrementCurrentIndex
{
    self.currentIndex++;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex >= self.sampleFileExtensions.count) {
        currentIndex = 0;
    }
    _currentIndex = currentIndex;
    [self update];
}

- (NSString*)sampleFilePathForExtension:(NSString*)ext
{
    return [[NSBundle mainBundle] pathForResource:@"sample" ofType:ext];
}

- (void)update
{
    NSString *samplePath = [self sampleFilePathForExtension:self.sampleFileExtensions[self.currentIndex]];
    NSData *imageData = [NSData dataWithContentsOfFile:samplePath];
    self.imageView.image = [UIImage imageWithContentsOfFile:samplePath];
    
    ImageFormat format = imageFormatForImageData(imageData);
    NSString *ext = fileExtensionForImageFormat(format);
    NSLog(@"ImageFormat of data: %@", ext);
    self.label.text = ext;
}

@end
