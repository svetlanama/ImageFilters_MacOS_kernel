

#import "BlurFilterView.h"
#import "BlurFilter.h"

@interface BlurFilterView ()

@property (nonatomic, strong) CIFilter *filter;
@property (assign) float distance;
@property (assign) float slope;

@property (assign) float numSamples;


@end

@implementation BlurFilterView


- (IBAction)takeDistanceFrom:(id)sender
{
    self.distance = [sender floatValue];
    [self setNeedsDisplay: YES];
}


- (IBAction)takeSlopeFrom:(id)sender
{
    self.slope = [sender floatValue];
    [self setNeedsDisplay: YES];
}

- (CIFilter *)filter
{
    if (_filter == nil) {
        
        // Make sure initialize is called. This should only be done once
        [BlurFilter registerFilter];
        
        NSURL *imageURL = [[NSBundle mainBundle] URLForResource:@"CraterLake" withExtension:@"jpg"];
        CIImage *image = [CIImage imageWithContentsOfURL:imageURL];

        
        _filter =  [CIFilter filterWithName: @"BlurFilter" keysAndValues:@"inputImage", image, nil];

    }
    return _filter;
}

- (void)drawRect:(NSRect)rect
{
  CIContext* context = [[NSGraphicsContext currentContext] CIContext];
 
 	if (context != nil) {
        
        CIFilter *filter = self.filter;
        _numSamples = 5;

        [filter setValue:@(self.numSamples) forKey:@"numSamples"];
        CGRect drawRect = CGRectMake(NSMinX(rect), NSMinY(rect), NSWidth(rect), NSHeight(rect));

        CIImage *image = [filter valueForKey:@"outputImage"];
		[context drawImage:image atPoint:drawRect.origin fromRect:drawRect];
    }
}

@end


//- (CIFilter *)filter
//{
//    if (_filter == nil) {
//
//        // Make sure initialize is called. This should only be done once
//        [MyHazeFilter registerFilter];
//
//        NSURL *imageURL = [[NSBundle mainBundle] URLForResource:@"CraterLake" withExtension:@"jpg"];
//        CIImage *image = [CIImage imageWithContentsOfURL:imageURL];
//        CIColor *inputColor = [CIColor colorWithRed:0.7  green:0.9  blue:1.0];
//
//        _filter = [CIFilter filterWithName:@"MyHazeFilter"
//                             keysAndValues:@"inputImage", image, @"inputColor", inputColor, nil];
//    }
//    return _filter;
//}

//
//- (CIFilter *)filter
//{
//    if (_filter == nil) {
//
//        // Make sure initialize is called. This should only be done once
//        [MyHazeFilter registerFilter];
//
//        NSURL *imageURL = [[NSBundle mainBundle] URLForResource:@"CraterLake" withExtension:@"jpg"];
//        CIImage *image = [CIImage imageWithContentsOfURL:imageURL];
//        CIColor *inputColor = [CIColor colorWithRed:0.7  green:0.9  blue:1.0];
//
//        _filter = [CIFilter filterWithName:@"MyHazeRemover"
//                keysAndValues:@"inputImage", image, @"inputColor", inputColor, nil];
//    }
//    return _filter;
//}
