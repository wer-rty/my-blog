---
title: union
date: 2026-03-16 20:20:46
tags:
---



## 并查集（Union-Find）详解

并查集是一种**树型的数据结构**，用于处理**不相交集合的合并与查询**问题。它主要支持两种操作：

- **查找（Find）**：查询元素属于哪个集合
- **合并（Union）**：将两个集合合并成一个

### 核心思想

并查集通过一个数组来表示每个元素的"父节点"，形成树状结构。同一个集合的元素都有相同的根节点。

```c++
#include <iostream>
using namespace std;

const int MAXN = 1005;
int parent[MAXN];

// 初始化
void init(int n) {
    for (int i = 0; i <= n; i++) {
        parent[i] = i;
    }
}

// 查找（带路径压缩）
int find(int x) {
    if (parent[x] != x) {
        parent[x] = find(parent[x]);  // 路径压缩
    }
    return parent[x];
}

// 合并
void unite(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    if (rootX != rootY) {
        parent[rootX] = rootY;  // 简单合并
    }
}

// 判断是否同一个集合
bool same(int x, int y) {
    return find(x) == find(y);
}
```

