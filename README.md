# ZhiHuDaily
1.Project Introduce：
The project is an extreme similar copy of ZhiHuDaily (client : IOS, version : 2.5.3)
What we should draw attention is that the new API is different from the 2.5.2 version. I will arrange the example of the new version;

2.The main feature in the project:
2.1 show the news list
2.2 show the news detail
2.3 complete the menu page whose effect is similiar with the drawer.

3.The main problem in the coding
3.1 the headView of the news list and news detail
3.2 the drawer effect
3.3 the feature if the news detail's footerView.
3.4 pull up and drag down to refresh or load more
3.5 pull up and drag down in the news detail;

4.The 3rd party in the project:
CocoaPod : the 3rd party managerment of the project
AFnetworking ：the web request
Masonry ：Autolayout 
SDWebImage : the download and cache of the web image
ReactiveCocoa : RAC, 
Mantle：JSON deserialization
ECSlidingViewController：the drawer effect (temporary)

5.How to run the project
5.1 install the CocoaPod
5.2 pod install under the project catalogue
5.3 open ZhiHuDaily.xcworkspace

6.other explain：
The code is used for the IOS study. Everybody is forbidded using for business. Contact me if you have any problem.

1.工程介绍：
工程是高仿知乎日报iOS客户端（版本号：2.5.3）
API改动较上个版本有些出入，之后我会整理相关的日报的API使用情况

2.工程主要实现以下功能：
2.1 新闻消息列表的获取展示
2.2 消息详情展示
2.3 菜单抽屉效果的实现

3.工程中主要解决的问题
3.1 HeadView（列表页和详情页）
3.2 抽屉效果（待实现）
3.3 详情页FooterView的功能栏
3.4 上拉刷新和下拉获取更多
3.5 新闻详情页上拉获取上一条新闻详情，下拉获取下一条新闻详情

4.工程中使用的第三方库包括
CocoaPod : 工程库的管理
AFnetworking ：网络请求
Masonry ：Autolayout自动布局
SDWebImage : 网络图片的下载和缓存
ReactiveCocoa ：利用函数式编程和响应式编程解决消息响应和传递
Mantle：JSON解析
ECSlidingViewController：实现菜单抽屉效果的第三方库

5.工程运行方法
5.1 安装CocoaPod，安装方法请戳
5.2 在工程目录运行pod install
5.3 open ZhiHuDaily.xcworkspace

6.其他说明
［特此声明］工程主要是为了学习iOS工程开发，严谨商用。如果有侵犯版权问题，请与本人联系，可将代码文件删除。
