# Rosenblatt感知器测试脚本


`rosenblatt.rb`脚本生成data.m

通过`Mathematica`执行. 

以下问题没有搞清楚:

1. $\eta$的值`factor`, $0 < \eta \le 1$,如何确保$w_0$稳定
2. `data.shuffle!`是否必要?


缺陷

1. 重复执行会出现分类失败情形.

