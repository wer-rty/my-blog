---
title: 快速幂
date: 2026-03-04 21:09:39
tags:
   - 随笔
   - 算法竞赛
   - 快速幂
categories:
   - 生活记录
mathjax: true
cover: /images/ksm.jpg
---

​                                                                这篇文章主要讲述算法方面快速幂相关的知识点

<!-- more -->

# 🛫 快速幂

具体的可以看oi-wiki上面的文章

[快速幂 - OI Wiki](https://oi-wiki.org/math/binary-exponentiation/)

快速幂鼠鼠其实在大二上的时候就接触过了，如果喜欢m的同学可以去信安数基上寻找一下，不过鼠鼠经常忘掉具体做法和代码实现，所以今天就来详细探讨一下

### 原理介绍

快速幂也称作二进制取幂或者平方取幂法是一个在**O（logn）**的时间内计算a^n的算法，而暴力的计算方法则是**O（n）**计算a的n次方需要将n个a依次相乘，但是当n太大或者a太大时每一次计算都会非常复杂，二进制取幂的想法是，将取幂的任务按照指数的 **二进制表示** 来分割成更小的任务比如说求解3的13次方，如果用连乘式，则需要计算12次

但是我们可以把13转换为二进制即1101，具体计算过程如下：
$$
\begin{aligned}
3^1 &= 3 \\
3^2 &= 9 \\
3^4 &= 81 \\
3^8 &= 6561 \\
3^{13} &= 3 \times 81 \times 6561 = 1594323
\end{aligned}
$$
这样只进行了5次乘法计算

这就是快速幂的基本想法。至于具体实现，有两种常见的版本，但是这里鼠鼠只学习迭代法，因为递归法的递归本身具有一定的开销（不常用）

下面是迭代法的代码

```c++
int ksm(int base,int pow)
{
    int res=1;
    while(pow>0)
    {
        if(pow&1)
        {
            res*=base;
        }
        base*=base;
        pow=pow>>1;   //pow>>=1;
    }
    return res;
}
```

带模运算的

```c++
int ksm(int base, int pow, int mod) {
    int res = 1;
    base %= mod;
    while (pow > 0) {
        if (pow & 1) {
            res = (res * base) % mod;
        }
        base = (base * base) % mod;
        pow >>= 1;
    }
    return res;
}
```

以上是简单快速幂的算法

### 矩阵快速幂

这是一个悲伤的故事，不过得先🕊️一下

咕咕咕......
