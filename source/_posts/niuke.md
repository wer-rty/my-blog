---
title: 牛客竞赛
date: 2026-03-02 22:12:47
tags:
  - 随笔
  - 算法竞赛
  - 牛客
categories:
  - 生活记录
mathjax: true
cover: /images/niuke.jpg
---

终于，我开始了自己的博客之旅！这是我的第一篇文章，想在这里记录下此刻的心情和对未来的期待

<!-- more -->

## 🌟 牛客竞赛

这个寒假我参加了牛客网的几场算法竞赛，收获颇丰。

### 🐔第一场比赛

牛客的第一场比赛比较简单，一共做了5道题，这里主要补一下A题和G题

#### 🎈A题 ：A+B problem

[A-A+B Problem_2026牛客寒假算法基础集训营1](https://ac.nowcoder.com/acm/contest/120561/A)

这是一道概率计算题，说实话鼠鼠我从来没有做过这种类型的题目，而且数据处理比较麻烦（鼠鼠有大数恐惧症）所以当时鼠鼠就直接原地投降了😭

首先这个题目我们需要知道分数取模的方法即
$$
\frac{p}{q} mod M=p\times q^-1 mod M
$$
(这里-1是指q的逆)

根据费马小定理，在模数 m 为质数，且 b 不是 m 的倍数的情况下有
$$
\frac{a}{b}mod m=a \times b^{m-2}mod m
$$

##### 正式解题

我们可以知道每一个显示器都是相互独立的，所以我们可以计算出一个显示器可以显示出数字0-9的概率依次是多少，对于两排显示器要使其A+B=C的话，我们可以转换成B=A-C;这样我们就可以通过遍历A的所有可能情况同时确定B所对应的值，从而求出所有可能的概率之和

那么如何求出一个显示器可以显示出数字1-9的概率呢，这里我们采用**状态压缩**的方法：把每个数位在显示器中要被点亮的部分当成二进制1，不需要点亮的当成0，例如数字0的二进制表示就是1110111

我们提前准备一张表把0-9的二进制状态存储起来

```c++
const int N=10;
int s[N];
void init()
{
    s[0]=(1<<0)|(1<<1)|(1<<2)|(1<<4)|(1<<5)|(1<<6);
    s[1]=(1<<2)|(1<<5);
    s[2]=(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<6);
    s[3]=(1<<0)|(1<<2)|(1<<3)|(1<<5)|(1<<6);
    s[4]=(1<<1)|(1<<2)|(1<<3)|(1<<5);
    s[5]=(1<<0)|(1<<1)|(1<<3)|(1<<5)|(1<<6);
    s[6]=(1<<0)|(1<<1)|(1<<3)|(1<<4)|(1<<5)|(1<<6);
    s[7]=(1<<0)|(1<<2)|(1<<5);
    s[8]=(1<<0)|(1<<1)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6);
    s[9]=(1<<0)|(1<<1)|(1<<2)|(1<<3)|(1<<5)|(1<<6);
}   //这里和后面的表示方法不太一样，当然后面的代码更简单一点，但我觉得这样的表示形式也要记住
```

下面是完整版代码（这里用的是字符串表示形式）

```c++
#include<bits/stdc++.h>
using namespace std;
#define int long long
const int mod= 998244353;
int ksm(int x, int y) 
{
    int res = 1;
    while(y)
    {
        if(y & 1) res = res * x % mod;
        x = x * x % mod;
        y >>= 1;
    }
    return res;
}
signed main()
{
    //看了多个题解突然发现字符串数组表示更方便
    string s[10] = {
        "1110111", "0010010", "1011101", "1011011", "0111010",
        "1101011", "1101111", "1010010", "1111111", "1111011"
    };                                           
    int inv100=ksm(100,mod-2);
    int t;
    cin>>t;
    while(t--)
    {
        int c;
        cin>>c;
        vector<int>p(7);
        for(int i=0;i<7;i++)
        {
            cin>>p[i];
            p[i]=p[i]*inv100%mod;
        }
        vector<int>h(10,1);
        for(int i=0;i<10;i++)
        {
            for(int j=0;j<7;j++)
            {
                if(s[i][j]=='1')
                {
                    h[i]=h[i]*p[j]%mod;
                }
                else
                {
                    h[i]=h[i]*((1+mod-p[j])%mod)%mod;//1+mod-p[j]可以保证为正数
                }
            }
        }
        int ans=0;
        for(int a=0;a<=c;a++)
        {
            int b=c-a;
            if(a>9999||b>9999)
            {
                continue;
            }
            string sa=to_string(a);
            string sb=to_string(b);
            string num=string(4-sa.length(),'0')+sa+string(4-sb.length(),'0')+sb;
            int cnt=1;
            for(auto it:num)
            {
                cnt=cnt*h[it-'0']%mod;
            }
            ans=(ans+cnt)%mod;
        }
        cout<<ans<<endl;
    }
}
```

感觉这道题目还是挺难的，并且其中**ksm**的知识点鼠鼠还没有掌握，主要是用字符串的形式来解决本题，当然还有许多更简便的方法，总之这道题的难度鼠鼠可以给到一个**顶级**



#### 💡G题：Digital Folding

[G-Digital Folding_2026牛客寒假算法基础集训营1](https://ac.nowcoder.com/acm/contest/120561/G)

第一眼看上去题目真的很短，是一道思维题，鼠鼠最后一小时在摸鱼，遂没有写出来

##### 🗝️新知识：

 stoll(t)  **stoll** = **string to long long**  将字符串 `t` 转换为 `long long` 类型的整数

##### 解题思路：

有三种情况：第一种即r是10^n，那么我们可以直接输出r-1即99...9；第二种是r=l，那么我们只能输出reverse（r）,第三种则是最复杂的情况，我们需要先找到一个与r位数相同且大于等于l的数作为起点，t=max(l,10...0);因为直接对大数处理会比较麻烦，所以我们可以将其转换为字符串的形式进行操作，t先reverse一下转换成ans，然后从高位开始挨个遍历，看其是否可以变为9，如果可以则更换，不行则保持原样😭很可惜上述第三种方法是错误的，因为虽然该位的最大值到不了9，但说不定是8等等稍微小一点的数，所以我们要依次遍历一遍，✅ **时间复杂度是 O(L^2）**，其中 L≤16

##### 下面是代码部分：

```c++
#include<bits/stdc++.h>
using namespace std;
#define int long long
signed main()
{
    int t;
    cin>>t;
    while(t--)
    {
        int l,r;
        cin>>l>>r;
        if(l==r)  //l==r的情况
        {
            string temp=to_string(r);
            reverse(temp.begin(),temp.end());
            cout<<stoll(temp)<<endl;
            continue;
        }
        string rs=to_string(r);
        if(rs[0]=='1'&&count(rs.begin(),rs.end(),'0')==rs.size()-1)   //r是10的幂次
        {
            cout<<stoll(rs)-1<<endl;
            continue;
        }
        int ans=stoll("1"+string(rs.size()-1,'0'));
        ans=max(ans,l);     //取二者中更大的那一个
        //从倒过来的最高位开始遍历
        string s=to_string(ans);
        for(int i=s.size()-1;i>=0;i--)
        {
            for(int j=9;j>=0;j--)     //这里不能直接考虑9，又可能会存在小于9的情况
            {
                if(s[i]!=j-'0')
                {
                   int index = 1;
                   for(int k = 0; k < s.size()-1-i; k++) index *= 10;
                   int le=ans+(j-(s[i]-'0'))*index;
                   if(le<=r)
                   {
                      s[i]=j-'0';
                      ans=le;   //ans要更新一下
                      break;
                   }
                }
            }
        }
        string result = to_string(ans);
        reverse(result.begin(), result.end());
        cout << stoll(result) << endl;
    }
}
```

##### 总结

这道题的思维和难度还是稍微有点大的，需要分三种情况讨论，要将大数转换成字符串方便处理，综上可以给一个**人上人**
