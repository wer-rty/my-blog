---
title: 前缀和&差分
date: 2026-03-09 13:35:44
tags:
  - 算法知识点
  - 前缀和&差分
categories: 
  - 算法知识点总结
mathjax: true
---

本篇主要介绍一下前缀和&差分

<!-- more -->

### 前缀和&差分

参考文章：[前缀和 & 差分 - OI Wiki](https://oi-wiki.org/basic/prefix-sum/)  [一篇带你速通差分算法（C/C++）-CSDN博客](https://blog.csdn.net/m0_73633807/article/details/141756599)

#### 前缀和

##### I.普通前缀和

介绍：前缀和可以简单理解为「数列的前 𝑛项的和」，是一种重要的预处理方式．主要用于快速求区间和对于长度为 𝑛的序列 {𝑎𝑖}，如果要多次查询区间 [𝑙,𝑟] 中序列数字的和，就可以考虑使用前缀和．序列的前缀和就是
$$
S_i=\sum_{j=1}^{i}a_j
$$
它可以通过递推关系式
$$
S_0=0,S_i=S_{i-1}+a_i
$$
逐项计算得到．要询问区间 [𝑙,𝑟]![[l,r]](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 内的序列的和，只需要计算差值
$$
S([l,r])=S_r-S_{l-1}
$$
就这样，通过 𝑂(𝑛)![O(n)](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 时间预处理，能够将单次查询区间和的复杂度降低到 𝑂(1)![O(1)](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)．

代码如下：

```c++
#include<bits/stdc++.h>
using namespace std;
#define int long long
signed main()
{
    int n;
    cin>>n;
    vector<int>a(n+1);
    vector<int>pre(n);
    pre[0]=0;
    for(int i=1;i<=n;i++)
    {
        pre[i]=pre[i-1]+a[i];
    }
}
```

##### II.二维前缀和

当题目出现矩阵时，说明就涉及到了二维前缀和，其模型可以抽象为矩阵，给定大小为 𝑚 ×𝑛 的二维数组 𝐴，要求出其前缀和 𝑆．那么，𝑆 同样是大小为 𝑚 ×𝑛 的二维数组，且
$$
S_{i,j}=\sum_{e=1}^{i}\sum_{f=1}^{j}A_{e,f}
$$
类比一维的情形，𝑆𝑖,𝑗 应该可以基于 𝑆𝑖−1,𝑗或 𝑆𝑖,𝑗−1 计算，从而避免重复计算前面若干项的和．但是，如果直接将 𝑆𝑖−1,𝑗和 𝑆𝑖,𝑗−1
 相加，再加上 𝐴𝑖,𝑗，会导致重复计算 𝑆𝑖−1,𝑗−1 这一重叠部分的前缀和，所以还需要再将这部分减掉．这就是 容斥原理．由此得到如下递推关系：
$$
S_{i,j}=S_{i-1,j}+S_{i,j-1}+A_{i,j}-S_{i-1,j-1}
$$
实现时，直接遍历 (𝑖,𝑗)求和即可．

代码如下：

```c++
 int n;
    cin>>n;
    int b[n+1][n+1];
    int presum[n+1][n+1];
    for(int j=0;j<=n;j++)
    {
        b[0][j]=0;
    }
    for(int i=0;i<=n;i++)
    {
        b[i][0]=0;
    }
    for(int i=1;i<=n;i++)
    {
        for(int j=1;j<=n;j++)
        {
            cin>>b[i][j];
            presum[i][j]=b[i][j]+presum[i-1][j]+presum[i][j-1]-presum[i-1][j-1];
        }
    }
```



#### 差分

差分算法的核心思想是利用已有的数据序列，通过计算相邻元素之间的差值来生成一个新的序列。对于一个给定的序列 a=[a1,a2,...,an]，其差分序列 d 可以表示为：d[i]=a[i]−a[i-1]。差分数组长度一般为原定序列长度+1，即：len=n+1。其中，d[0] 通常被定义为0，或者根据具体应用场景进行特殊处理。

一维差分在修改区间时效率非常高，时间复杂度可以达到 O(1)，我们通过对差分数组的修改以达到修改原数组的目的，那么如何修改差分数组，比如在数组a的[l,r]区间上的数统一+c，转化为差分数组为d[l]+c，d[r+1]-c，这样我们再利用前缀和还原便可以得到原数组修改后的值。在还原时，只需要将前i位差分数组相加便可以得到原数组，比如还原第三位，a[3]=d[1]+d[2]+d[3]，便可以还原其值，其还原的第n+1位一定是0。

具体的还是看第二篇博客吧

##### 例题一.差分+二分以及一点小优化

[P1083 [NOIP 2012 提高组\] 借教室 - 洛谷](https://www.luogu.com.cn/problem/P1083)

这题的话鼠鼠一开始只打算用差分，结果很明显超时了，所以鼠鼠用二分优化，假设在第mid天会超过，慢慢二分搜索，结果还是会t，最后就加了一点小优化，记录下前一次的差分结果，在此基础上进行计算，AC了。

下面是代码

```c++
//借教室
//只用差分是不行的
#include<bits/stdc++.h>
using namespace std;
#define int long long
int check(int mid,vector<int>&dif,vector<vector<int>>h,int n,int &last)
{
    if(last<=mid)
    {
        int d,s,t;
        for(int i=last+1;i<=mid;i++)
        {
           d=h[i][0];
           s=h[i][1];
           t=h[i][2];
           dif[s]-=d;
           dif[t+1]+=d;
        }
    }
    else
    {
        int d,s,t;
        for(int i=last;i>mid;i--)
        {
           d=h[i][0];
           s=h[i][1];
           t=h[i][2];
           dif[s]+=d;
           dif[t+1]-=d;
        }
    }
    int temp=0;
    int flag=1;
    for(int i=1;i<=n;i++)
    {
        temp+=dif[i];
        if(temp<0)
        {
            flag=0;
            break;
        }
    }
    last=mid;
    return flag;
}
signed main()
{
    int n,m;
    cin>>n>>m;
    vector<int>r(n+1);
    vector<int>dif(n+2);
    dif[0]=0;
    for(int i=1;i<=n;i++)
    {
        cin>>r[i];
    }
    for(int i=2;i<=n;i++)
    {
        dif[i]=r[i]-r[i-1];
    }
    dif[1]=r[1];
    dif[n+1]=0;
    int flag=0;
    vector<vector<int>>h(m+1);
    for(int i=1;i<=m;i++)
    {
        int d,s,t;
        cin>>d>>s>>t;
        h[i].push_back(d);
        h[i].push_back(s);
        h[i].push_back(t);
    }
    int le=1;
    int ri=m;
    int mid=0;
    int last=0;
    while(le<=ri)
    {
        mid=(le+ri)/2;
        if(check(mid,dif,h,n,last))
        {
            le=mid+1;
        }
        else
        {
           flag=mid;
           ri=mid-1;
        }
    }
    if(flag)
    {
        cout<<-1<<endl;
        cout<<flag<<endl;
    }
    else
    {
        cout<<0<<endl;
    }

}
```

