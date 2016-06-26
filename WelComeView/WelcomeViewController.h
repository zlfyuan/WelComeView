//
//  WelcomeViewController.h
//  WelcomeView
//
//  Created by zluof on 16/5/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController
/**
 * 创建一个引导页
 * @param  welcomeImages 引导页的图片数组
 * @param  VC 引导页之后的第一个视图控制器
 * @return  VC视图控制器
 */
-(instancetype)initWelcomeView:(NSArray *)welcomeImages firstVC:(UIViewController *)VC;
@end
