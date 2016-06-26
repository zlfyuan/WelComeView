//
//  WelcomeViewController.m
//  WelcomeView
//
//  Created by zluof on 16/5/19.
//  Copyright © 2016年 Mac. All rights reserved.
//


#define screen  [UIScreen mainScreen].bounds
#define WIDTH   screen.size.width
#define HEIGHT  screen.size.height

#define VIEWWIDTH self.view.frame.size.width
#define VIEWHEIGHT self.view.frame.size.height

#import "WelcomeViewController.h"

@interface WelcomeViewController ()<UIScrollViewDelegate>
{
    ///滚动视图
    UIScrollView *_scrollview;
    ///分页控制
    UIPageControl *_pageControl;
    ///图片View
    UIImageView * _imageview;
    ///图片View数组
    NSMutableArray *_imageViews;
    ///图片数组
    NSArray *_images;
    ///需要跳转的视图控制器
    UIViewController *_vc;
}
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(instancetype)initWelcomeView:(NSArray *)welcomeImages firstVC:(UIViewController *)VC{
    //重写init方法
    if (self = [super init]) {
        _images = welcomeImages;
        _imageViews = [NSMutableArray new];
        _vc = VC;
        [self creatWelcomeView];
        
    }
    return self;
}

/**
 * 创建基础控件
 */
-(void)creatWelcomeView
{
   
    /*
     添加滚动视图
     */
    _scrollview = [[UIScrollView alloc]initWithFrame:screen];
//    _scrollview.backgroundColor = [UIColor greenColor];
    _scrollview.pagingEnabled = YES;
    _scrollview.contentSize = CGSizeMake(WIDTH*_images.count, HEIGHT);
    _scrollview.delegate = self;
    [self.view addSubview:_scrollview];
    
    for (int i =0; i<_images.count; i++) {
        _imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[_images objectAtIndex:i]]];
//        NSLog(@"%@",[NSString stringWithFormat:@"%d.jpeg",i]);
        _imageview.frame = CGRectMake(i*WIDTH, 0, WIDTH, HEIGHT);
        _imageview.userInteractionEnabled = YES;
        [_imageview setTag:100+i];
        [_scrollview addSubview:_imageview];
        [_imageViews addObject:_imageview];
    }
    
    /*
     添加分页控制
     */
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, HEIGHT-80, WIDTH, WIDTH/4)];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = _images.count;
    _pageControl.tintColor = [UIColor colorWithWhite:255.0/254 alpha:1.0];
    _pageControl.currentPageIndicatorTintColor= [UIColor colorWithWhite:255.0/250 alpha:0.8];
    [_pageControl addTarget:self action:@selector(pageControlClicked) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    /**
     *可以在Imageview上添加你要的处理的事件，通过在imageview添加button 或者 手势 来处理事件
     */
    /*
     *这里我为最后一张图片添加点击手势 （进入下个视图控制器）
     */
    UITapGestureRecognizer *tapGo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapdo:)];
    /*
     遍历获取最后一个imageview
     */
    for (UIImageView *view in _imageViews) {
        if (view.tag-100 == _images.count - 1) {
            [view addGestureRecognizer:tapGo];
        }
    }
    
}

#pragma mark ----  touches Mtohed;
/**
 * 手势点击方法
 */
-(void)tapdo:(UITapGestureRecognizer*)tap
{
    [self showViewController:_vc  sender:nil];
}
/**
 * pagecontroll点击方法
 */
-(void)pageControlClicked
{
    [_scrollview scrollRectToVisible:CGRectMake(_pageControl.currentPage*VIEWWIDTH, 0, VIEWWIDTH, VIEWHEIGHT) animated:YES];
}

#pragma mark---scrollViewDelegate*******************************
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x-scrollView.frame.size.width/2)/self.view.frame.size.width+1;
    if (page >_pageControl.currentPage) {
        [_scrollview scrollRectToVisible:CGRectMake(page*VIEWWIDTH, 0, VIEWWIDTH, VIEWHEIGHT) animated:YES];
    }else{
        [_scrollview scrollRectToVisible:CGRectMake(page*VIEWWIDTH, 0, VIEWWIDTH, VIEWHEIGHT) animated:YES];
    }
    _pageControl.currentPage = page;
}

/**
 * 隐藏状态栏
 */
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
