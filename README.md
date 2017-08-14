# IFMShare
IFMShare是一个iOS客户端应用内分享的界面、功能一体化解决方案，使用简单、优雅，界面和功能高度可定制化。分享功能直接调用iOS系统内预制分享功能，无需去各种繁杂的社会化分享平台注册账号、无需下载导入各种SDK，使用非常简单。

# Demo展示

![图片展示](http://upload-images.jianshu.io/upload_images/953487-f3ff921129424626.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![图片展示](http://upload-images.jianshu.io/upload_images/953487-fba1892bb8d8bdf0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# GIF展示

![动图展示](http://upload-images.jianshu.io/upload_images/953487-1b3b9c5eb4ea7ec7.gif?imageMogr2/auto-orient/strip)

# 使用

在项目中导入`IFMShareView.h`，执行以下代码即可

```
 IFMShareView *shareView = [[IFMShareView alloc] initWithItems:@[IFMPlatformNameSms,IFMPlatformNameEmail,IFMPlatformNameQQ,IFMPlatformNameWechat] itemSize:CGSizeMake(80,100) DisplayLine:YES];
 
 //设置分享内容
[shareView addText:@"分享测试"];
[shareView addURL:[NSURL URLWithString:@"http://www.baidu.com"]];
[shareView addImage:image];
    
[shareView showFromControlle:self];
```
# 介绍
IFMShare由三个类组成，`IFMShareView、IFMShareItem`和`IFMShareItemCell`。其中`IFMShareItemCell`是`UICollectionView`的单元格，用户可以忽略它，
### IFMShareItem
`IFMShareItem`是每一个要展示的`cell`的数据源，它有三种初始化方法，

```
- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                       action:(shareHandle)action;

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                   actionName:(NSString *)actionName;

- (instancetype)initWithPlatformName:(NSString *)platformName;
```
`- (instancetype)initWithPlatformName:(NSString *)platformName;`只需要传入预制的分享平台名称，比如：

```
IFMPlatformNameSina;  // 新浪微博
IFMPlatformNameQQ;    //QQ
IFMPlatformNameEmail; //邮箱
IFMPlatformNameSms;   //短信
```
即可快速初始化一个包括`title、image和action`的分享`cell`。

如果提供的image不符合您的要求，您可以使用以下方法初始化一个`IFMShareItem`。

```
- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                   actionName:(NSString *)actionName;
```
其中`actionName`传入预制的分享`action`，比如：

```
IFMPlatformHandleSina;  // 新浪微博
IFMPlatformHandleQQ;    //QQ
IFMPlatformHandleEmail; //邮箱
IFMPlatformHandleSms;   //短信
```
如果预制的`action`不能满足您的分享内容类型，还可以使用以下方法，

```
- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                       action:(shareHandle)action;
```
`action`是一个Block块，类型如下，

```
typedef void (^__nullable shareHandle)(IFMShareItem *item);
```
您可以在这个Block块里写入点击按钮以后需要执行的动作。
### IFMShareView
`IFMShareView`是包含了所有展示控件的View，提供了三种初始化方法

```
- (instancetype)initWithItems:(NSArray *)items itemSize:(CGSize)itemSize DisplayLine:(BOOL)inLine;
- (instancetype)initWithShareItems:(NSArray *)shareItems functionItems:(NSArray *)functionItems itemSize:(CGSize)itemSize;
- (instancetype)initWithItems:(NSArray *)items countEveryRow:(NSInteger)count;//默认九宫格样式
```
如果您要展示的是一个单行的分享界面，使用以下方法：

```
- (instancetype)initWithItems:(NSArray *)items itemSize:(CGSize)itemSize DisplayLine:(BOOL)inLine;
```
如果是双行，您一定猜到了，使用以下方法：

```
- (instancetype)initWithShareItems:(NSArray *)shareItems functionItems:(NSArray *)functionItems itemSize:(CGSize)itemSize;
```
其中`itemSize`是需要传入的`IFMShareItemCell`大小，IFMShareView会根据传入的`itemSize`自动调整自己的大小。如果您想使用默认大小，传入一个预制的宏`IFMShareItemCellSize`，为`CGSizeMake(80, 100)`，`shareItems`是第一行的分享性质的按钮数组，`functionItems`是第二行功能性质的按钮数组，存放的是`IFMShareItem`或者预制的分享平台名称，比如：`IFMPlatformNameSina、IFMPlatformNameEmail`。

如果您要使用的分享界面是一个九宫格类型的，使用以下初始化方法

```
- (instancetype)initWithItems:(NSArray *)items countEveryRow:(NSInteger)count;//默认九宫格样式
```
`count`表示每一行展示的item个数，

# 个性化
除了以上功能，`IFMShare`还提供了丰富的可定制属性。

```
@property (nullable, nonatomic, strong) UIView *headerView;//头部分享标题
@property (nullable, nonatomic, strong) UIView *footerView;//尾部其他自定义View
```
可以传入用户绘制好的头部和尾部的View，`IFMShareView`会将它们放在合适的位置。

```
@property (nonatomic, strong) UIButton *cancleButton;//取消
```
用户可以获取到底部取消按钮，修改它的背景色、标题、圆角等。

```
@property (nullable, nonatomic, strong) UIColor *middleLineColor;//分割线颜色
@property (nonatomic) CGFloat middleLineEdgeSpace;//分割线边距
@property (nonatomic) CGFloat middleTopSpace;//分割线距离上部按钮距离
@property (nonatomic) CGFloat middleBottomSpace;//分割线距离下部按钮距离
```
可以设置分割线的各种属性，以及以下属性：

```
@property (nullable, nonatomic, strong) UIColor *containViewColor;
@property (nullable, nonatomic, strong) UIFont *itemTitleFont; //标题字体大小
@property (nullable, nonatomic, strong) UIColor *itemTitleColor; //标题字体颜色

@property (nonatomic) UIEdgeInsets bodyViewEdgeInsets;//中间bodyView的边距;
@property (nonatomic) CGSize itemSize; //item大小
@property (nonatomic) CGSize itemImageSize; //item中image大小
@property (nonatomic) BOOL showBorderLine; //是否显示cell边界线
@property (nonatomic) CGFloat itemImageTopSpace; //item图片距离顶部大小
@property (nonatomic) CGFloat iconAndTitleSpace; //item图片和文字距离
@property (nonatomic) CGFloat itemSpace;//item横向间距
@property (nonatomic) BOOL showsHorizontalScrollIndicator;//是否显示横向滚动条
@property (nonatomic) BOOL showCancleButton;//是否显示取消按钮
```
您可以试着玩一玩。使用过程中有任何问题，请在issue中提出，或者邮件联系我，或者关注我的新浪微博[@小刘大刚](http://weibo.com/liugangios/home?wvr=5&sudaref=www.baidu.com&retcode=6102)，我会及时修改更新，谢谢您的支持，希望我的代码可以给您灵感，同时也帮助我成长，世界因为开源而美好。

# TODO
* [ ] 支持cocoapods
* [ ] 加入更多预制平台
* [ ] 介绍对比4种分享方案



