#include <bits/stdc++.h>
using namespace std;

inline long mul_mod (long a, long b) {
    return ((a%MOD) * (b%MOD))%MOD;
}

inline long power(long x, long n) {
    long pow = 1;

    while (n) {
        if (n & 1)
            pow = (pow*x)%MOD;
        n = n >> 1;
        x = (x * x)%MOD;
    }

    return pow;
}

int main(void) {
	#ifndef TOKEN_NAME
		freopen("PATH_TO_FILE","w",stdout);
	#endif
    std::ios::sync_with_stdio(false);
    cin.tie(NULL); cout.tie(NULL);
    int T; cin>>T;
    while(T--) {
    }	
}
