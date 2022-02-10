#include <bits/stdc++.h>
using namespace std;
vector<int> ft;

int get(int i) 
{
    int res = 0;
    while (i >= 0) {
        res += ft[i];
        i = (i & (i + 1)) - 1;
    }

    return res;
}

inline int get(int l, int r) 
{
    return get(r) - get(l - 1);
}

inline void update(int i, int d) // d here is change i.e. delta
{
    for (int j = i;j < ft.size();j = j | (j + 1)) {
        ft[j] += d;
    }
}

void solve()
{
}

int main(void) 
{
    ios_base::sync_with_stdio(false), cin.tie(0);
    int tc; cin >> tc;
    while (tc--)
        solve();
}
