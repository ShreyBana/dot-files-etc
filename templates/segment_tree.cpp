#include <bits/stdc++.h>
using namespace std;
type *st, *arr;
int size;

inline int get_lc(int n) 
{
    return 2 * n + 1;
}

inline int get_rc(int n) 
{
    return 2 * n + 2;
}

type build(int n, int l, int r)
{
    if (l == r) {
        st[n] = arr[l]; // create node if necessary
    } else {
        int m = (l + r) / 2;
        type lc = build(get_lc(n), l, m);
        type rc = build(get_rc(n), m + 1, r);
        st[n] = lc + rc; // merge here
    }

    return st[n];
}

void build()
{
    int log_n = 1;
    while ((1 << log_n) < size) log_n++;
    st = new type [(1 << (log_n + 1)) - 1];
    build(0, 0, size - 1);
}

void update(type value) {} // could be range or point so left as is
  
void query(int ) {} // could be range or point so left as is

int main(void) 
{
    ios_base::sync_with_stdio(false), cin.tie(0);
    int tc; cin >> tc;
    while (tc--) {
    }
}
