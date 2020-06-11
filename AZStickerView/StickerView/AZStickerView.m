//
//  AZStickerView.m
//  AZStickerView
//
//  Created by minkook yoo on 2020/06/11.
//  Copyright © 2020 minkook yoo. All rights reserved.
//

#import "AZStickerView.h"


@interface AZStickerView ()

@property (nonatomic, strong) CAShapeLayer *borderLayer;

@property (nonatomic, strong) UIImageView *deleteView;
@property (nonatomic, strong) UIImageView *resizeAndRotateView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panMoveGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panResizeGesture;
@property (nonatomic, strong) UITapGestureRecognizer *tapDeleteGesture;

//Touch 임시 변수
@property (nonatomic, assign) CGRect touchBeganBounds;
@property (nonatomic, assign) CGPoint touchBeganLocation;
@property (nonatomic, assign) CGAffineTransform touchBeganTransform;
@property (nonatomic, assign) CGFloat touchBeganRadians;
@property (nonatomic, assign) CGFloat touchBeganTranslateTx;
@property (nonatomic, assign) CGFloat touchBeganTranslateTy;
@property (nonatomic, assign) CGFloat touchBeganDistance;


/*
 * 편집 모드 - On / off (기본값 NO)
 * 편집모드: Border와 컨트롤버튼들이 나타남.
 */
@property (nonatomic, assign) BOOL editMode;


/*
 * 뷰 처음 생성시 기본 크기
 */
@property (nonatomic, assign) CGRect originBounds;


@end


static const CGFloat ModelViewContentsMinimumSizeWidth = 60.0;
static const CGFloat ModelViewContentsMinimumSizeHeight = 60.0;

static const CGFloat StickerControlSizeWidth = 25.0;
static const CGFloat StickerControlSizeHieght = 25.0;

static const CGFloat StickerDefaultSizeWidth = 104.0;
static const CGFloat StickerDefaultSizeHieght = 104.0;


@implementation AZStickerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self.layer addSublayer:self.borderLayer];
        
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:self.tapGesture];
        
        self.doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGesture:)];
        self.doubleTapGesture.numberOfTapsRequired = 2;
        [self addGestureRecognizer:self.doubleTapGesture];
        
        [self.tapGesture requireGestureRecognizerToFail:self.doubleTapGesture];
        
        self.panMoveGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveGesture:)];
        [self addGestureRecognizer:self.panMoveGesture];
        
        self.resizeAndRotateView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"rotate.right"]];
        self.resizeAndRotateView.tintColor = UIColor.darkGrayColor;
        self.resizeAndRotateView.userInteractionEnabled = YES;
        [self addSubview:self.resizeAndRotateView];
        self.panResizeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(resizeAndRotateGesture:)];
        [self.resizeAndRotateView addGestureRecognizer:self.panResizeGesture];
        
        self.deleteView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"multiply.circle.fill"]];
        self.deleteView.tintColor = UIColor.darkGrayColor;
        self.deleteView.userInteractionEnabled = YES;
        [self addSubview:self.deleteView];
        self.tapDeleteGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteTapGesture:)];
        [self.deleteView addGestureRecognizer:self.tapDeleteGesture];
        
        [self setEditMode:NO];
        
        
        ///~~~~~~~~~~~~~~~~~~
        CGFloat x = CGRectGetMidX(self.bounds) - (StickerDefaultSizeWidth / 2);
        CGFloat y = CGRectGetMidY(self.bounds) - (StickerDefaultSizeHieght / 2);
        
        CGRect rect = CGRectMake(x, y, StickerDefaultSizeWidth, StickerDefaultSizeHieght);
        
        self.frame = rect;
        
        self.originBounds = self.bounds;
        ///~~~~~~~~~~~~~~~~~~
        
        
    }
    
    return self;
    
}



#pragma mark - Property

- (CAShapeLayer *)borderLayer {
    
    if (!_borderLayer) {
        
        _borderLayer = [CAShapeLayer layer];
        _borderLayer.lineWidth = 1.0f;
        _borderLayer.lineDashPattern = @[@(4.0f), @(4.0f)];
        _borderLayer.strokeColor = [UIColor redColor].CGColor;
        _borderLayer.fillColor = [UIColor clearColor].CGColor;
        
    }
    
    return _borderLayer;
    
}

- (void)setEditMode:(BOOL)isEditMode {
    
    // 선택 전
#warning !
//    if (self._willChangeEditMode) {
//        self._willChangeEditMode(isEditMode);
//    }
    
    _editMode = isEditMode;
    
    
    // 선택 후
#warning !
//    if (!self.allwaysShowBorderLayer) {
//        self.borderLayer.hidden = !isEditMode;
//    }
    
    self.deleteView.hidden = !isEditMode;
    self.resizeAndRotateView.hidden = !isEditMode;
    
//    if (self._didChangeEditMode) {
//        self._didChangeEditMode(isEditMode);
//    }
    
}



#pragma mark - Override

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self updateSubViews];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self updateSubViews];
}



#pragma mark -

- (void)updateSubViews {
    
    // 최초 크기를 저장 해 둔다.
    if (CGRectEqualToRect(self.originBounds, CGRectZero) &&
        !CGRectEqualToRect(self.bounds, CGRectZero)) {
        self.originBounds = self.bounds;
    }
    
    // Border
    {
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRect:[self drawBounds]];
        self.borderLayer.path = borderPath.CGPath;
    }
    
    // Delete Button
    {
        CGFloat x = CGRectGetMinX(self.bounds);
        CGFloat y = CGRectGetMinY(self.bounds);
        
        self.deleteView.frame = CGRectMake(x, y, StickerControlSizeWidth, StickerControlSizeHieght);
        
        [self bringSubviewToFront:self.deleteView];
    }
    
    // ResizeAndRotate
    {
        CGFloat x = CGRectGetMaxX(self.bounds) - StickerControlSizeWidth;
        CGFloat y = CGRectGetMaxY(self.bounds) - StickerControlSizeHieght;
        
        self.resizeAndRotateView.frame = CGRectMake(x, y, StickerControlSizeWidth, StickerControlSizeHieght);
        
        [self bringSubviewToFront:self.resizeAndRotateView];
    }
    
}

- (CGRect)drawBounds {
    return CGRectInset(self.bounds, StickerControlSizeWidth / 2, StickerControlSizeHieght / 2);
}



#pragma mark - Gesture

- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
    self.editMode = YES;
}


- (void)doubleTapGesture:(UITapGestureRecognizer *)recognizer {
    
    self.editMode = YES;
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         weakSelf.transform = CGAffineTransformIdentity;
                         weakSelf.bounds = weakSelf.originBounds;
                         
                         CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
                         animation.duration = 0.3;
                         animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                         [weakSelf.borderLayer addAnimation:animation forKey:@"path"];
                         
                     } completion:nil];
    
}


- (void)moveGesture:(UIPanGestureRecognizer *)recognizer {
    
    if ([recognizer state]== UIGestureRecognizerStateBegan) {
        
        self.touchBeganLocation = [recognizer locationInView:self.superview];
        
        self.touchBeganRadians = atan2f(self.transform.b, self.transform.a);
        self.touchBeganTranslateTx = self.transform.tx;
        self.touchBeganTranslateTy = self.transform.ty;
        
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged) {
        
        CGPoint touchLocation = [recognizer locationInView:self.superview];
        
        CGFloat dx = touchLocation.x - self.touchBeganLocation.x;
        CGFloat dy = touchLocation.y - self.touchBeganLocation.y;
        
        dx += self.touchBeganTranslateTx;
        dy += self.touchBeganTranslateTy;
        
        // 영역 제한
        {
            CGFloat superViewWidth = CGRectGetWidth(self.superview.bounds);
            CGFloat superViewHeight = CGRectGetHeight(self.superview.bounds);
            
            // Left
            if (dx < -1 * superViewWidth / 2) {
                dx = -1 * superViewWidth / 2;
            }
            
            // Top
            if (dy < -1 * superViewHeight / 2) {
                dy = -1 * superViewHeight / 2;
            }
            
            // Right
            if (superViewWidth / 2 < dx) {
                dx = superViewWidth / 2;
            }
            
            // Bottom
            if (superViewHeight / 2 < dy) {
                dy = superViewHeight / 2;
            }
            
        }
        
        CGAffineTransform transform = CGAffineTransformMakeTranslation(dx, dy);
        transform = CGAffineTransformRotate(transform, self.touchBeganRadians);
        
        self.transform = transform;
        
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded) {
        
        self.touchBeganLocation = CGPointZero;
        
        self.touchBeganRadians = 0.0;
        self.touchBeganTranslateTx = 0.0;
        self.touchBeganTranslateTy = 0.0;
        
        self.editMode = YES;
        
    }
    
}


- (void)resizeAndRotateGesture:(UIPanGestureRecognizer *)recognizer {
    
    if ([recognizer state]== UIGestureRecognizerStateBegan) {
        
        self.touchBeganLocation = [recognizer locationInView:self.superview];
        
        CGFloat dx = fabs(CGRectGetMidX(self.frame) - self.touchBeganLocation.x);
        CGFloat dy = fabs(CGRectGetMidY(self.frame) - self.touchBeganLocation.y);
        
        self.touchBeganDistance = sqrtf(powf(dx, 2) + powf(dy, 2));
        
        self.touchBeganBounds = self.bounds;
        
        self.touchBeganTransform = self.transform;
        
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged) {
        
        CGPoint touchLocation = [recognizer locationInView:self.superview];
        
        // Resize
        CGFloat dx = fabs(CGRectGetMidX(self.frame) - touchLocation.x);
        CGFloat dy = fabs(CGRectGetMidY(self.frame) - touchLocation.y);
        
        CGFloat moveDistance = sqrtf(powf(dx, 2) + powf(dy, 2));
        
        CGFloat distance = moveDistance - self.touchBeganDistance;
        
        CGRect bounds = self.touchBeganBounds;
        
        CGFloat ratio = bounds.size.width / bounds.size.height;
        
        bounds.size.width += (distance * ratio);
        bounds.size.height += distance;
        
        // 최소값
        if (bounds.size.width < ModelViewContentsMinimumSizeWidth) {
            bounds.size.width = ModelViewContentsMinimumSizeWidth;
            bounds.size.height = ModelViewContentsMinimumSizeWidth / ratio;
        }
        
        if (bounds.size.height < ModelViewContentsMinimumSizeHeight) {
            bounds.size.height = ModelViewContentsMinimumSizeHeight;
            bounds.size.width = ModelViewContentsMinimumSizeWidth * ratio;
        }
        
        self.bounds = bounds;
        
        // Rotate
        CGFloat a1 = atan2f(self.touchBeganLocation.y - CGRectGetMidY(self.frame), self.touchBeganLocation.x - CGRectGetMidX(self.frame));
        CGFloat a2 = atan2f(touchLocation.y - CGRectGetMidY(self.frame), touchLocation.x - CGRectGetMidX(self.frame));
        
        CGFloat aRadians = a2 - a1;
        
        self.transform = CGAffineTransformRotate(self.touchBeganTransform, aRadians);
        
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded) {
        
        self.touchBeganLocation = CGPointZero;
        
        self.touchBeganBounds = CGRectZero;
        
        self.touchBeganTransform = CGAffineTransformIdentity;
        
    }
    
}


- (void)deleteTapGesture:(UITapGestureRecognizer *)recognizer {
    
#warning !
//    if (self._didSelectDelete) {
//        self._didSelectDelete ();
//    }
    
}


@end
