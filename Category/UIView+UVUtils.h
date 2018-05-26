//
//  UIView+UVUtils.h
//  UVCocoaLibrary
//
//  Created by selectersky on 9/29/13.
//  Copyright (c) 2013 XXXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface UIView (UVUtils)

/**
*  显示提示信息
*
*  @param message_ 要提示的信息 1秒后自动隐藏
*/
- (void)uv_iToastMessage:(NSString*)message_;
/**
 *  显示进度
 *
 *  @param mess 进度上要显示的文字 如果为nil则文字不显示
 *
 *  @return MBProgressHUD
 */
- (MBProgressHUD*)uv_progress:(NSString*)message_;
/**
 *  显示错误提示框
 *
 *  @param message_ 提示框上的文字信息，如果为nil则文字不显示
 */
- (void)uv_showError:(NSString*)message_;
/**
 * 删除所有子视图
 */
-(void)uv_removeAllSubView;
/**
 * 使用Block向视图添加点击事件 
 *
 * 注：目前只支持顶多只能添加一个点击事件 重复添加会覆盖原来的事件
 * 
 * @param BLOCK 视图点击后执行的代码
 * @return UITapGestureRecognizer
 */
- (UITapGestureRecognizer*)uv_addClickWithBlock:(void (^)(void))block;

/**
 * 向视图添加点击事件
 *
 * 注：目前只支持顶多只能添加一个点击事件 重复添加会覆盖原来的事件
 *
 * @param id target_
 * @param SEL 视图点击后执行的代码
 * @return UITapGestureRecognizer
 */
- (UITapGestureRecognizer*)uv_addClickWithSel:(id)target_ sel:(SEL)sel_;

/**
 * 移除添加的点击事件
 *
 */
- (void)uv_removeClickWithBlockAndSel;


/**
 *  显示一个类型Tab的Badge值
 *
 *  @param strBadgeValue 要显示的值
 *
 *  @return Badge对象
 */
- (UIView *)uv_showBadgeValue:(NSString *)strBadgeValue;


/**
 *  设置视图圆角
 *
 *  @param radius_ 圆角大小
 */
- (void)uv_makeCornerRadius:(CGFloat)radius_;

/**
 *  给View增加虚线
 *
 *  @param color_ 虚线颜色 默认为 #666666
 *  @param dash_  虚线宽度和间隔 为数字数组 默认为 @[@4, @2]
 */
- (void)uv_strokeWithColor:(UIColor*)color_ lineDashPattern:(NSArray *)dash_;
/**
 *  给视图底部增加一条线
 *
 *  @param height_ 线的高度 会自动根据屏幕scale设置
 *  @param color_  线的颜色
 */
- (void)uv_addBottomLine:(CGFloat)height_ color:(UIColor*)color_;

@end
