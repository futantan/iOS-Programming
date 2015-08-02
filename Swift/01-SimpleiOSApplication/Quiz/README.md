# Attention

为了将`xib`的内容显示出来，我们需要做两处处理。

### OC版本

在`AppDelegate.m`文件中，对`- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`方法做如下处理

```Objective-C
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // 初始化指定的视图控制器，并将rootViewController设置为对应的视图控制器
    QuizViewController *quizVC = [[QuizViewController alloc]init];
    self.window.rootViewController = quizVC;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
```

重点就是将`window`的`rootViewController`设置为我们指定的`quizVC`。

而在`QuizViewController.m`中，需要载入`xib`文件，为此

```Objective-C
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // do sth.
    }
    return self;
}
```

在`OC`的版本中，这就大功告成了。

### Swift版本

同样，在`func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool`方法中设置`rootViewController`：

```Swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

    // 初始化指定的视图控制器，并将rootViewController设置为对应的视图控制器
    let quizVC = QuizViewController()
    self.window?.rootViewController = quizVC

    self.window?.backgroundColor = UIColor.whiteColor()
    self.window?.makeKeyAndVisible()
    return true
}
```

和OC版本并无任何区别，重点在于载入`xib`文件的地方。  
在`QuizViewController.swift`文件中，同样复写下面方法：  

```Swift
override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    // do sth.
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
}
```

然而这时编译器会报错  

`'required' initializer 'init(coder:)' must be provided by subclass of 'UIViewController'`  

缺少了相应的构造体，OK，修复一下，添加如下代码

```Swift
required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
}
```

这下编译就不会出错了，然后我们运行一下。哦吼！空白的界面，我们的界面并没有加载出来！  
[解决方法](http://japko.net/2014/09/08/loading-swift-uiviewcontroller-from-xib-in-storyboard/)  
（两种方法**任选其一**）

1. 将XIB文件命名改为`ModuleName.ClassName.xib`格式  
2. 在代码中显式加载

```Swfit
override func loadView() {
  NSBundle.mainBundle().loadNibNamed("QuizViewController", owner: self, options: nil)
}
```
