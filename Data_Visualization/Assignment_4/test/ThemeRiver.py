"""
    爬虫数据使用 12.05 本人爬去珠海 12月小区商品房数据
    其中由于 robots 权限问题，爬虫实现代码、完整数据均不展示
    使用 BeautiSoup4 实现
    """"""""""""""""""""""""""""""""""""""""""""""""
    为了使数据集能够适配 matplot.pyplot，将数据集做了适当的预处理
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

"""
data_set = pd.read_excel('anjuke_extract_data.xlsx')
print(data_set)
"""


if __name__ == '__main__':
    data_set = pd.read_excel('anjuke_extract_data.xlsx')
    print(data_set)
