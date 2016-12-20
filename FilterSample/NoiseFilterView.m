

#import "NoiseFilterView.h"
#import "NoiseFilter.h"

@interface NoiseFilterView ()

@property (nonatomic, strong) CIFilter *filter;
@property (assign) float scaleX;
@property (assign) float scaleY;

@end

@implementation NoiseFilterView


- (CIFilter *)filter
{
    if (_filter == nil) {
        
        // Make sure initialize is called. This should only be done once
        [NoiseFilter registerFilter];
        
        NSURL *imageURL = [[NSBundle mainBundle] URLForResource:@"CraterLake" withExtension:@"jpg"];
        CIImage *image = [CIImage imageWithContentsOfURL:imageURL];
        
        NSURL *imageMapURL = [[NSBundle mainBundle] URLForResource:@"displaceMap" withExtension:@"jpeg"];
        CIImage *imageMap = [CIImage imageWithContentsOfURL:imageMapURL];
        
        _filter =  [CIFilter filterWithName: @"NoiseFilter" keysAndValues:@"inputImage", image, @"mapImage", imageMap, nil];

    }
    return _filter;
}

- (void)drawRect:(NSRect)rect
{
  CIContext* context = [[NSGraphicsContext currentContext] CIContext];
 
 	if (context != nil) {
        
        CIFilter *filter = self.filter;
        _scaleX = 25;
        _scaleY = 25;
        [filter setValue:@(self.scaleX) forKey:@"scaleX"];
        [filter setValue:@(self.scaleY) forKey:@"scaleY"];
        CGRect drawRect = CGRectMake(NSMinX(rect), NSMinY(rect), NSWidth(rect), NSHeight(rect));

        CIImage *image = [filter valueForKey:@"outputImage"];
		[context drawImage:image atPoint:drawRect.origin fromRect:drawRect];
    }
}

@end

