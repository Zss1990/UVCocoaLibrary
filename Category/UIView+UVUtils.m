//
//  UIView+Utils.m
//  UVCocoaLibrary
//
//  Created by selectersky on 9/29/13.
//  Copyright (c) 2013 XXXX. All rights reserved.
//

#import "UIView+UVUtils.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "UVUtils.h"

static char kActionHandlerTapGestureKey;
static char kActionHandlerTapBlockKey;

@implementation UIView (UVUtils)
- (MBProgressHUD*)uv_progress:(NSString*)text_
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    //    hud.color = [UIColor colorWithRed:77.0f/255.0f green:185.0/255.0f blue:237.0/255.0f alpha:.8f];
    hud.animationType = MBProgressHUDAnimationFade;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text_;
    hud.removeFromSuperViewOnHide = YES;
    return  hud;
}

- (void)uv_showError:(NSString*)text_
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    //    hud.color = [UIColor colorWithRed:77.0f/255.0f green:185.0/255.0f blue:237.0/255.0f alpha:0.8f];
    [self addSubview:hud];
    UVUtils *utils = [UVUtils new];
    NSBundle *bundle = [utils bundle];
    UIImage *image = [UIImage imageNamed:@"hub_icon_error" inBundle:bundle compatibleWithTraitCollection:nil];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    
    // Set custom view mode
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.detailsLabelText = text_;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:1];
}

- (void)uv_iToastMessage:(NSString*)text_
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    //    hud.color = [UIColor colorWithRed:77.0f/255.0f green:185.0/255.0f blue:237.0/255.0f alpha:0.8f];
    [self addSubview:hud];
    UVUtils *utils = [UVUtils new];
    NSBundle *bundle = [utils bundle];
    
    UIImage *image = [UIImage imageNamed:@"hub_icon_notice" inBundle:bundle compatibleWithTraitCollection:nil];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Set custom view mode
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.detailsLabelText = text_;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:1];
}

-(void)uv_removeAllSubView
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

- (UITapGestureRecognizer*)uv_addClickWithBlock:(void (^)(void))block
{
    self.userInteractionEnabled = YES;
	UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
	
	if (!gesture)
    {
		gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uv_handleActionForTapGesture:)];
		[self addGestureRecognizer:gesture];
		objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
	}
    
	objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
    return gesture;
}

- (UITapGestureRecognizer*)uv_addClickWithSel:(id)target_ sel:(SEL)sel_
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target_ action:sel_];
    [self addGestureRecognizer:gesture];
    objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    return gesture;
}

- (void)uv_removeClickWithBlockAndSel
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if(!gesture)
    {
        [self removeGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, NULL, OBJC_ASSOCIATION_RETAIN);
    }
    id block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
    if(!block)
    {
        objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, NULL, OBJC_ASSOCIATION_COPY);
    }
}

- (void)uv_handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateRecognized)
    {
		void(^action)(void) = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
		
		if (action)
        {
			action();
		}
	}
}

- (UIView *)uv_showBadgeValue:(NSString *)strBadgeValue
{
    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:0];
    item.badgeValue = strBadgeValue;
    NSArray *array = [[NSArray alloc] initWithObjects:item, nil];
    tabBar.items = array;

    //寻找
    for (UIView *viewTab in tabBar.subviews) {
        for (UIView *subview in viewTab.subviews) {
            NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
            if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
                [strClassName isEqualToString:@"_UIBadgeView"]) {
                //从原视图上移除
                [subview removeFromSuperview];
                //
                [self addSubview:subview];
                subview.frame = CGRectMake(self.frame.size.width-subview.frame.size.width/2, -subview.frame.size.height/2,
                                           subview.frame.size.width, subview.frame.size.height);
                return subview;
            }
        }
    }
    return nil;
}

- (void)uv_removeBadgeValue
{
    //
    for (UIView *subview in self.subviews) {
        NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
        if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
            [strClassName isEqualToString:@"_UIBadgeView"]) {
            [subview removeFromSuperview];
            break;
        }
    }
}

//设置视图圆角
- (void)uv_makeCornerRadius:(CGFloat)radius_
{
    self.layer.cornerRadius = radius_;
    self.layer.masksToBounds = YES;
}

- (void)uv_strokeWithColor:(UIColor*)color_ lineDashPattern:(NSArray *)dash_
{
    if(!dash_)
    {
        dash_ = @[@4, @2];
    }
    
    if(!color_)
    {
        color_ = [UIColor colorWithRed:102.f/255.f green:102.f/255.f blue:102.f/255.f alpha:1.f];
    }
    
    CAShapeLayer *_border = [CAShapeLayer layer];
    _border.strokeColor = color_.CGColor;
    _border.fillColor = nil;
    _border.lineDashPattern = dash_;
    _border.masksToBounds = self.layer.masksToBounds;
    _border.cornerRadius = self.layer.cornerRadius;
    [self.layer addSublayer:_border];
    
    _border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    _border.frame = self.bounds;
}
- (void)uv_addBottomLine:(CGFloat)height_ color:(UIColor*)color_
{
    [self layoutIfNeeded];
    CGFloat height = height_ / [UIScreen mainScreen].scale;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-height, CGRectGetWidth(self.frame), height)];
    line.backgroundColor = color_;
    [self addSubview:line];
}
@end
