import pandas as pd
import numpy as np

import matplotlib.pyplot as plt

import plotly.express as px
import plotly.graph_objects as go

# 406 observations on 8 features:
#
#     1 - MPG (miles per gallon)
#     2 - cylinders
#     3 - engine displacement (cu. inches)
#     4 - horsepower
#     5 - vehicle weight (lbs.)
#     6 - time to accelerate from O to 60 mph (sec.),
#     7 - model year (modulo 100)
#     8 - origin of car (
#           1. American
#           2. European,
#           3. Japanese
#         ).
#
# Feature labels: mpg cys dis hor wei acc myr ori

data = []
dim = []
(row, col) = (0, 0)
labels = ['mpg', 'cys', 'dis', 'hor', 'wei', 'acc', 'myr', 'ori']
df = pd.DataFrame()

# j
def init():
    read_data()
    global row
    global col
    row = len(data)
    col = len(data[0])
    dim_num()
    global df
    df = make_dt()


# 读取数据集
def read_data(mode: str = 'r'):
    data_set = open('dataset/car.txt', mode)
    flag = 0
    for line_raw in data_set:
        line_raw = line_raw.split(" ")
        line = []
        for words in line_raw:
            if words != '':
                line.append(words)

        # 丢弃掉所有描述性文字，只保留数据部分
        if line[0] == 'mpg':
            flag = 1
            continue
        if flag == 1:
            features = []

            count = 0
            for items in line:
                count += 1
                if items == 'NA':
                    items = '-1'
                if count == 8:
                    # 修建掉尾部换行符
                    items = items[0:-1]
                features.append(items)
            data.append(features)
    # 至此，所有数据已按行读取成功


# 统计每种属性的维度
def dim_num():
    for j in range(0, col):
        list_col = set([])
        for i in range(0, row):
            list_col.add(data[i][j])
        dim.append(len(list_col))


# 行列向量模式互转
#   mode = 1：行转列
#   mode = 2：列转行
def transform(mode: int, list_ori: list):
    print("def Transform(): #todo")
    # maybe replaced by Dataframe totally from Pandas
    # Sure, it has been totally replaced ✅


def make_dt():
    df = pd.DataFrame(
        data,
        columns=labels,
        dtype=float
    )
    # print(df)
    return df

"""
def test_1():
    fig = px.parallel_coordinates(
        df,
        color="mpg",
        dimensions=labels,
        title="The 4th Data Visualization Assignment"
    )
    fig.show()
    fig.write_html("release/result/test_1.html")
"""

def test_2():
    fig = go.Figure(data=
    go.Parcoords(
        line=dict(
            color=df['ori'],
            colorscale=[[0, 'green'], [0.5, 'rgb(0, 0, 255)'], [1.0, 'red']]
        ),

        dimensions=[dict(label=col, values=df[col]) for col in labels]
    )
    )  # go.Figure() ends here

    fig.update_layout(
        title="The 4th Data Visualization Assignment"
    )

    fig.show()
    fig.write_html("release/result/Parallel.html")


if __name__ == '__main__':
    init()
    print("Here is in main")
    print(df)

    # Method 1 : Pandas( matplot )
    """
    pd.plotting.parallel_coordinates(
        df,
        "Type",
    )
    """
    test_2()

    print("Hello")
