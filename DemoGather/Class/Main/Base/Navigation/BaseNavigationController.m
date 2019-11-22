//
//  BaseNavigationController.m
//  DemoGather
//
//  Created by deepbaytech on 2019/11/22.
//  Copyright © 2019 SLQ. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.navigationBar.frame = CGRectMake(0, 20,SLQWidth, KNAVIGATIONBAR_HEIGHT);
    }else{
        self.navigationBar.frame = CGRectMake(0, 0,SLQWidth, KNAVIGATIONBAR_HEIGHT);
    }
    UIImage *image = [self createImageWithColor:[UIColor whiteColor]];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:YXFont(18),NSForegroundColorAttributeName:COLORFROM16(0x333333, 1)}];//修改导航栏标题的文字大小和粗细度
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置noraml状态下的样式
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSFontAttributeName]= [UIFont systemFontOfSize:15];
    itemAttrs[NSForegroundColorAttributeName]= COLORFROM16(0x444444, 1);
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    /// 清除导航栏下划线
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

/**
 *  手势识别器对象会调用这个代理方法来决定手势是否有效
 *
 *  @return YES : 手势有效, NO : 手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}
/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
        button.size = CGSizeMake(35, 40);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(leftNavAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)leftNavAction:(UIButton *)sender
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end
