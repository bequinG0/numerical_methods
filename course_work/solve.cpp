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
using namespace Eigen;

int main()
{
    double a = 0, b = 2;
    double h = 0.01;
    int N = (b - a) / h;

    std::function<double(double)> k = [](double x) -> double { return 4.0 - x; };
    std::function<double(double)> q = [](double x) -> double { return 2.0; };
    std::function<double(double)> f = [](double x) -> double { return (10.0 * (x*x - 5.0*x + 9.0)) / exp(x); };

    auto euler = [](double x, double y, double h, auto f) { return y + h * f(x, y); };

    auto DSK2 = [&](int i, double h, double left) -> std::array<double, 4> {
        double xi = left + i * h;
        double xL = xi - 0.5 * h, xR = xi + 0.5 * h;
        double h2 = h * h;
        return {
            -k(xL) / h2,
            (k(xL) + k(xR)) / h2 - q(xi),
            -k(xR) / h2,
            f(xi)
        };
    };

    DiffScheme scheme(h, euler, DSK2);

    auto left  = std::make_unique<DirichletCondition>(0, 2.0);
    auto right = std::make_unique<DirichletCondition>(N, 20.0 * exp(-2.0));

    // Решение: прямое численное решение краевой задачи

    BVP task(a, b, h, k, q, f,
        std::move(left), std::move(right), std::move(scheme));

    auto ans = task.solve();

    vector<double> lambda = task.eigenvalues();

    Plot::draw(ans.first, {ans.second}, "solve", {"u(x)"});

    // Тесты с нулевой и ненулевой погрешностью

    auto u_exact = [](double x) { return x*x - x - 6.0; };

    std::function<double(double)> f_test = [](double x) {
        return -2.0*x*x + 6.0*x + 3.0;
    };

    auto left_test  = std::make_unique<DirichletCondition>(0, -6.0);
    auto right_test = std::make_unique<DirichletCondition>(N, -4.0);

    auto DSK2_test = [&](int i, double h, double left) -> std::array<double, 4> {
        double xi = left + i * h;
        double xL = xi - 0.5 * h, xR = xi + 0.5 * h;
        double h2 = h * h;
        return {
            -k(xL) / h2,
            (k(xL) + k(xR)) / h2 - q(xi),
            -k(xR) / h2,
            f_test(xi)
        };
    };

    DiffScheme scheme_test(h, euler, DSK2_test);

    BVP null_task(a, b, h, k, q, f_test,
    std::move(left_test), std::move(right_test), std::move(scheme_test));

    pair <vector <double>, vector <double>> null_ans = null_task.solve();
    
    vector <double> delta;
    for(int i=0; i<null_ans.first.size(); i++)
    {
        delta.push_back(abs(null_ans.second[i] - u_exact(null_ans.first[i])));
    }
    double m = *max_element(delta.begin(), delta.end());
    cout << "[*] max delta: " << m << "\n"; 

    //Тесты с ненулевой погрешностью



    return 0;
}