//
//  ParametricCurve.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 23.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "ParametricCurve.h"


@implementation ParametricCurve

@synthesize t_min, t_max;
@synthesize steps;

const double const_default_t_min = -1.0;
const double const_default_t_max = 1.0;
const NSUInteger const_default_steps = 256;

- (double)default_t_min {
    
    return const_default_t_min;
}

- (double)default_t_max {
    
    return const_default_t_max;
}

- (double)default_steps {
    
    return const_default_steps;
}

- (id)init {
    
    return [self initWithSupershape:nil t_min:self.default_t_min t_max:self.default_t_max andSteps:self.default_steps];
}

- (id)initWithSupershape:(Shape*)theSuperShape t_min:(double)the_t_min t_max:(double)the_t_max andSteps:(NSUInteger)the_steps {
    
    self = [super initWithSupershape:theSuperShape];
    
    if (self) {
        
        self.title = @"Parametric Curve";
        self.iconName = @"shape_icon_ParametricCurve.png";
        
        self.t_min = the_t_min;
        self.t_max = the_t_max;
        self.steps = the_steps;
    }
    
    return self;
}

- (double)x:(double)t {
    
    NSLog(@"-[ParametricCurve x:] - Please override this method for descendant");
    
    return 0.0;
}

- (double)y:(double)t {
    
    NSLog(@"-[ParametricCurve y:] - Please override this method for descendant");
    
    return 0.0;
}

- (double)z:(double)t {
    
    NSLog(@"-[ParametricCurve z:] - Please override this method for descendant");
    
    return 0.0;
}

- (struct Coordinates)screenCsFromParameter:(double)t {
    
    struct Coordinates C;
    
    C.x = [self x:t];
    C.y = [self y:t];
    C.z = [self z:t];
    
    C = [self screenCsFromShapeCs:C];
    
    return C;
}

- (void)drawElementWithTransformation:(Transformation*)multiplicatingTransformation AtRect:(CGRect)rect {
    
    self.currentMultiplicatingTransformation = multiplicatingTransformation;
    
    double delta_t = (t_max - t_min)/steps;
    
    // And here let's draw the path representing ParametricCurve element by element --- > 
    
    CGMutablePathRef path = CGPathCreateMutable();
    const CGAffineTransform *m = nil;
    
    struct Coordinates C = [self screenCsFromParameter:t_min];
    
    CGPathMoveToPoint(path, m, C.x, C.y);
    
    CGFloat t = t_min + delta_t;
    while (t < t_max) {
        
        C = [self screenCsFromParameter:t];
        
        CGPathAddLineToPoint(path, m, C.x, C.y);
        t += delta_t;
    }
    C = [self screenCsFromParameter:t_max];
    CGPathAddLineToPoint(path, m, C.x, C.y);
    
    // < --- Path is ready 
    
    // Now let's display it --- > 
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextBeginPath(c);
    CGContextAddPath(c, path);
    CGContextSetStrokeColorWithColor(c, style.outlineCGColor);
    CGContextSetLineWidth(c, style.lineWidth);
    CGContextStrokePath(c);
    
    if (self.style.fillColor) {
        
        CGContextBeginPath(c);
        CGContextAddPath(c, path);
        CGContextSetFillColorWithColor(c, style.fillCGColor);
        CGContextFillPath(c);
    }
    
    // < --- 
    
    // And release --- > 
    
    CFRelease(path);
    
    // < --- Fine! 
    
    // And now let's draw the subshapes --- > 
    [super drawElementWithTransformation:multiplicatingTransformation AtRect:rect];
    // < --- Subshapes are drawn 
}

#pragma mark - NSCoding Protocol methods 

// Returns an object initialized from data in a given unarchiver (required) 
// Parameters: decoder - an unarchiver object. 
// Return Value: self, initialized using the data in decoder. 
- (id)initWithCoder:(NSCoder *)decoder {
	
    self = [super initWithCoder:decoder];
    
    if (self) {
        
        self.t_min = [decoder decodeDoubleForKey:@"t_min"];
        self.t_max = [decoder decodeDoubleForKey:@"t_max"];
        self.steps = [[decoder decodeObjectForKey:@"steps"] unsignedIntegerValue];
    }
    
    return self;
}

// Encodes the receiver using a given archiver (required) 
// Parameters: encoder - an archiver object. 
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [super encodeWithCoder:encoder];
    
    [encoder encodeDouble:t_min forKey:@"t_min"];
    [encoder encodeDouble:t_max forKey:@"t_max"];
    [encoder encodeObject:[NSNumber numberWithUnsignedInteger:steps] forKey:@"steps"];
}

@end
