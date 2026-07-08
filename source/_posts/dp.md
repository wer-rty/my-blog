---
title: 动态规划
date: 2026-03-03 23:04:38
tags:
  - 算法竞赛
  - dp
categories:
  - 生活记录
mathjax: true
cover: /images/dp.jpg
---

该文章主要是讲述动态规划的一系列模板题和学习方法

<!-- more -->

## 最长上升子序列

[B3637 最长上升子序列 - 洛谷](https://www.luogu.com.cn/problem/B3637)

参考文档：[动态规划之线性DP - 最长上升子序列(LIS) - 知乎](https://zhuanlan.zhihu.com/p/26337896267)

1.时间复杂度O(n^2)

```c++
#include <bits/stdc++.h>
using namespace std;

int a[5010], dp[5010];

int main(){
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++) cin >> a[i];
    
    for (int i = 1; i <= n; i++) dp[i] = 1; //初始化状态变量
    
    int ans = 1;
    for (int i = 2; i <= n; i++) {
        for (int j = 1; j < i; j++) {
            if (a[i] > a[j]) {
                dp[i] = max(dp[i], dp[j] + 1); //状态转移
            }
        }
        ans = max(ans, dp[i]);
    }
    cout << ans << endl;
    return 0;
}
```

2.二分查找与贪心优化

```c++
#include<bits/stdc++.h>
using namespace std;
int main()
{
    int n;
    cin>>n;
    vector<int>v(n);
    for(int i=0;i<n;i++)
    {
        cin>>v[i];
    }
    vector<int>p;
    for(int x:v)
    {
        auto it=lower_bound(p.begin(),p.end(),x);
        if(it==p.end())
        {
            p.push_back(x);
        }
        else
        {
            *it=x;
        }
    }
    cout<<p.size()<<endl;
}
```



## 🌟背包问题

参考文档:[背包 DP - OI Wiki](https://oi-wiki.org/dp/knapsack/)

### 1.01背包

题意概要：有 𝑛![n](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个物品和一个容量为 𝑊![W](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 的背包，每个物品有重量 𝑤𝑖![w_{i}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 和价值 𝑣𝑖![v_{i}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 两种属性，要求选若干物品放入背包使背包中物品的总价值最大且背包中物品的总重量不超过背包的容量

在上述例题中，由于每个物体只有两种可能的状态（取与不取），对应二进制中的 0![0](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 和 1![1](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)，这类问题便被称为「0-1 背包问题」．

#### 解释

例题中已知条件有第 𝑖![i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个物品的重量 𝑤𝑖![w_{i}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)，价值 𝑣𝑖![v_{i}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)，以及背包的总容量 𝑊![W](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)．

设 DP 状态 𝑓𝑖,𝑗![f_{i,j}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 为在只能放前 𝑖![i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个物品的情况下，容量为 𝑗![j](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 的背包所能达到的最大总价值．

考虑转移．假设当前已经处理好了前 𝑖 −1![i-1](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个物品的所有状态，那么对于第 𝑖![i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个物品，当其不放入背包时，背包的剩余容量不变，背包中物品的总价值也不变，故这种情况的最大价值为 𝑓𝑖−1,𝑗![f_{i-1,j}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)；当其放入背包时，背包的剩余容量会减小 𝑤𝑖![w_{i}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)，背包中物品的总价值会增大 𝑣𝑖![v_{i}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)，故这种情况的最大价值为 𝑓𝑖−1,𝑗−𝑤𝑖 +𝑣𝑖![f_{i-1,j-w_{i}}+v_{i}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)．

由此可以得出状态转移方程：

   ![image-20260430160545406](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20260430160545406.png)

这里如果直接采用二维数组对状态进行记录，会出现 MLE．可以考虑改用滚动数组的形式来优化．

由于对 𝑓𝑖![f_i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 有影响的只有 𝑓𝑖−1![f_{i-1}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)，可以去掉第一维，直接用 𝑓𝑖![f_{i}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 来表示处理到当前物品时背包容量为 𝑖![i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 的最大价值，得出以下方程：

![image-20260430160710648](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20260430160710648.png)

**务必牢记并理解这个转移方程，因为大部分背包问题的转移方程都是在此基础上推导出来的．**

#### 实现

- **含义**：`f[l]` 表示在背包容量为 `l` 时，能获得的**最大总价值**
- **作用**：记录每个容量状态下的最优解

```C++
#include<bits/stdc++.h>
using namespace std;
int main()
{
    int n,W;
    cin>>n>>W;
    vector<int>v(n);
    vector<int>w(n);
    vector<int>f(W+1,0);
    for(int i=0;i<n;i++)
    {
        cin>>v[i]>>w[i];
    }
    for(int i=0;i<n;i++)
    {
        for(int j=W;j>=w[i];j--)
        {
            f[j]=max(f[j-w[i]]+v[i],f[j]);
        }
    }
    cout<<f[W]<<endl;

}
```



### 2.完全背包

#### 解释

完全背包模型与 0-1 背包类似，与 0-1 背包的区别仅在于一个物品可以选取无限次，而非仅能选取一次．

我们可以借鉴 0-1 背包的思路，进行状态定义：设 𝑓𝑖,𝑗![f_{i,j}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 为只能选前 𝑖![i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个物品时，容量为 𝑗![j](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 的背包可以达到的最大价值．

需要注意的是，虽然定义与 0-1 背包类似，但是其状态转移方程与 0-1 背包并不相同．

```C++
#include<bits/stdc++.h>
using namespace std;
int main()
{
    int n,W;
    cin>>n>>W;
    vector<int>v(n);
    vector<int>w(n);
    vector<int>f(W+1,0);
    for(int i=0;i<n;i++)
    {
        cin>>v[i]>>w[i];
    }
    for(int i=0;i<n;i++)
    {
        for(int j=w[i];j<=W;j++)
        {
            f[j]=max(f[j-w[i]]+v[i],f[j]);
        }
    }
    cout<<f[W]<<endl;

}
```



### 3.多重背包

多重背包也是 0-1 背包的一个变式．与 0-1 背包的区别在于每种物品有 𝑘𝑖![k_i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个，而非一个．

#### 二进制分组优化

考虑优化．我们仍考虑把多重背包转化成 0-1 背包模型来求解．

#### 解释

显然，复杂度中的 𝑂(𝑛𝑊)![O(nW)](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 部分无法再优化了，我们只能从 𝑂(∑𝑘𝑖)![O(\sum k_i)](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 处入手．为了表述方便，我们用 𝐴𝑖,𝑗![A_{i,j}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 代表第 𝑖![i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 种物品拆分出的第 𝑗![j](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个物品．

在朴素的做法中，∀𝑗 ≤𝑘𝑖![\forall j\le k_i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)，𝐴𝑖,𝑗![A_{i,j}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 均表示相同物品．那么我们效率低的原因主要在于我们进行了大量重复性的工作．举例来说，我们考虑了「同时选 𝐴𝑖,1,𝐴𝑖,2![A_{i,1},A_{i,2}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)」与「同时选 𝐴𝑖,2,𝐴𝑖,3![A_{i,2},A_{i,3}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)」这两个完全等效的情况．这样的重复性工作我们进行了许多次．那么优化拆分方式就成为了解决问题的突破口．

**把原先的k个物品数用二进制来表示，然后再当作01背包给出计算结果**

```C++
#include<bits/stdc++.h>
using namespace std;
struct node {
    int w, v;  // w:重量, v:价值
};
int main() {
    int n, W;
    cin >> n >> W;  // n:物品种类数, W:背包容量
    vector<node> list;  // 存储拆分后的物品
    // 读入每种物品，进行二进制拆分
    for(int i = 0; i < n; i++) {
        int p, h, k;  // p:重量, h:价值, k:数量
        cin >> p >> h >> k;
        int c = 1;  // 当前拆分包的大小(1,2,4,8...)
        while(k > c) {  // 剩余数量还够拆一个完整的c
            k -= c;  // 从剩余中减去c
            list.push_back({c * p, c * h});  // 打包c个物品
            c *= 2;  // 下一个包翻倍
        }
        list.push_back({k * p, k * h});  // 剩余的全部打包
    }
    // 0-1背包DP
    vector<int> f(W + 1, 0);  // f[j]:容量j时的最大价值
    for(int i = 0; i < list.size(); i++) {  // 遍历每个打包物品
        for(int j = W; j >= list[i].w; j--) {  // 倒序遍历容量
            f[j] = max(f[j], f[j - list[i].w] + list[i].v);  // 状态转移
        }
    }
    cout << f[W] << endl;  // 输出最大价值
    return 0;
}
```



### 4.单调队列和单调栈优化

首先得学习一下单调队列和单调栈

#### 单调队列

本题大意是给出一个长度为 𝑛![n](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 的数组，编程输出每 𝑘![k](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个连续的数中的最大值和最小值．

#### 定义

顾名思义，单调队列的重点分为「单调」和「队列」．

「单调」指的是元素的「规律」——递增（或递减）．

「队列」指的是元素只能从队头和队尾进行操作．

要求的是每连续的 𝑘![k](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个数中的最大（最小）值，很明显，当一个数进入所要 "寻找" 最大值的范围中时，若这个数比其前面（先进队）的数要大，显然，前面的数会比这个数先出队且不再可能是最大值．

也就是说——当满足以上条件时，可将前面的数 "弹出"，再将该数真正 push 进队尾．

这就相当于维护了一个递减的队列，符合单调队列的定义，减少了重复的比较次数，不仅如此，由于维护出的队伍是查询范围内的且是递减的，队头必定是该查询区域内的最大值，因此输出时只需输出队头即可．

显而易见的是，在这样的算法中，每个数只要进队与出队各一次，因此时间复杂度被降到了 𝑂(𝑛)![O(n)](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)．

而由于查询区间长度是固定的，超出查询空间的值再大也不能输出，因此还需要 site 数组记录第 𝑖![i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个队中的数在原数组中的位置，以弹出越界的队头

```c++
#include<bits/stdc++.h>
using namespace std;

int main() {
    int n, k;
    cin >> n >> k;
    vector<int> a(n);
    for(int i = 0; i < n; i++) cin >> a[i];
    
    deque<int> q;  // 单调队列（存下标）
    
    // 滑动窗口最大值
    for(int i = 0; i < n; i++) {
        // 移除超出窗口的元素
        while(!q.empty() && q.front() < i - k + 1) q.pop_front();
        // 维护单调递减：队头最大
        while(!q.empty() && a[q.back()] <= a[i]) q.pop_back();
        q.push_back(i);
        // 窗口形成后输出答案
        if(i >= k - 1) cout << a[q.front()] << " ";
    }
    
    return 0;
}
while(!q.empty() && a[q.back()] >= a[i]) q.pop_back();  // 单调递增：队头最小
```

#### 单调栈

非常的简单，因为只有一个口

将一个元素插入单调栈时，为了维护栈的单调性，需要在保证将该元素插入到栈顶后整个栈满足单调性的前提下弹出最少的元素．

```C++
insert x
while !sta.empty() && sta.top()<x
    sta.pop()
sta.push(x)
```



### 5.混合背包

混合背包就是将前面三种的背包问题混合起来，有的只能取一次，有的能取无限次，有的只能取 𝑘![k](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 次．

这种题目看起来很吓人，可是只要领悟了前面几种背包的中心思想，并将其合并在一起就可以了．下面给出伪代码：

```c++
for (循环物品种类) {
  if (是 0 - 1 背包)
    套用 0 - 1 背包代码;
  else if (是完全背包)
    套用完全背包代码;
  else if (是多重背包)
    套用多重背包代码;
}
```

```c++
for (int i = 1; i <= n; i++) {
  if (cnt[i] == 0) {  // 如果数量没有限制使用完全背包的核心代码
    for (int weight = w[i]; weight <= W; weight++) {
      dp[weight] = max(dp[weight], dp[weight - w[i]] + v[i]);
    }
  } else {  // 物品有限使用多重背包的核心代码，它也可以处理0-1背包问题
    for (int weight = W; weight >= w[i]; weight--) {
      for (int k = 1; k * w[i] <= weight && k <= cnt[i]; k++) {
        dp[weight] = max(dp[weight], dp[weight - k * w[i]] + k * v[i]);
      }
    }
  }
}
```



### 6.二维费用背包

有 𝑛![n](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个任务需要完成，完成第 𝑖![i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个任务需要花费 𝑡𝑖![t_i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 分钟，产生 𝑐𝑖![c_i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 元的开支．

现在有 𝑇![T](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 分钟时间，𝑊![W](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 元钱来处理这些任务，求最多能完成多少任务．

这道题是很明显的 0-1 背包问题，可是不同的是选一个物品会消耗两种价值（经费、时间），只需在状态中增加一维存放第二种价值即可．

**这时候就要注意，再开一维存放物品编号就不合适了，因为容易 MLE．**

```c++
for (int k = 1; k <= n; k++)
  for (int i = m; i >= mi; i--)    // 对经费进行一层枚举
    for (int j = t; j >= ti; j--)  // 对时间进行一层枚举
      dp[i][j] = max(dp[i][j], dp[i - mi][j - ti] + 1);
```



### 7.分组背包

这种题怎么想呢？其实是从「在所有物品中选择一件」变成了「从当前组中选择一件」，于是就对每一组进行一次 0-1 背包就可以了．

再说一说如何进行存储．我们可以将 𝑡𝑘,𝑖![t_{k,i}](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 表示第 𝑘![k](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 组的第 𝑖![i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 件物品的编号是多少，再用 cnt𝑘![\mathit{cnt}_k](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 表示第 𝑘![k](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 组物品有多少个．

```c++
for (int k = 1; k <= ts; k++)          // 循环每一组
  for (int i = m; i >= 0; i--)         // 循环背包容量
    for (int j = 1; j <= cnt[k]; j++)  // 循环该组的每一个物品
      if (i >= w[t[k][j]])             // 背包容量充足
        dp[i] = max(dp[i],
                    dp[i - w[t[k][j]]] + c[t[k][j]]);  // 像0-1背包一样状态转移
```



### 8.有依赖的背包

金明有 𝑛![n](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 元钱，想要买 𝑚![m](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 个物品，第 𝑖![i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 件物品的价格为 𝑣𝑖![v_i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)，重要度为 𝑝𝑖![p_i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)．有些物品是从属于某个主件物品的附件，要买这个物品，必须购买它的主件．

目标是让所有购买的物品的 𝑣𝑖 ×𝑝𝑖![v_i \times p_i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 之和最大．

考虑分类讨论．对于一个主件和它的若干附件，有以下几种可能：只买主件，买主件 + 某些附件．因为这几种可能性只能选一种，所以可以将这看成分组背包．

如果是多叉树的集合，则要先算子节点的集合，最后算父节点的集合．



### 9.反物品化背包

这种背包，没有固定的费用和价值，它的价值是随着分配给它的费用而定．在背包容量为 𝑉![V](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 的背包问题中，当分配给它的费用为 𝑣𝑖![v_i](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7) 时，能得到的价值就是 ℎ(𝑣𝑖)![h\left(v_i\right)](data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)．这时，将固定的价值换成函数的引用即可．
