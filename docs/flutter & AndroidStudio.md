# flutter & AndroidStudio

## flutter的下载与配置

flutter是Google推出的基于Dart语言开发的跨平台开源UI框架，能够支持安卓与iOS。

flutter框架的下载地址为：

* [Windows](https://flutter.dev/docs/development/tools/sdk/releases?tab=windows)
* [macOS](https://flutter.dev/docs/development/tools/sdk/releases?tab=macos)
* [Linux](https://flutter.dev/docs/development/tools/sdk/releases?tab=linux)

若在上述网址中无法顺利下载，也可以去flutter的github[下载](https://github.com/flutter/flutter)，注意，github上flutter包含不稳定的测试版，目前flutter-1.17.0-stable为最近的稳定版。

在下载后，将zip压缩文件解压至你希望的flutter安装路径即可，在这里，笔者的解压路径为D:\flutter。

在解压后，需要配置一些环境变量，在用户变量中新增：

```
FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn
PUB_HOSTED_URL https://pub.flutter-io.cn
```

在系统环境变量加入你的flutter的bin目录路径。

这是因为调用该框架时可能需要进行下载，这两个网址是flutter的国内镜像，镜像网址可能会更新，具体请参考[这里](https://github.com/flutter/flutter/wiki/Using-Flutter-in-China)。

在完成上述步骤后，找到flutter路径下的flutter_console.bat，运行并键入命令：

```
flutter doctor
```

第一次使用可能会耗时较长。此时可能会部分报错，请先忽略并进入接下来Android相关配置。

## AndroidStudio的下载与配置

点击[这里](https://developer.android.com/studio/index.html)根据所需版本进行下载，按照指引进行安装即可。

完成后再使用flutter doctor命令(在cmd即可)。

若所有配置完全正确，则该命令显示应该如下：

```
Doctor summary (to see all details, run flutter doctor -v):
[√] Flutter (Channel stable, v1.17.0, on Microsoft Windows [Version 10.0.17763.1217], locale zh-CN)

[√] Android toolchain - develop for Android devices (Android SDK version 29.0.3)
[√] Android Studio (version 3.6)
[√] IntelliJ IDEA Ultimate Edition (version 2019.3)
[!] Connected device
    ! No devices available

! Doctor found issues in 1 category.
```

第五个为!是因为还没有连接安卓设备或者安卓虚拟机。

若：

* 第一项报错，建议重新下载flutter。

* 第二项报错，请键入下面命令：

  ```
  flutter doctor --android-licenses
  ```

  若有提问y/n，全选y即可。若失败后，

  提示类似于：

  ```
  Exception in thread "main" java.lang.NoClassDefFoundError: javax/xml/bind/annotation/XmlSchema
          at com.android.repository.api.SchemaModule$SchemaModuleVersion.<init>(SchemaModule.java:156)
          at com.android.repository.api.SchemaModule.<init>(SchemaModule.java:75)
          at com.android.sdklib.repository.AndroidSdkHandler.<clinit>(AndroidSdkHandler.java:81)
          at com.android.sdklib.tool.sdkmanager.SdkManagerCli.main(SdkManagerCli.java:73)
          at com.android.sdklib.tool.sdkmanager.SdkManagerCli.main(SdkManagerCli.java:48)
  Caused by: java.lang.ClassNotFoundException: javax.xml.bind.annotation.XmlSchema
          at java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:583)
          at java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:178)
          at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:521)
          ... 5 more
  ```

  检查你的电脑是否配置好了JDK，若没有，百度Java环境配置，若有，请查看你的JDK版本，flutter支持JDK8，对于更高的版本，会因为部分文件的确实而报错，有两种解决办法：

  * 降低JDK版本

  * 下载相关依赖文件，可以在[这里](https://github.com/BuaaNoCode/nocode_Frontend/tree/lzyckd1-development/docs)下载，将此压缩包中的文件解压，将里面的文件复制至android的\sdk\tools\jaxb路径中并去除版本号，若没有则新建。

    再在android的\sdk\tools\bin路径下找到sdkmanager.bat，在约66行处找到一行set ...，修改为

    ```
    set CLASSPATH=%APP_HOME%\jaxb\activation.jar;%APP_HOME%\jaxb\jaxb-impl.jar;%APP_HOME%\jaxb\jaxb-xjc.jar;%APP_HOME%\jaxb\jaxb-core.jar;%APP_HOME%\jaxb\jaxb-jxc.jar;%APP_HOME%\jaxb\jaxb-api.jar;%APP_HOME%\jaxb\istack-commons-runtime.jar;%APP_HOME%\lib\dvlib-26.0.0-dev.jar;%APP_HOME%\lib\jimfs-1.1.jar;%APP_HOME%\lib\jsr305-1.3.9.jar;%APP_HOME%\lib\repository-26.0.0-dev.jar;%APP_HOME%\lib\j2objc-annotations-1.1.jar;%APP_HOME%\lib\layoutlib-api-26.0.0-dev.jar;%APP_HOME%\lib\gson-2.3.jar;%APP_HOME%\lib\httpcore-4.2.5.jar;%APP_HOME%\lib\commons-logging-1.1.1.jar;%APP_HOME%\lib\commons-compress-1.12.jar;%APP_HOME%\lib\annotations-26.0.0-dev.jar;%APP_HOME%\lib\error_prone_annotations-2.0.18.jar;%APP_HOME%\lib\animal-sniffer-annotations-1.14.jar;%APP_HOME%\lib\httpclient-4.2.6.jar;%APP_HOME%\lib\commons-codec-1.6.jar;%APP_HOME%\lib\common-26.0.0-dev.jar;%APP_HOME%\lib\kxml2-2.3.0.jar;%APP_HOME%\lib\httpmime-4.1.jar;%APP_HOME%\lib\annotations-12.0.jar;%APP_HOME%\lib\sdklib-26.0.0-dev.jar;%APP_HOME%\lib\guava-22.0.jar
    
    ```

    修改后运行这个bat文件，在powershell中：

    ```
    sdkmanager.bat --update
    ```

    应该就会正常。

    之后再在cmd中flutter doctor  --android-licenses，全选y即可。

* 第三项报错，是AndroidStudio的版本问题。

* 第四项报错，是IDEA的版本问题。IDEA可在下载一些插件后进行flutter编程。

之后，启动AndroidStudio，第一次启动时时是没有项目的，找到configure-plugins，搜索dart和flutter，下载这两个插件。重启，应该就会有项目是flutter类型的新建选项。

选择flutter类型新建项目，填入你的flutter的路径，在新建时有数种flutter项目类型，选择第一种即可，生成新项目。此时左侧可以看见项目文件结构，在main.dart中将代码替换为：

```
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new Text('Hello World'),
        ),
      ),
    );
  }
}
```

这是我们flutter的hello world。

这是是无法运行的，因为没有相应的安卓设备或虚拟机，请在tool中找到AVD Manager，选择一个虚拟机下载并启用，即可运行代码，相应的，你的Android虚拟机上可以看见一行hello world。

在这里，可能会遇到bug，请在cmd中打开/项目名/android路径利用gradlew进行debug，这类命令可以得到详细信息。



