---
title: 搜索
date: 2026-03-10 18:18:54
tags:
  - 算法知识点
  - dfs和bfs
categories: 
  - 算法知识点总结
mathjax: true
---



bfs和dfs真是一对苦命鸳鸯啊

<!-- more -->

# 🔎搜索

参考文章：[DFS（图论） - OI Wiki](https://oi-wiki.org/graph/dfs/)  [BFS（图论） - OI Wiki](https://oi-wiki.org/graph/bfs/)

鼠鼠一直都很想好好搞一下这个图论和搜索，今天也是终于有机会来大搞特搞一下了

## 一.DFS深度优先搜索 

### 引入

DFS 全称是 [Depth First Search](https://en.wikipedia.org/wiki/Depth-first_search)，中文名是深度优先搜索，是一种用于遍历或搜索树或图的算法．所谓深度优先，就是说每次都尝试向更深的节点走．

DFS 最显著的特征在于其 **递归调用自身**．同时与 BFS 类似，DFS 会对其访问过的点打上访问标记，在遍历图时跳过已打过标记的点，以确保 **每个点仅访问一次**．符合以上两条规则的函数，便是广义上的 DFS．

具体地说，DFS 大致结构如下：

```c++
DFS(v) // v 可以是图中的一个顶点，也可以是抽象的概念，如 dp 状态等．
  在 v 上打访问标记
  for u in v 的相邻节点
    if u 没有打过访问标记 then
      DFS(u)
    end
  end
end
```

以上代码只包含了 DFS 必需的主要结构．实际的 DFS 会在以上代码基础上加入一些代码，利用 DFS 性质进行其他操作．

### 性质

该算法通常的时间复杂度为 𝑂(𝑛 +𝑚)，空间复杂度为 𝑂(𝑛)，其中 𝑛 表示点数，𝑚 表示边数．注意空间复杂度包含了栈空间，栈空间的空间复杂度是 𝑂(𝑛) 的．在平均 𝑂(1)遍历一条边的条件下才能达到此时间复杂度，例如用前向星或邻接表存储图；如果用邻接矩阵则不一定能达到此复杂度．

**在实际比赛中理论上是可以递归无数次的**

### 实现

#### 栈实现

DFS 可以使用 [栈（Stack）](https://oi-wiki.org/ds/stack/) 为遍历中节点的暂存容器来实现；这与用 [队列（Queue）](https://oi-wiki.org/ds/queue/) 实现的 BFS 形成高度对应．

```c++
#include<bits/stdc++.h>
using namespace std;
#define int long long

vector<vector<int>>adj;   //邻接表
vector<bool>vis;          //记录节点是否已经遍历

void dfs(int s)
{
    stack<int>st;  //后进先出
    st.push(s);
    vis[s]=true;
    while(!st.empty())
    {
        int u=st.top();
        st.pop();
        for(auto it:adj[u])
        {
            if(!vis[it])
            {
                st.push(it);
                vis[it]=true;
            }
        }
    }
}
```

#### 递归实现

函数在递归调用时的求值如同对栈的添加和删除元素的顺序，故函数调用所占据的虚拟地址被称为函数调用栈（Call Stack），DFS 可用递归的方式实现．

以邻接表作为图的存储方式

```c++
vector<vector<int>>adj;   //邻接表
vector<bool>vis;          //记录节点是否已经遍历

void dfs(int u)
{
    vis[u]=true;
    for(auto it:adj[u])
    {
        if(!vis[it])
        {
            dfs(it);
        }
    }
}
```

### 例题

#### 一.八皇后

[P1219 [USACO1.5\] 八皇后 Checker Challenge - 洛谷](https://www.luogu.com.cn/problem/P1219)

回溯算法加递归，不过体现出了dfs的思想，鼠鼠想了好久，只能说你八皇后还是太权威了

```c++
//八皇后
#include<bits/stdc++.h>
using namespace std;
const int N=21;
int queen[N]={-1};
bool check(int row,int col,int n)
{
    for(int i=1;i<row;i++)
    {
        if(queen[i]==col||abs(queen[i]-col)==abs(i-row))   //判断是否列相同和在同一对角线上
        {
            return false;
        }
    }
    return true;
}

void backtrack(int row,int n,int &cnt)
{
    if(row==n+1)
    {
        cnt++;
        if(cnt<=3)
        {
            for(int i=1;i<=n;i++)
            {
                cout<<queen[i]<<" ";
            }
            cout<<endl;
        }
    }
    else
    {
        for(int i=1;i<=n;i++)
        {
            if(check(row,i,n))
            {
                queen[row]=i;
                backtrack(row+1,n,cnt);  //传递row+1而不是row++
            }        
        }
    }

}
int main()
{
    int n;
    cin>>n;
    int cnt=0;
    backtrack(1,n,cnt);
    cout<<cnt<<endl;
}
```



## 二.BFS宽度优先搜索

### 引入

是图上最基础、最重要的搜索算法之一．

所谓宽度优先．就是每次都尝试访问同一层的节点． 如果同一层都访问完了，再访问下一层．

这样做的结果是，BFS 算法找到的路径是从起点开始的 **最短** 合法路径．换言之，这条路径所包含的边数最小．

在 BFS 结束时，每个节点都是通过从起点到该点的最短路径访问的．

### 实现

这里先补充一下图的链式前向星存储方式 

参考文章：[链式前向星--最通俗易懂的讲解-CSDN博客](https://blog.csdn.net/sugarbliss/article/details/86495945)

**链式前向星其实就是静态建立的邻接表，时间效率为O（m），空间效率也为O（m）。遍历效率也为O（m）**

```c++
#include<bits/stdc++.h>
using namespace std;
struct Edge
{
    int to,w,next; //边的终点，权值和同一起点的上一条边
};

vector<Edge>edge;  // 边集
vector<int>head;   //  head[i] 表示以 i 为起点的最后一条边在边集中的下标

void add(int u,int v,int w)
{
    edge.push_back({v,w,head[u]}); // 新边的 next 指向当前 head[u]
    head[u]=edge.size()-1;         // 更新为以u为起点边的编号
}

// 广度优先遍历
void bfs(int start) {
    vector<bool> visited(head.size(), false);
    queue<int> q;
    visited[start] = true;
    q.push(start);

    while (!q.empty()) {
        int u = q.front();
        q.pop();
        cout << u << " ";
        for (int i = head[u]; i != -1; i = edge[i].next) {
            int v = edge[i].to;
            if (!visited[v]) {
                visited[v] = true;
                q.push(v);
            }
        }
    }
}

// 深度优先遍历（递归版）
void dfs(int u, vector<bool>& visited) {
    visited[u] = true;
    cout << u << " ";                      // 访问当前节点
    for (int i = head[u]; i != -1; i = edge[i].next) {
        int v = edge[i].to;
        if (!visited[v]) {
            dfs(v, visited);
        }
    }
}

int main()
{
    int n,m; //n个点m条边
    cin>>n>>m;

    head.assign(n+1,-1);
    edge.reserve(2*m);  //重置边和head 2*m预分配空间

    for(int i=1;i<=m;i++)
    {
        int u,v,w;
        cin>>u>>v>>w;
        add(u,v,w);
        // add(v,u,w)  如果是双向边
    }

    //遍历输出所有的边
    for(int i=1;i<=n;i++)
    {
        cout<<i<<endl;
        for(int j=head[i];j!=-1;j=edge[j].next)
        {
            cout << i << " " << edge[j].to << " " << edge[j].w << endl;
        }
    }

     // 演示 DFS 从节点 1 开始
    cout << "\nDFS 从节点 1 开始：";
    vector<bool> visited_dfs(n + 1, false);
    dfs(1, visited_dfs);
    cout << endl;

    // 演示 BFS 从节点 1 开始
    cout << "BFS 从节点 1 开始：";
    bfs(1);
    cout << endl;
}
```

链式前向星的dfs和bfs鼠鼠没学，以后再说......

正常的bfs，用邻接表存储队列实现

```c++
#include<bits/stdc++.h>
using namespace std;

int main() {
    int n, m;
    cin >> n >> m;
    
    // 邻接表
    vector<vector<int>> adj(n + 1);
    
    // 读入边（假设无权图）
    for (int i = 0; i < m; i++) {
        int u, v;
        cin >> u >> v;
        adj[u].push_back(v);
        adj[v].push_back(u);  // 无向图
    }
    
    // BFS
    int start = 1;
    vector<bool> visited(n + 1, false);
    queue<int> q;
    
    visited[start] = true;
    q.push(start);
    
    while (!q.empty()) {
        int u = q.front();
        q.pop();
        cout << u << " ";
        
        for (int v : adj[u]) {
            if (!visited[v]) {
                visited[v] = true;
                q.push(v);
            }
        }
    }
    
    return 0;
}
```

