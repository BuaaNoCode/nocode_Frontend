# README

5/20/22：33push

提交了更新后的个人页面。

目前的问题有：

* 重设密码后，无法跳转至登陆界面，具体代码参见page/PersonPage.dart中class passworldUpdate，约第82行。
* 关于重设密码时需要的后端操作，暂时不知道咋写，封装至passwordReset函数中，传入参数为新密码，类型为String。