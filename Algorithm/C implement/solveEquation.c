//
// Created by Raul on 2021/11/29.
//

#include<stdio.h>
#include<stdlib.h>

#define PRECISE 100000

double calEquation(double x,
                   double* coefficients,
                   int length){
    double result = coefficients[0];
    for(int i = 1; i < length; ++i){
        int times = i;
        double temp = 1;
        while(times != 0){
            temp *= x;
            --times;
        }
        temp *= coefficients[i];
        result += temp;
    }
    return result;
}

double* solveEquation(double lowerBound,
                      double upperBound,
                      double* coefficients,
                      int length){
    double *result = (double*)malloc(sizeof(double) * (length - 1));
    for(int i = 0; i < length; ++i){
        result[i] = lowerBound - 1;
        // 清洗堆区数据，设为小于下界，代表不合法数据
    }
    int count = 0;
    double gap = (upperBound - lowerBound) / PRECISE;
    for(double i = lowerBound; i < upperBound; i += gap){
        double left = i;
        double right = left + gap;
        double f_left = calEquation(left, coefficients, length);
        if(!f_left){
            result[count++] = left;
        }else {
            double f_right = calEquation(right, coefficients, length);
            if(f_left * f_right < 0){
                while(right - left >= 0.000000001){
                    // double mid = ((right - left) >> 1 )+ right;
                    double mid = (right + left) / 2;
                    double f_mid = calEquation(mid, coefficients, length);
                    if(f_mid * f_left <= 0){
                        right = mid;
                    }else{
                        left = mid;
                    }
                }
                result[count++] = left;
            }
        } // end if(!f_left)
    } // end for

    return result;
}
void test_solve(double lowerBound,
                double upperBound,
                double* coefficients,
                int length){
    double *ret = (double* )malloc(sizeof(double) * length);
    ret = solveEquation(lowerBound, upperBound, coefficients, length);
    int count = 1;
    for(int i = 0; i < length; ++i){
        if(ret[i] == lowerBound - 1){
            break;
        }
        printf("The root %d is : %f\n", count, ret[i]);
        ++count;
    }
}

void test_cal(double x,
              double* coefficients,
              int length){
    printf("The result of test is : %f",
           calEquation(x, coefficients, length));
}

int main(int argc, char *argv[])
{
    // length = sizeof(arr) / sizeof(arr[0]);
    double test_1[] = {1, -2, 1};

    test_cal(-1, test_1, 3);
    printf("\n");
    test_solve(-100, 100, test_1, 3);

    printf("\n");
    double test_2[] = {20, -4.0, -5.0, 1.0};
    test_solve(-100, 100, test_2, 4);

    printf("\n");
    double test_3[] = {2, -5, 0, 1};
    test_solve(-100, 100, test_3, 4);

    return 0;
}

