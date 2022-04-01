# -*- coding: utf-8 -*-
# @Time    : 2021/11/17 7:25 下午
# @Author  : Jiaming Zhang
# @FileName: 3_plotVec.py
# @Github  ：https://github.com/CharmingZh
import math

import numpy as np
import matplotlib.pyplot as plt

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
    # 创建空白矩阵，写入向量数据
    X, Y = np.mgrid[0:128, 0:128]
    U = np.zeros(shape=(int(row), int(col)))
    V = np.zeros(shape=(int(row), int(col)))

    count_row = 0
    count_line = 0
    for line in tempData:
        if count_line == int(col):
            count_line = 0
            count_row += 1
        line = line.split(" ")
        U[count_row][count_line] = line[0]
        V[count_row][count_line] = line[1]
        count_line += 1

    tempData.close()

    C = U * V
    plt.quiver(X, Y, U, V, C)
    plt.savefig('3_plotVec_non2Norm.png', dpi=300)
    for i in range(len(C)):
        for j in range(len(C[i])):
            if C[i][j] < 0:
                C[i][j] *= -1

    #plt.quiver(X, Y, U, V, C, scale_units="xy", scale=1)
    #plt.savefig('3_plotVec_2Nrom.png', dpi=300)

    #plt.quiver(X, Y, U, V, scale_units="xy", scale=20)
    plt.show()
    print('finish')
