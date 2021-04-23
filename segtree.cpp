#include <bits/stdc++.h>
using namespace std;

class segtree 
{
private:
  struct node {};
  node* tree;
  int size, *arr;

  node merge (const node& lc, const node& rc) 
  {
  }

  void build (int v, int tl, int tr) 
  {
    if (tl == tr) {
      tree[v] = node (arr[tl]);
    } else {
      int tm = (tl + tr) / 2;
      int lc = 2 * v + 1, rc = 2 * v + 2;
      build(lc, tl, tm); build(rc, tm + 1, tr);
      tree[v] = merge(tree[lc], tree[rc]);
    }
  }

  void set (int v, int tl, int tr, ) {}

  type query (int v, int tl , int tr, ) {}
public:
  segtree (int *arr, int size):arr(arr), size(size) 
  {
    int log_n = 1;
    while ((1 << log_n) < size) log_n++;
    tree = new node [(1 << (log_n + 1)) - 1];
    build(0, 0, size - 1);
  }

  void set (int ) {}

  type query (int ) {}
};
  

int main (void) 
{
  ios_base::sync_with_stdio(false), cin.tie(0);
  int tc; cin >> tc;
  while (tc--) {
  }
}
