# -*- coding: utf-8 -*-
# @Time    : 2021/11/17 8:19 下午
# @Author  : Jiaming Zhang
# @FileName: 2_distDraw.py
# @Github  ：https://github.com/CharmingZh

from PIL import Image
import numpy as np
import math

if __name__ == '__main__':
    data = open('jetMag.txt', 'r')
    pic = Image.new('RGB', (128, 128))
    count = 0
    for line in data:
        line = line.split(" ")
        col = 0
        if col == 128:
            col = 0
        for item in line:
            print('count = ', col)
            try:
                # item = float(item) * 128
                item = (255) / (71.58306) * float(item)
                #  MIN +(MAX-MIN)/(d_max-d_min) * (data - d_min)
                item = int(item)
                print(item)
                # pic.putpixel([count, col], (int(item/4), int(item/2), item))
                pic.putpixel([count, col], (0, 0, item))
                col += 1
            except ValueError as e:
                print(e)
        count += 1

    pic.show()
    pic.save('2_distPrint.png')
