# -*- coding: utf-8 -*-
# @Time    : 2021/11/17 5:51 下午
# @Author  : Jiaming Zhang
# @FileName: 1_calDist.py
# @Github  ：https://github.com/CharmingZh

import numpy as np
import matplotlib.pyplot as plt
import math


def calDist(x, y):
    return math.sqrt(x ** 2 + y ** 2)


if __name__ == '__main__':
    data = open('jet.vecT', 'r')
    temp = open('tempData', 'w+')
    row = 0
    col = 0

    # 读入向量数据，并且保存尺寸
    count = 0
    for line in data:
        if count == 0:
            line = line.split(" ")
            row = line[0]
            col = line[1]
            count += 1
        else:
            temp.write(line)
    data.close()
    temp.close()

    tempData = open('tempData', 'r+')
    result = open('jetMag.txt', 'w')
    # 创建空白矩阵，写入模的大小
    Mat = np.zeros(shape=(int(row), int(col)))

    count_row = 0
    count_line = 0
    for line in tempData:
        if count_line == int(col):
            count_line = 0
            count_row += 1
            result.write('\n')
        line = line.split(" ")
        Mat[count_row][count_line] = calDist(
            float(line[0]),
            float(line[1])
        )
        result.write(str(Mat[count_row][count_line]) + ' ')
        count_line += 1
    np.savetxt('1_tempMat', Mat)
    tempData.close()
    result.close()

    print('max is ', np.max(Mat))
    print('min is ', np.min(Mat))

