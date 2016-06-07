//
//  YKModelView.m
//  YKActionSheet.h YKActionSheet
//
//  Created by chenjiaxin on 15/10/29.
//  Copyright © 2015年 chenjiaxin. All rights reserved.
//

#import "UVModelView.h"

@implementation UVModelView
{
    BOOL _isadd;
}

- (id)initWithChildView:(UIView*)view_
{
    if(self = [super init])
    {
        
        _childView = view_;
        _type = UV_MODELVIEW_TYPE_BOTTOM;
        self.backgroundColor = [UIColor grayColor];
        
        self.alpha = 0.9f;
        self.userInteractionEnabled = YES;
        _isShow = NO;
        _isadd = NO;
        _autoHidden = YES;
        _animateDuration = 0.2f;
        _childView.userInteractionEnabled = YES;
        //[self addSubview:_childView];
        
    }
    return self;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint buttonPoint = [_childView convertPoint:point fromView:self];
    
    if(![_childView pointInside:buttonPoint withEvent:event] && _autoHidden)
    {
        [self hide];
    }

}

- (void)showInSupperView:(UIView*)view_
{
    if(_isShow)
    {
        return;
    }

    [view_ addSubview:self];
    [view_ addSubview:self.childView];
    _isadd = YES;

    CGRect frame = view_.frame;
    frame.origin.x = 0.f;
    frame.origin.y = 0.f;
    self.frame = frame;
    
   
    
    
    _isShow = YES;
    _childView.hidden = NO;
    [self bringSubviewToFront:_childView];
    self.hidden = NO;
    
    frame = _childView.frame;
    frame.origin.x = (CGRectGetWidth(self.frame)-CGRectGetWidth(_childView.frame))/2;
    switch (_type) {
        case UV_MODELVIEW_TYPE_BOTTOM:
        {
            frame.origin.y = self.frame.size.height;
            _childView.frame = frame;
            [UIView animateWithDuration:_animateDuration animations:^{
                CGRect frame = _childView.frame;
                frame.origin.y = self.frame.size.height - frame.size.height;
                _childView.frame = frame;
            }];
        }
            break;
        case UV_MODELVIEW_TYPE_MIDDLE:
        {
            frame.origin.y = (self.frame.size.height - CGRectGetHeight(_childView.frame))/2;
            _childView.frame = frame;
            _childView.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
            [UIView animateWithDuration:_animateDuration animations:^{
                _childView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            }];
        }

            break;
        default:
            break;
    }
    
}
- (void)hide
{
    if(!_isShow)return;
    _isShow = NO;
    switch (_type) {
        case UV_MODELVIEW_TYPE_BOTTOM:
        {
            [UIView animateWithDuration:_animateDuration animations:^{
                CGRect frame = _childView.frame;
                frame.origin.y = self.frame.size.height;
                _childView.frame = frame;
                
            } completion:^(BOOL finished) {
                [self doHide];
            }];
        }
            break;
        case UV_MODELVIEW_TYPE_MIDDLE:
            [self doHide];
            break;
        default:
            break;
    }
    
}

- (void)doHide
{
    [self removeFromSuperview];
    [self.childView removeFromSuperview];
    [self triggerHide];
}

- (void)triggerHide
{
    if(_delegate && [_delegate respondsToSelector:@selector(onUVModelViewHide:)])
    {
        [_delegate onUVModelViewHide:self];
    }
}
@end
