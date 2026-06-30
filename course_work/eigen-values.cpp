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

    // Задача вариант D1
    double a = 0, b = 2;
    double h = 0.025; int N = (b - a) / h;
    cout << "\n[*] D1 eigenvalue problem, h = " << h << "\n";
    auto euler = [](double, double y, double h, auto) { return y; }; 
    function<double(double)> k_d1 = [](double x) -> double { return 4.0 - x; };
    function<double(double)> q_d1 = [](double x) -> double { return 2; };
    function<double(double)> f_zero = [](double x) -> double { return 0.0; };

    auto left_d1  = make_unique<DirichletCondition>(0, 0.0);
    auto right_d1 = make_unique<DirichletCondition>(N, 20*exp(-2));

    auto DSK2_d1 = [&](int i, double h, double left) -> array<double, 4> {
        double xi = left + i * h;
        double xL = xi - 0.5 * h, xR = xi + 0.5 * h;
        double h2 = h * h;
        return {
            -k_d1(xL) / h2,
            (k_d1(xL) + k_d1(xR)) / h2 - q_d1(xi),
            -k_d1(xR) / h2,
            f_zero(xi)
        };
    };

    DiffScheme scheme_d1(h, euler, DSK2_d1);

    BVP task_d1(a, b, h, k_d1, q_d1, f_zero,
        move(left_d1), move(right_d1), move(scheme_d1));

    auto [lambdas, vectors] = task_d1.eigenSolve();
    auto [lambda1, lambda2] = lambdas;
    auto [u1, u2] = vectors;

    cout << "lambda1 = " << lambda1 << "\n";
    cout << "lambda2 = " << lambda2 << "\n";

    // Нормировка u1
    double max_u1 = abs(u1[N/2]);
    for (auto& v : u1) v /= max_u1;
    if (u1[N/2] < 0) for (auto& v : u1) v = -v;

    // Нормировка u2
    double max_u2 = 0.0;
    for (int i = 0; i <= N; ++i)
        if (abs(u2[i]) > max_u2) max_u2 = abs(u2[i]);
    for (auto& v : u2) v /= max_u2;
    if (u2[N/4] < 0) for (auto& v : u2) v = -v;

    vector<double> x_d1(N+1);
    for (int i = 0; i <= N; ++i) x_d1[i] = a + i * h;

    // Вывод значений в точках
    vector<double> x_out = {0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0};
    cout << "x\tu1(x)\t\tu2(x)\n";
    for (double xi : x_out) {
        int idx = static_cast<int>(xi / h + 0.5);
        if (idx >= 0 && idx <= N)
            printf("%.1f\t%.6f\t%.6f\n", xi, u1[idx], u2[idx]);
    }

    Plot::draw(x_d1, {u1}, "D1 eigenfunction u1(x)", {"u1(x)"});
    Plot::draw(x_d1, {u2}, "D1 eigenfunction u2(x)", {"u2(x)"});

    return 0;
}