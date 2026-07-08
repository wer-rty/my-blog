---
title: sort
date: 2026-03-12 23:11:24
tags:
---







主要讲一下几种排序

1.priority_queue

```c++
// pq排序
struct node
{
    int x,w;
    friend bool operator<(node x,node y)
    {
        return x.w<y.w;
    }
};
priority_queue<node>pq;

```

2.vector

```c++
struct node
{
    int x,w;
    friend bool operator<(node x,node y)
    {
        return x.w<y.w;
    }
};
vector<node>a(10);
sort(a.begin(),a.end());
```

3.sort

```c++
struct node
{
    int x,w;
};
vector<node>a(10);
bool cmp(node x,node y){return x.w<y.w;}
sort(a.begin(),a.end(),cmp);
```

```c++
struct node
{
    int x,w;
};
vector<node>a(10);
sort(a.begin(),a.end(),[&](node x,node y){return x.w<y.w;});
```

## 四种输出格式对比

| 格式             | 代码                       | 数值      | 输出     |
| :--------------- | :------------------------- | :-------- | :------- |
| 保留两位小数     | `fixed << setprecision(2)` | 1.2345    | 1.23     |
| 保留四位小数     | `fixed << setprecision(4)` | 1.2345    | 1.2345   |
| 保留四位有效数字 | `setprecision(4)`          | 1.2345    | 1.235    |
| 保留四位有效数字 | `setprecision(4)`          | 123.45    | 123.5    |
| 保留四位有效数字 | `setprecision(4)`          | 0.0012345 | 0.001235 |

保留四位就不加fixed
