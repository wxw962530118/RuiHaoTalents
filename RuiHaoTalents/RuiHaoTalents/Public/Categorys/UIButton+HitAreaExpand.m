//
//  UIButton+HitAreaExpand.m
//  KidsEvaluation
//
//  Created by 王新伟 on 2018/7/14.
//  Copyright © 2018年 haizitong. All rights reserved.
//

#import "UIButton+HitAreaExpand.h"
#import <objc/message.h>
static char minHitTestWidthKey;
static char minHitTestHeightKey;

@implementation UIButton (HitAreaExpand)

- (CGFloat)minHitTestWidth {
    return [objc_getAssociatedObject(self, &minHitTestWidthKey) floatValue];
}

- (void)setMinHitTestWidth:(CGFloat)minHitTestWidth {
    objc_setAssociatedObject(self, &minHitTestWidthKey, [NSString stringWithFormat:@"%f",minHitTestWidth], OBJC_ASSOCIATION_COPY);
}

- (CGFloat)minHitTestHeight {
    return [objc_getAssociatedObject(self, &minHitTestHeightKey) floatValue];
}

- (void)setMinHitTestHeight:(CGFloat)minHitTestHeight {
    objc_setAssociatedObject(self, &minHitTestHeightKey, [NSString stringWithFormat:@"%f",minHitTestHeight], OBJC_ASSOCIATION_COPY);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    return CGRectContainsPoint(HitTestingBounds(self.bounds, self.minHitTestWidth, self.minHitTestHeight), point);
}

CGRect HitTestingBounds(CGRect bounds, CGFloat minimumHitTestWidth, CGFloat minimumHitTestHeight) {
    CGRect hitTestingBounds = bounds;
    if (minimumHitTestWidth > bounds.size.width) {
        hitTestingBounds.size.width = minimumHitTestWidth;
        hitTestingBounds.origin.x -= (hitTestingBounds.size.width - bounds.size.width)/2;
    }
    if (minimumHitTestHeight > bounds.size.height) {
        hitTestingBounds.size.height = minimumHitTestHeight;
        hitTestingBounds.origin.y -= (hitTestingBounds.size.height - bounds.size.height)/2;
    }
    return hitTestingBounds;
}

@end
