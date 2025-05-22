#include <iostream>
#include <cmath>
#include <vector>
#include <algorithm>
#include <cstdlib>
using namespace std;

float power(float x, float y)
{
    if(y == 0) return 1;
    float res = x;
    for(int i=0; i<y-1; i++) res*=x;
    return res;
}

int factor(int x)
{
    int res = 1;
    for(int i=0; i<x; i++) res*=x--;
    return res;
}

float sum_e(float x, int N)
{
    float res = 0;
    for(int i=0; i<=N; i++) res += power(x, i) / factor(i);
    return res;
}

int main()
{
    float N, x; cin >> x >> N;
    cout << sum_e(x, N) << " " << exp(x) << "\n";
}