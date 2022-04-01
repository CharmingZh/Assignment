import sys
import cv2
import matplotlib.pyplot as plt
import numpy as np
import math


def readRGB(filename: str):
    blue, green, red = cv2.split(
        cv2.imread(filename)
    )
    return cv2.merge((red, green, blue))


def readGRAY(filename: str):
    return cv2.cvtColor(
        readRGB(filename),
        cv2.COLOR_BGR2GRAY
    )


def draw_hist(pic):
    row, col = pic.shape
    x = np.arange(1, 256)
    y = np.arange(1, 256)
    for i in range(255):
        y[i] = 0
    for i in range(row):
        for j in range(col):
            y[pic[i][j] - 1] += 1
    plt.plot(x, y)
    plt.xlim(0, 255)


# ohta

def cal(pic, T):
    row, col = pic.shape
    high = low = 0
    n_high = n_low = 0
    # 遍历图像，大于阈值者，计算像素值和、计数值增一
    for i in range(row):
        for j in range(col):
            if pic[i, j] > T:
                high += pic[i, j]
                n_high += 1
            else:
                low += pic[i, j]
                n_low += 1
    # 平均像素灰度值，像素和 / 计数
    m1 = int(high / n_high)
    m2 = int(low / n_low)
    return int((m1 + m2) / 2)  # 据公式计算新的阈值


def ohta(img, T, mode: int):
    # 两种模式：mode == 1时，大于阈值部分置黑
    row, col = img.shape
    img1 = np.zeros((row, col), np.uint8)
    T0 = T
    T1 = cal(img, T0)
    for k in range(100):  # 迭代次数为经验值，可据实际情况选定
        print("This is ", k, " times iteration. T = ", T1)
        if abs(T1 - T0) == 0:  # 若新阈值减旧阈值差值为零，则为二值图最佳阈值
            for i in range(row):
                for j in range(col):
                    if img[i, j] > T1:
                        if mode == 1:
                            img1[i, j] = 0
                        else:
                            img1[i, j] = 255
                    else:
                        if mode == 1:
                            img1[i, j] = 255
                        else:
                            img1[i, j] = 0
            break
        else:
            T2 = cal(img, T1)
            T0 = T1
            T1 = T2  # 变量转换，保证if条件为新阈值减旧阈值
    return img1


# niblack

def window(gray, i, j, win=(5, 5), k=0.5):
    row, col = gray.shape
    # print(row, "rows,", col, "cols.")

    if i >= row or j >= col:
        # print("Error Value")
        return
    wid = (int)(win[0] / 2)
    len = (int)(win[1] / 2)

    from_r = (i - wid) if (i - wid) >= 0 else 0
    to_r = (i + wid) if (i + wid) < (row - 1) else (row - 1)
    from_c = (j - len) if (j - len) >= 0 else 0
    to_c = (j + len) if (j + len) < (col - 1) else (col - 1)

    wid = to_r - from_r + 1
    len = to_c - from_c + 1

    temp = wid * len

    mean = 0
    for i in range(from_r, to_r + 1):
        for j in range(from_c, to_c + 1):
            # print(" i, j", i, j)
            mean += gray[i][j]
    mean /= temp
    # print("       mean", mean)
    s = 0
    count = 0
    for i in range(from_r, to_r + 1):
        for j in range(from_c, to_c + 1):
            count += 1
            s += math.pow(gray[i][j] - mean, 2)
            # print(".      i,j,g[][],m", i, j, gray[i][j], mean)
    s = math.sqrt(s / temp)
    # print(".      s", s)
    # print("       s", s)
    # print(count, temp)
    return mean + k * s


def niblack(gray, R=128, k=0.5, win=(5, 5)):
    row, col = gray.shape
    img = np.zeros((row, col), np.uint8)

    count = 0

    for i in range(row - 1):
        if count == 80:
            print(i / (row - 1))
            count = 0
        count += 1
        for j in range(col):
            T = window(gray, i, j, win, k)
            if gray[i][j] > T:
                img[i][j] = 0
            else:
                img[i][j] = 255
    return img


def window_2(gray, i, j, win=(5, 5), k=0.5, R=128):
    row, col = gray.shape
    # print(row, "rows,", col, "cols.")

    if i >= row or j >= col:
        # print("Error Value")
        return
    wid = (int)(win[0] / 2)
    len = (int)(win[1] / 2)

    from_r = (i - wid) if (i - wid) >= 0 else 0
    to_r = (i + wid) if (i + wid) < (row - 1) else (row - 1)
    from_c = (j - len) if (j - len) >= 0 else 0
    to_c = (j + len) if (j + len) < (col - 1) else (col - 1)

    wid = to_r - from_r + 1
    len = to_c - from_c + 1

    temp = wid * len

    mean = 0
    for i in range(from_r, to_r + 1):
        for j in range(from_c, to_c + 1):
            # print(" i, j", i, j)
            mean += gray[i][j]
    mean /= temp
    # print("       mean", mean)
    s = 0
    count = 0
    for i in range(from_r, to_r + 1):
        for j in range(from_c, to_c + 1):
            count += 1
            s += math.pow(gray[i][j] - mean, 2)
            # print(".      i,j,g[][],m", i, j, gray[i][j], mean)
    s = math.sqrt(s / temp)
    # print(".      s", s)
    # print("       s", s)
    # print(count, temp)
    return mean * (1 + k * ((s / R) - 1))


def sauvola(gray, R=128, k=0.5, win=(5, 5)):
    row, col = gray.shape
    img = np.zeros((row, col), np.uint8)

    count = 0

    for i in range(row - 1):
        if count == 80:
            print(i / (row - 1))
            count = 0
        count += 1
        for j in range(col):
            T = window_2(gray, i, j, win, k)
            if gray[i][j] > T:
                img[i][j] = 0
            else:
                img[i][j] = 255
    return img


if __name__ == '__main__':
    book = readGRAY('data/book.jpg')

    print("read color")
    book_col = readRGB('data/book.jpg')
    print("read gray")
    book_oir = book.copy()
    print("ohta")
    # draw_hist(book)
    book_ohta = ohta(book, 127, 0)
    print("niblack")
    book_nib = niblack(book, k=0.5, win=(31, 31))
    book_sau = sauvola(book, R=128, k=0.5, win=(31, 31))

    plt.subplot(231)
    plt.imshow(book_col, cmap='gray')
    plt.xticks([])  # 去掉x轴
    plt.yticks([])  # 去掉y轴
    plt.axis('off')  # 去掉坐标轴
    plt.title("RGB")

    plt.subplot(232)
    plt.imshow(book, cmap='gray')
    plt.xticks([])  # 去掉x轴
    plt.yticks([])  # 去掉y轴
    plt.axis('off')  # 去掉坐标轴
    plt.title("Gray")

    plt.subplot(233)
    plt.imshow(book_ohta, cmap='gray')
    plt.xticks([])  # 去掉x轴
    plt.yticks([])  # 去掉y轴
    plt.axis('off')  # 去掉坐标轴
    plt.title("Ohta")

    plt.subplot(234)
    plt.imshow(book_nib, cmap='gray')
    plt.xticks([])  # 去掉x轴
    plt.yticks([])  # 去掉y轴
    plt.axis('off')  # 去掉坐标轴
    plt.title("Niblack")

    plt.subplot(235)
    plt.imshow(book_sau, cmap='gray')
    plt.xticks([])  # 去掉x轴
    plt.yticks([])  # 去掉y轴
    plt.axis('off')  # 去掉坐标轴
    plt.title("Sasulova")

    plt.subplot(236)
    draw_hist(book)
    plt.xticks([])  # 去掉x轴
    plt.yticks([])  # 去掉y轴
    plt.axis('off')  # 去掉坐标轴
    plt.title("Hist")
