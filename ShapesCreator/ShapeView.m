//
//  ShapeView.m
//  ShapesCreator
//
//  Created by Ilya Borisov (bis) on 18.01.12.
//  Copyright (c) 2012 __TheLostWorld__. All rights reserved.
//

#import "ShapeView.h"


@interface ShapeView ()

@property (strong, nonatomic) NSMutableSet *activeTouches;
@property (nonatomic) CGFloat touches_initialDistance;
@property (nonatomic) CGPoint touches_initialCenter;
@property (nonatomic) CGFloat initialUnit;
@property (nonatomic) CGPoint initialScreenCenter;
@property (nonatomic) CGPoint initialScreenOrigin;
@property (strong, nonatomic) AffineTransformation *initial_MainShape_ShapeCsToScreenCsTransform;
@property (nonatomic) BOOL isZoomingAndPanning;
@property (nonatomic) BOOL isPanning;

@end


@implementation ShapeView

const double scaleAnimationDuration = 0.5;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    if (!self.mainShape_ShapeCsToScreenCsTransform) {
        
        if (self.isPanning) {
            [self endPanning];
        }
        if (self.isZoomingAndPanning) {
            [self endZoomingAndPanning];
        }
        
        // Screen coordinates origin (left top corner of the screen) at the shape coordinates (units) 
        CGPoint origin = CGPointMake(self.screenCenter.x - 0.5*rect.size.width/self.unit, self.screenCenter.y + 0.5*rect.size.height/self.unit);
        
        self.mainShape_ShapeCsToScreenCsTransform = [[AffineTransformation alloc] initWith_s_x:self.unit s_y:(-self.unit) alpha:0.0 t_x:(-origin.x*self.unit) t_y:(origin.y*self.unit)];
        
        self.mainShape.shapeCsToScreenCsTransform = self.mainShape_ShapeCsToScreenCsTransform;
    }
    
    [self.mainShape drawAtRect:rect];
}

#pragma mark -
#pragma mark - Custom Scaling methods 

- (void)setupUnitAndScreenCenter {
    
    self.unit = 80.0;
    self.screenCenter = CGPointMake(0.0, 0.0);
    
    self.mainShape_ShapeCsToScreenCsTransform = nil;
}

- (void)setupUnitAndScreenCenterAccordingToDimensionsAndFrameSize:(CGSize)frameSize {
    
    CGRect dimRect = [self.mainShape dimensionsRectangle];
    
    self.unit = MIN(frameSize.width / dimRect.size.width, frameSize.height / dimRect.size.height);
    
    self.screenCenter = CGPointMake(dimRect.origin.x + 0.5*dimRect.size.width, dimRect.origin.y + 0.5*dimRect.size.height);
    
    self.mainShape_ShapeCsToScreenCsTransform = nil;
}

#pragma mark -
#pragma mark - Custom 'Scale with tap' methods 

- (void)scaleDrawingOriginally {
    
    [self setupUnitAndScreenCenter];
    
    [UIView animateWithDuration:scaleAnimationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^ {
                         
                         [self setNeedsDisplay];
                     }
                     completion:^(BOOL finished) {
                         
                         // 
                     }
     ];
}

- (void)scaleDrawingToFitToScreen {
    
    [self setupUnitAndScreenCenterAccordingToDimensionsAndFrameSize:self.frame.size];
    
    [UIView animateWithDuration:scaleAnimationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^ {
                         
                         [self setNeedsDisplay];
                     }
                     completion:^(BOOL finished) {
                         
                         //
                     }
     ];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tapRecognizer {
    
    [self scaleDrawingToFitToScreen];
}

- (void)handleTwoTouchesTap:(UITapGestureRecognizer *)tapRecognizer {
    
    [self scaleDrawingOriginally];
}

- (void)addDoubleTapGR {
    
    UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGR.numberOfTapsRequired = 2;
    
    [self addGestureRecognizer:doubleTapGR];
}

- (void)addTwoTouchesTapGR {
    
    UITapGestureRecognizer *twoTouchesTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoTouchesTap:)];
    twoTouchesTapGR.numberOfTouchesRequired = 2;
    
    [self addGestureRecognizer:twoTouchesTapGR];
}

#pragma mark -
#pragma mark - Custom 'Pan with Finger' methods

- (CGPoint)location {
    
    return [[self.activeTouches anyObject] locationInView:self];
}

- (void)beginPanningAtLocation:(CGPoint)location {
    
    self.touches_initialCenter = location;
    self.initialScreenCenter   = self.screenCenter;
    self.initialScreenOrigin   = CGPointMake(0.0 - self.mainShape_ShapeCsToScreenCsTransform.t_x/self.unit, self.mainShape_ShapeCsToScreenCsTransform.t_y/self.unit);
    
    self.initial_MainShape_ShapeCsToScreenCsTransform = [[AffineTransformation alloc] initWithTransformation:self.mainShape_ShapeCsToScreenCsTransform];
    
    self.isPanning = YES;
}

- (void)beginPanning {
    
    [self beginPanningAtLocation:[self location]];
}

- (void)movePanningAtLocation:(CGPoint)location {
    
    CGPoint touches_shiftInScreenCS = CGPointMake(location.x - self.touches_initialCenter.x, location.y - self.touches_initialCenter.y);
    
    self.mainShape_ShapeCsToScreenCsTransform.t_x = touches_shiftInScreenCS.x - self.initialScreenOrigin.x*self.unit;
    self.mainShape_ShapeCsToScreenCsTransform.t_y = touches_shiftInScreenCS.y + self.initialScreenOrigin.y*self.unit;
    [self.mainShape_ShapeCsToScreenCsTransform computeCTM];
    
    self.screenCenter = CGPointMake((self.initialScreenCenter.x - self.initialScreenOrigin.x) - self.mainShape_ShapeCsToScreenCsTransform.t_x/self.unit, (self.initialScreenCenter.y - self.initialScreenOrigin.y) + self.mainShape_ShapeCsToScreenCsTransform.t_y/self.unit);
    
    [self setNeedsDisplay];
}

- (void)movePanning {
    
    [self movePanningAtLocation:[self location]];
}

- (void)endPanning {
    
    self.isPanning = NO;
}

- (void)cancelPanning {
    
    // self.screenCenter = self.initialScreenCenter;
    
    self.isPanning = NO;
}

#pragma mark -
#pragma mark - Custom 'Zoom and Pan with Pinch' methods

- (CGPoint)locationWithIndex:(NSUInteger)index {
    
    UITouch *touch = [[self.activeTouches allObjects] objectAtIndex:index];
    
    return [touch locationInView:self];
}

- (CGFloat)distanceBetweenPoint:(CGPoint)fromPoint andPoint:(CGPoint)toPoint {
    
	CGFloat sx = toPoint.x - fromPoint.x;
    CGFloat sy = toPoint.y - fromPoint.y;
    
    return sqrt(sx*sx + sy*sy);
}

- (CGPoint)centerForPoint:(CGPoint)fromPoint andPoint:(CGPoint)toPoint {
    
    return CGPointMake(0.5*(fromPoint.x + toPoint.x), 0.5*(fromPoint.y + toPoint.y));
}

- (void)beginZoomingAndPanningWithLocation1:(CGPoint)location1 andLocation2:(CGPoint)location2 {
    
    self.touches_initialDistance     = [self distanceBetweenPoint:location1 andPoint:location2];
    self.touches_initialCenter       = [self centerForPoint:location1 andPoint:location2];
    self.initialUnit         = self.unit;
    self.initialScreenCenter = self.screenCenter;
    self.initialScreenOrigin = CGPointMake(0.0 - self.mainShape_ShapeCsToScreenCsTransform.t_x/self.unit, self.mainShape_ShapeCsToScreenCsTransform.t_y/self.unit);
    
    self.initial_MainShape_ShapeCsToScreenCsTransform = [[AffineTransformation alloc] initWithTransformation:self.mainShape_ShapeCsToScreenCsTransform];
    
    self.isZoomingAndPanning = YES;
}

- (void)beginZoomingAndPanning {
    
    [self beginZoomingAndPanningWithLocation1:[self locationWithIndex:0] andLocation2:[self locationWithIndex:1]];
}

- (void)moveZoomingAndPanningWithLocation1:(CGPoint)location1 andLocation2:(CGPoint)location2 {
    
    CGFloat touches_currentDistance = [self distanceBetweenPoint:location1 andPoint:location2];
    CGFloat zoomFactor = touches_currentDistance/self.touches_initialDistance;
    
    // Scaling for the (mainShape) display 
    self.unit = zoomFactor*self.initialUnit;
    self.mainShape_ShapeCsToScreenCsTransform.s_x = zoomFactor*self.initial_MainShape_ShapeCsToScreenCsTransform.s_x;
    self.mainShape_ShapeCsToScreenCsTransform.s_y = zoomFactor*self.initial_MainShape_ShapeCsToScreenCsTransform.s_y;
    
    // Translation for the (mainShape) display 
    CGPoint touches_initialCenterInDrawingCS = CGPointMake(self.initialScreenOrigin.x + self.touches_initialCenter.x/self.initialUnit, self.initialScreenOrigin.y - self.touches_initialCenter.y/self.initialUnit);
    CGPoint newScreenOriginBeforeTranslationInDrawingCS = CGPointMake(touches_initialCenterInDrawingCS.x - self.touches_initialCenter.x/self.unit, touches_initialCenterInDrawingCS.y + self.touches_initialCenter.y/self.unit);
    
    CGPoint pinchTouch_Center = [self centerForPoint:location1 andPoint:location2];
    CGPoint pinchTouch_shift = CGPointMake(pinchTouch_Center.x - self.touches_initialCenter.x, pinchTouch_Center.y - self.touches_initialCenter.y);
    
    self.mainShape_ShapeCsToScreenCsTransform.t_x = pinchTouch_shift.x - newScreenOriginBeforeTranslationInDrawingCS.x*self.unit;
    self.mainShape_ShapeCsToScreenCsTransform.t_y = pinchTouch_shift.y + newScreenOriginBeforeTranslationInDrawingCS.y*self.unit;
    [self.mainShape_ShapeCsToScreenCsTransform computeCTM];
    
    self.screenCenter = CGPointMake((self.initialScreenCenter.x - self.initialScreenOrigin.x)/zoomFactor - self.mainShape_ShapeCsToScreenCsTransform.t_x/self.unit, (self.initialScreenCenter.y - self.initialScreenOrigin.y)/zoomFactor + self.mainShape_ShapeCsToScreenCsTransform.t_y/self.unit);
    
    [self setNeedsDisplay];
}

- (void)moveZoomingAndPanning {
    
    [self moveZoomingAndPanningWithLocation1:[self locationWithIndex:0] andLocation2:[self locationWithIndex:1]];
}

- (void)endZoomingAndPanning {
    
    self.isZoomingAndPanning = NO;
}

- (void)cancelZoomingAndPanning {
    
    // self.unit         = self.initialUnit;
    // self.screenCenter = self.initialScreenCenter;
    
    self.isZoomingAndPanning = NO;
}

#pragma mark -
#pragma mark - UIResponder 'Responding to Touch Events' methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.activeTouches) {
        self.activeTouches = [NSMutableSet setWithSet:touches];
    }
    else {
        [self.activeTouches unionSet:touches];
    }
    
    switch ([self.activeTouches count]) {
            
        case 1:
            [self beginPanning];
            break;
        case 2:
            if (self.isPanning) {
                [self endPanning];
            }
            [self beginZoomingAndPanning];
            break;
        case 3:
        case 4:
        case 5:
        default:
            if (self.isZoomingAndPanning) {
                [self endZoomingAndPanning];
            }
            else if (self.isPanning) {
                [self endPanning];
            }
            break;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    switch ([self.activeTouches count]) {
            
        case 1:
            if (self.isZoomingAndPanning) {
                [self moveZoomingAndPanning];
            }
            else if (self.isPanning) {
                [self movePanning];
            }
            break;
        case 2:
            if (self.isZoomingAndPanning) {
                [self moveZoomingAndPanning];
            }
            break;
        case 3:
        case 4:
        case 5:
        default:
            break;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    switch ([self.activeTouches count]) {
            
        case 1:
            if (self.isPanning) {
                [self endPanning];
            }
            break;
        case 2:
            if (self.isZoomingAndPanning) {
                [self endZoomingAndPanning];
            }
            break;
        case 3:
        case 4:
        case 5:
        default:
            break;
    }
    
    [self.activeTouches minusSet:touches];
    
    switch ([self.activeTouches count]) {
            
        case 1:
            [self beginPanning];
            break;
        case 2:
            [self beginZoomingAndPanning];
            break;
        case 3:
        case 4:
        case 5:
        default:
            break;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    switch ([self.activeTouches count]) {
            
        case 1:
            if (self.isPanning) {
                [self cancelPanning];
            }
            break;
        case 2:
            if (self.isZoomingAndPanning) {
                [self cancelZoomingAndPanning];
            }
            break;
        case 3:
        case 4:
        case 5:
        default:
            break;
    }
    
    [self.activeTouches minusSet:touches];
    
    switch ([self.activeTouches count]) {
            
        case 1:
            [self beginPanning];
            break;
        case 2:
            [self beginZoomingAndPanning];
            break;
        case 3:
        case 4:
        case 5:
        default:
            break;
    }
}

@end
