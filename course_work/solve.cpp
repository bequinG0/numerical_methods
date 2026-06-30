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
    // Решение: прямое численное решение краевой задачи
    double a = 0, b = 2;
    double h = 0.1;
    int N = (b - a) / h;

    function<double(double)> k = [](double x) -> double { return 4.0 - x; };
    function<double(double)> q = [](double x) -> double { return 2.0; };
    function<double(double)> f = [](double x) -> double { return (10.0 * (x*x - 5.0*x + 9.0)) / exp(x); };

    auto euler = [](double x, double y, double h, auto f) { return y + h * f(x, y); };

    auto DSK2 = [&](int i, double h, double left) -> array<double, 4> {
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

    auto left  = make_unique<DirichletCondition>(0, 2.0);
    auto right = make_unique<DirichletCondition>(N, 20.0 * exp(-2.0));

    BVP task(a, b, h, k, q, f, move(left), move(right), move(scheme));
    auto ans = task.solve();

    Plot::draw(ans.first, {ans.second}, "solve", {"u(x)"});

    // Тест с нулевой погрешностью
    /*auto u_exact = [](double x) { return x*x - x - 6.0; };

    function<double(double)> f_test = [](double x) {
        return -2.0*x*x + 6.0*x + 3.0;
    };

    for(int i=1; i<9; i++)
    {
        h=h/i; N = (b-a)/h;
        auto left_test  = make_unique<DirichletCondition>(0, -6.0);
        auto right_test = make_unique<DirichletCondition>(N, -4.0);

        auto DSK2_test = [&](int i, double h, double left) -> array<double, 4> {
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
        move(left_test), move(right_test), move(scheme_test));

        auto null_ans = null_task.solve();
        auto cond = null_task.conditionNumber();

        vector<double> delta;
        for(size_t i = 0; i < null_ans.first.size(); i++)
            delta.push_back(abs(null_ans.second[i] - u_exact(null_ans.first[i])));

        double m = *max_element(delta.begin(), delta.end());
        cout << "[*] max delta and cond: " << m << " " << cond << "\n";

    }*/

    // Тест с ненулевой погрешностью
    auto u_exact_notnull = [](double x) { return exp(x); };

    function<double(double)> f_test_notnull = [](double x) {
        return (x - 1.0) * exp(x);
    };

    for (int i = 1; i < 13; i++) {            
        int N_i = 20*pow(2,i);       
        double h_i = (b-a)/N_i;  

        auto left_notnull  = make_unique<DirichletCondition>(0, 1.0);
        auto right_notnull = make_unique<DirichletCondition>(N_i, exp(2.0));

        auto DSK2_notnull = [&](int idx, double h, double left) -> array<double, 4> {
            double xi = left + idx * h;
            double xL = xi - 0.5 * h, xR = xi + 0.5 * h;
            double h2 = h * h;
            return {
                -k(xL) / h2,
                (k(xL) + k(xR)) / h2 + q(xi),
                -k(xR) / h2,
                f_test_notnull(xi)
            };
        };

        DiffScheme scheme_notnull(h_i, euler, DSK2_notnull);

        BVP task_notnull(a, b, h_i, k, q, f_test_notnull,
            move(left_notnull), move(right_notnull), move(scheme_notnull));

        auto ans_notnull = task_notnull.solve();
        auto cond = task_notnull.conditionNumber();

        vector<double> delta;
        for (size_t j = 0; j < ans_notnull.first.size(); j++)
            delta.push_back(abs(ans_notnull.second[j] - u_exact_notnull(ans_notnull.first[j])));

        double m = *max_element(delta.begin(), delta.end());
        cout << "[*] max delta and cond: " << m << " " << cond << " " << N_i << "\n";
    }
}