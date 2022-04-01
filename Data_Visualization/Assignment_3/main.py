import numpy as np
import matplotlib.pyplot as plt
import math

if __name__ == '__main__':
    data = open('jet.vecT', 'r')
    temp = open('tempData', 'w+')
    result = open('jetMag.txt', 'w')
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
    Mat = np.zeros(shape=(int(row), int(col) * 2))
    count_line = 0
    count_row = 0
    for line in tempData:
        if count_line == int(col) * 2:
            count_line = 0
            count_row += 1
        line = line.split(" ")
        Mat[count_row][count_line] = line[0]
        Mat[count_row][count_line + 1] = line[1]
        count_line += 2
    print(Mat)
    print("                    The shape of this Matrix is: ", Mat.shape)
    print(Mat[0][0])
    print('end')
    tempData.close()

    X, Y = np.mgrid[0:128, 0:128]

    U = np.zeros(shape=(int(row), int(col)))
    V = np.zeros(shape=(int(row), int(col)))

    print(Mat.shape)
    print(X.shape)
    print(U.shape)

    for i in range(0, 128):
        j = 0
        num = 0
        while j < 256:
            U[i][num] = Mat[i][j]
            V[i][num] = Mat[i][j+1]
            j += 2
            num += 1

    print(U)
    print(V)
    C = U * V
    np.savetxt('Mat', Mat)
    pic = plt.quiver(X, Y, U, V, C)
    plt.savefig('third.png', dpi=300)
    # plt.show()
    result.close()
