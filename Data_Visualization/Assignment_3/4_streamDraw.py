# -*- coding: utf-8 -*-
# @Time    : 2021/11/17 9:19 下午
# @Author  : Jiaming Zhang
# @FileName: 4_streamDraw.py
# @Github  ：https://github.com/CharmingZh
from random import random

import numpy as np
import matplotlib.pyplot as plt
import time

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
    D = U + V
    E = C
    for i in range(128):
        for j in range(128):
            E[i][j] = 255 * np.random.random()


    Xt = np.linspace(0, 128, 128)
    Yt = np.linspace(0, 128, 128)


    #plt.streamplot(Xt, Yt, U, V)
    plt.quiver(X, Y, U, V, D+C)
    #plt.savefig('4_streamDraw.png', dpi=300)

    mat = np.random.randint(1, 127, (2, 10))

    print(mat)
    #plt.show()

    plt.streamplot(Xt, Yt, U, V,
                   color = E,
                   start_points=mat.T)
    plt.show()
    print('finish')
