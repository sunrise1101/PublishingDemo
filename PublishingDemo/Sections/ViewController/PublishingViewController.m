//
//  PublishingViewController.m
//  PublishingDemo
//
//  Created by 邓旭东 on 2017/12/21.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#import "PublishingViewController.h"
#import "PublishingButton.h"

@interface PublishingViewController ()

@property (nonatomic, strong) NSMutableArray *buttonsMArray;
@property (nonatomic, assign) NSUInteger upIndex;
@property (nonatomic, assign) NSUInteger downIndex;
@property (nonatomic, strong) UIImageView *closeImgView;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation PublishingViewController {
    NSTimer *_startTimer;
    NSTimer *_endTimer;
}

- (void)dealloc {
    [_startTimer invalidate];
    [_endTimer invalidate];
    
    _startTimer = nil;
    _endTimer = nil;
}

#pragma mark - ------------------------------------------------------------------
#pragma mark - lazy loading
- (NSMutableArray *)buttonsMArray {
    if (!_buttonsMArray) {
        _buttonsMArray = [NSMutableArray array];
    }
    return _buttonsMArray;
}

-(NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSArray array];
        _imageArray = @[@"ic_independent_service",@"ic_cooperative_service"];
    }
    return _imageArray;
}

//重新初始化主视图样式 透明->
-(void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setBackgroundColor:[UIColor blackColor]];
    //获取截取的背景图片，便于达到模糊背景效果
    UIImageView *imgView = [[UIImageView alloc]initWithImage:_backImg];
    //模糊效果层
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = [UIScreen mainScreen].bounds;
    [imgView addSubview:effectView];
    [view addSubview:imgView];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加菜单按钮
    [self setMenu];
    //添加底部关闭按钮
    [self insertCloseImg];
    //定时器控制每个按钮弹出的时间
    //在这里，创建了一个self的弱引用，然后让块捕获了这个self变量，让其在执行期间存活。
    __weak typeof(self)weakSelf = self;
    _startTimer = [NSTimer dxd_scheduledTimerWithTimeInterval:0.1 block:^{
        //一旦外界指向该类的最后一个引用消失，该类就会被释放，被释放的同时，也会向NSTimer发送invalidate消息（因为在该类的dealloc方法中向NSTimer发送了invalidate消息）。
        //而且，即使在dealloc方法里没有发送invalidate消息，因为块里的weakSelf会变成nil，所以NSTimer同样会失效。
        [weakSelf popupBtn];
    } repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_startTimer forMode:NSRunLoopCommonModes];
    //添加手势点击事件
    @weakify(self);
    //防止重复点击
    PBMAINDelay(0.5, ^{
        @strongify(self);
        UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchesBegan:)];
        [self.view addGestureRecognizer:touch];
    });
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.6 animations:^{
        self->_closeImgView.transform = CGAffineTransformRotate(self->_closeImgView.transform, M_PI/2);
    }];
}

//关闭图片
- (void)insertCloseImg{
    UIImage *img = [UIImage imageNamed:@"ic_close"];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    imgView.frame = CGRectMake(self.view.center.x-dxd_autoResize(9), self.view.frame.size.height-dxd_autoResize(48), dxd_autoResize(18), dxd_autoResize(18));
    [self.view addSubview:imgView];
    _closeImgView = imgView;
}

- (void)popupBtn{
    if (_upIndex == self.buttonsMArray.count) {
        [_startTimer invalidate];
        _upIndex = 0;
        return;
    }
    
    PublishingButton *btn = self.buttonsMArray[_upIndex];
    [self setUpOneBtnAnim:btn];
    
    _upIndex++;
}

//设置按钮从第一个开始向上滑动显示
- (void)setUpOneBtnAnim:(UIButton *)btn {
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        btn.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        //获取当前显示的菜单控件的索引
        self->_downIndex = self.buttonsMArray.count - 1;
    }];
    
}

//按九宫格计算方式排列按钮
- (void)setMenu{
    
    int cols = 2;
    int col = 0;
    int row = 0;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = dxd_autoResize(80);
    CGFloat h = dxd_autoResize(100);
    
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - cols * w) / (cols + 1);
    
    //此处按照不同屏幕尺寸适配
    CGFloat oriY = [UIScreen mainScreen].bounds.size.height == 812 ? dxd_autoResize(545) : dxd_autoResize(400);
    for (int i = 0; i < self.imageArray.count; i++) {
        NSArray *arrTitle = @[@"自主服务",@"合作服务"];
        PublishingButton *btn = [PublishingButton buttonWithType:UIButtonTypeCustom];
        //图标图片和文本
        UIImage *img = [UIImage imageNamed:self.imageArray[i]];
        NSString *title = arrTitle[i];
        
        [btn setImage:img forState:UIControlStateNormal];
        [btn setImage:img forState:UIControlStateHighlighted];
        [btn setTitle:title forState:UIControlStateNormal];
        
        //列数(个数除总列数取余)
        col = i % cols;
        //行数(个数除总列数取整)
        row = i / cols;
        //x 平均间隔 + 前图标宽度
        x = margin + col * (margin + w);
        //y 起始y + 前宽度
        y = row * (margin + h) + oriY;
        
        btn.frame = CGRectMake(x, y, w, h);
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(touchDownBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsMArray addObject:btn];
        [self.view addSubview:btn];
    }
}

//点击按钮进行放大动画效果直到消失
- (void)touchDownBtn:(PublishingButton *)btn{
    [self dismissViewControllerAnimated:NO completion:^{
        PBCall(self.dismissVC, btn.tag);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeScale(2.0, 2.0);
        btn.alpha = 0;
    }];
    
}

//设置按钮从后往前下落
- (void)returnUpVC {
    if (_downIndex == -1) {
        [_endTimer invalidate];
        return;
    }
    PublishingButton *btn = self.buttonsMArray[_downIndex];
    [self setDownOneBtnAnim:btn];
    _downIndex--;
}

//按钮下滑并返回上一个控制器
- (void)setDownOneBtnAnim:(UIButton *)btn {
    [UIView animateWithDuration:0.6 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

//点击事件返回上一控制器,并且旋转145弧度关闭按钮
-(void)touchesBegan:(UITapGestureRecognizer *)touches{
    __weak typeof(self)weakSelf = self;
    _endTimer = [NSTimer dxd_scheduledTimerWithTimeInterval:0.1 block:^{
        [weakSelf returnUpVC];
    } repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_endTimer forMode:NSRunLoopCommonModes];
    [UIView animateWithDuration:0.3 animations:^{
        self->_closeImgView.transform = CGAffineTransformRotate(self->_closeImgView.transform, -M_PI_2 * 1.5);
    }];
}


@end
