#include <iostream>
#include <cmath>
#include <memory>
#include <functional>
#include <array>

#include "diffcore-cpp/include/conditions.h"
#include "diffcore-cpp/include/bvp.h"
#include "diffcore-cpp/include/plot.h"
#include "diffcore-cpp/include/diffscheme.h"

using namespace std;

int main()
{
    double a = 0, b = 2;
    double h = 0.01;
    int N = (b - a) / h;

    function<double(double)> k = [](double) { return 1.0; };
    function<double(double)> q = [](double) { return 0.0; };
    function<double(double)> f = [](double) { return 0.0; };

    auto euler = [](double, double y, double h, auto) { return y; }; // не используется, но нужен

    auto DSK2 = [&](int i, double h, double left) -> array<double, 4> {
        double xi = left + i * h;
        double xL = xi - 0.5 * h, xR = xi + 0.5 * h;
        double h2 = h * h;
        return { -1.0/h2, 2.0/h2, -1.0/h2, 0.0 };
    };

    DiffScheme scheme(h, euler, DSK2);
    auto left  = make_unique<DirichletCondition>(0, 0.0);
    auto right = make_unique<DirichletCondition>(N, 0.0);

    BVP task(a, b, h, k, q, f, move(left), move(right), move(scheme));
    auto [lambdas, vectors] = task.eigenSolve();
    auto [lam1, lam2] = lambdas;
    auto [u1, u2] = vectors;

    double L = b - a;
    double exact1 = M_PI * M_PI / (L * L);
    double exact2 = 4.0 * M_PI * M_PI / (L * L);

    cout << "lambda1 = " << lam1 << " (exact: " << exact1 << ")\n";
    cout << "lambda2 = " << lam2 << " (exact: " << exact2 << ")\n";

    //Нормировка
    double max1 = abs(u1[N/2]), max2 = abs(u2[N/4]);
    for (auto& v : u1) v /= max1;
    for (auto& v : u2) v /= max2;

    vector<double> x(N+1), u1_ex(N+1), u2_ex(N+1);
    for (int i = 0; i <= N; ++i) {
        x[i] = a + i * h;
        u1_ex[i] = sin(M_PI * x[i] / L);
        u2_ex[i] = sin(2.0 * M_PI * x[i] / L);
    }

    Plot::draw(x, {u1}, "u1(x)", {"numeric", "exact"});
    Plot::draw(x, {u2}, "u2(x)", {"numeric", "exact"});

    return 0;
}