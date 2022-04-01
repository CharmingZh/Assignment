# 数据可视化大作业_4

[toc]

> Using Python 3.9 with :
>
> - numpy
> - Marplot.pyplot

```shell
.
├── Parallel_coor_ana.ipynb					#├── 平行坐标测试用例
├── README.md 										#├── 本文件即作业说明文档
├── Themeriver_ana.ipynb						#├── ThemeRiver测试用例
├── dataset											#├── 数据集文件夹
│   ├── anjuke_extract_data.xlsx				#│   ├── 安居客爬虫数据（非完整）
│   └── car.txt									#│   └── 车辆性能信息数据
├── reference										#├── 参考资料文档
│   ├── PARALLEL_CORDINATION.pdf				#│   ｜
│   ├── REQUIREMENTS.pdf						#│   ｜
│   └── plotly.para-coord.md					#│   └── Plotly Library Document
├── release											#├── 最终发行版（作业最终提交代码）
│   ├── Parallel.py								#│   ├── 平行坐标法
│   └── ThemeRiver.py							#│   └── ThemeRiver
└── result											#└── 输出结果（release文件夹里有最终版）
    ├── demo.html
    ├── test.html
    ├── test_1.html
    ├── test_2.html
    ├── test_advanced.html
    └── themeRiver.png

```



## Assignment_1 : 平行坐标

### 1.1 Background

> 读入数据 car.txt，用平行坐标进行可视化。并且:
>
> - 分析汽缸（Cylinder）数量，每公升里程，马力之间的关系【选择合适的平行坐标顺序】 
> - (选做) 交互选中的车款（马力大），观察其每加仑里程、汽缸、重量、加速能力，出厂年份。
>
> > 406 observations on 8 features:
> >
> > 1. MPG (miles per gallon);
> >2. cylinders;
> > 3. engine displacement (cu. inches)
> >4. horsepower;
> > 5. vehicle weight (lbs.);
> >6. time to accelerate from 0 to 60 mph (sec.);
> > 7. model year;
> >8. origin of car { American, European, Japanese }.
> 

### 1.2 Data preprocessing 

读取数据集的时候，要丢弃掉前几行的说明性文字，同时我将所有的`NA`项替换为字符串“-1”，因为在描述这些物理量的时候，-1是一个没有意义的值，这么做的好处是可以将来可以统一处理为数字；

```python
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
```

读取完数据集后，我将其保存为 DataFrame 格式：

```python
def make_dt():
    df = pd.DataFrame(
        data,
        columns=labels,
        dtype=float
    )
    # print(df)
    return df
```

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209195436947.png" alt="image-20211209195436947" style="zoom: 67%;" />

详情可见源代码以及 Jupyter Notebook；

### 1.3 Analysis

- 原始图像：

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209184928902.png" alt="image-20211209184928902" style="zoom: 50%;" />

- 维度重排：

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209184827808.png" alt="image-20211209184827808" style="zoom: 50%;" />

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209185831075.png" alt="image-20211209185831075" style="zoom: 50%;" />

> 由上可见，维度重排后，数据的聚合程度更好，可以更加直观的从图中获取有用信息，如：
>
> - 美系车、欧系车的发动机均较日系车更轻，因此在气缸数、马力等方面落后于日系车；
> - 美系车、欧系车的发动机单位加速能力（百公里加速秒数/气缸数）性能整体优于日系车；
> - 由于日系车气缸数较多，因此续航能力整体落后于欧美车型。

- 交互选中车款，观察其续航、气缸、重量、百公里加速、年份等信息：

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209185309841.png" alt="image-20211209185309841" style="zoom: 33%;" />

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209185356190.png" alt="image-20211209185356190" style="zoom: 33%;" />

> 通过交互式选中马力参数，可以将数据大体分为两类，日系车、欧美系车型：
>
> - 大马力的车型几乎都由日本生产，同时注意到日本的大马力车型多数产于八十年代前；
> - 多气缸带来的问题是很明显的，由图可知，日系车续航整体弱于欧美车型，同时零件的损耗率相对较高；

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209185431976.png" alt="image-20211209185431976" style="zoom: 33%;" />

> 欧系车不同年份都以轻量级车型为主，由于欧洲地区地势狭小，大动力、大重量车型会难以在交错纵横的街道间通行，同时欧系车整体注重续航性能；
>
> 不知道是否是德系车对于做工的执着，欧系车的零件损耗率最低。

- 具体分析成对指标：

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209191413671.png" alt="image-20211209191413671" style="zoom:67%;" />

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209191425086.png" alt="image-20211209191425086" style="zoom:67%;" />

> 我们观察最具有对比性的日系车和美系车，通过固定气缸数（四个），来分析两大产地的发动机性能：
>
> - 可以看到，对于低杠数汽车，零部件损耗率较低，同时发动机重量也减轻了；
> - 对于美系车而言，在发动机缸数、百公里加速大体相同的情况下，会提供比日本车型更持久的续航性能；
> - 美系车发动机的重量，整体比日本车轻，说明对于燃油热的利用率较高。

### 1.4 Source code

见附件📎或 Jupyter Notebook 文档；

放一些作业过程中比较好看的图（均存储在了：test/result 中）：

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209195536941.png" alt="image-20211209195536941" style="zoom: 50%;" /><img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209195553769.png" alt="image-20211209195553769" style="zoom:50%;" />

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209195625165.png" alt="image-20211209195625165" style="zoom:50%;" /><img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209195701088.png" alt="image-20211209195701088" style="zoom:50%;" />

## Assignment_2 : 文本可视化

### 2.1 Background

- 用 word cloud 工具完成作业 1 第 1 题
- ThemeRiver 采用网络爬虫或者手工方式，收集某一事件或者主题的微博信息，并进行主题可视化。

### 2.2 Data preprocessing 

> 爬虫源代码就不放出了，这里详细解释一下我的源代码是如何处理这些数据的。

#### 2.2.1 词云

> 为了获取用户ID，我的思路是：先获取近期的文章，然后从文章的评论区中获取评论用户的ID。
>
> 首先，我使用抓包工具 **Charles** 抓包所需要的各个API：
>
> 1. 获取 article ID 的 API：http://api.dongqiudi.com/app/tabs/iphone/1.json，这是一页（共20篇）的数据，下一页的API在'next'字段中。
> 2. 获取评论用户的 API：http://api.dongqiudi.com/v2/article/{article_id}/comment?sort=down&version=600，同样地，下一页的API在'next'字段中。
> 3. 获取用户信息的 API：https://api.dongqiudi.com/users/profile/{user_id};
> 4. 获取球队信息的 API：http://api.dongqiudi.com/catalogs 和 http://api.dongqiudi.com/catalog/channels/{league_id}。
>
> 其中，获取球队信息的API需要登录，具体请求方法为：在网页版懂球帝上登录自己的账号后，获取Cookie，并将这个Cookie放入headers中再请求这两个API。
>
> 爬取数据我使用的是 requests/requests，其中爬取评论区用户ID的时间比较长，而且由于下一页的API是由上一页API返回的，所以只能串行而不能并行。为了稳定性和鲁棒性考虑，还需要有断点继续机制。
>
> 在爬取到60万个用户ID后，使用这些ID来获取各个用户的信息，这个阶段是可以并行的。

#### 2.2.2 ThemeRiver 安居客

### 2.3 Analysis

#### 2.3.1 词云

> 这些用户中，有 263,960 人为男性用户，有 18,227 人为女性用户，其余 328,609 人没有填写性别信息。
>
> <img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209200147150.png" alt="image-20211209200147150" style="zoom:50%;" />
>
> 懂球帝App中，每个用户可以设置自己最喜爱的球队，然后球队队标会出现在名字旁边，比如这样:
>
> <img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209200232531.png" alt="image-20211209200232531" style="zoom:33%;" />
>
> 先看看国家队，同样地，这里可以选择的国家队数量也是有限的。
>
> <img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209200258259.png" alt="image-20211209200258259" style="zoom:50%;" />
>
> 再看看欧洲五大联赛
>
> <img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209200326888.png" alt="image-20211209200326888" style="zoom:50%;" />
>
> 下图展示了Top 20的俱乐部，巴萨皇马遥遥领先...
>
> <img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209200422333.png" alt="image-20211209200422333" style="zoom:50%;" />
>
> 然后是对用户名字的分析,使用 jieba分词 并去除一些无意义的结果后，得到了下面这个词云。
>
> <img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209200507726.png" alt="image-20211209200507726" style="zoom:50%;" />
>
> '梅西'出现的频率比'C罗'大不少，我觉得这是因为，梅西的粉丝一般就起名'梅西'或者'Messi'了，而C罗的粉丝可能会起名 'C罗'、'克斯斯蒂亚诺 罗纳尔多'、'CR7'...稀释掉了不少。

#### 2.3.2 ThemeRiver 安居客

爬取思路和懂球帝差不多，使用了 `BeautifulSoup4, Request` 库循环请求，得到了如下数据：

![image-20211209200808188](/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209200808188.png)

经数据清洗后，有效数据 2000 条，其中索引数据如下：

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209200910804.png" alt="image-20211209200910804" style="zoom: 67%;" /><img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209200917285.png" alt="image-20211209200917285" style="zoom:67%;" />

共有四十列，去掉为了迭代爬取而保存的链接信息，以及一些其他信息，得到了如下列表：

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209201019642.png" alt="image-20211209201019642" style="zoom:67%;" />

清洗依据如下：

观察Theme River 得知，其主要表现为随着时间变化，某一项属性从出现到变多，最后消失，所以我认为，开发商数据等是无用的，我希望能够通过竣工时间为主线，构建一条关于建筑开发商更关注的卖点的河流，由于安居客自动对二手房进行了标注，并且将更受关注的标签排在前头，因此，我将每一个二手房的竣工时间，以及排在前四的标签保留，通过 `set()` 数据结构计算出了总共有多少属性（详细步骤可以看我的Jupyter notebook 文档），最终得到了一共有十一条属性：

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209201406986.png" alt="image-20211209201406986" style="zoom:67%;" />

循环遍历（我笨），可以对每一个属性建立list，和年份数据对齐，如果总表四列中出现了相应的属性，即对相应位置的计数器加一，最后得到11个属性的list，每个索引位置对应当年的属性的数量，以此为依据作图。

下图为进行了一次迭代后的list合并后的数据，一共要进行四次迭代：

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209201604220.png" alt="image-20211209201604220" style="zoom:67%;" />

最终绘制的图形如下：

![image-20211209201701199](/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209201701199.png)

![image-20211209203749604](/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209203749604.png)

可以看到，数据有较高的锯齿感，分析可知：

- 可能由于数据的离散程度较高，不可以较好的拟合出曲线感；
- 可能随着竣工时间的变化，相应的属性随着时间的变化不大，当然也可能是由于时间跨度过小，如果增大时间跨度的话，可能会更美观一些；
- 可能属性的数量过多，导致了图片太过于凌乱，可视化效果较差；

不过我们还是可以通过这个图片看出一些有用的信息，根据上图的标签，我们可以分析：

- 随着时间的推移，大户型（绿色）、别墅（青色）的需求逐渐降低，人们转而开始关注配套设施齐全（紫色），这可能是由于随着年轻一代人消费观念转变，认为配套设施的齐全比住 Big House 更能提高生活质量，也意味着人们对于身份认同感的淡化；
- 对于小户型，对于二手房需求者一直很有吸引力；
- 人们似乎很少考虑次新小区、较老住房；
- 出人意料的是，人们不太关注总价的高低，这说明有二手房需求的人，一般是有一定的经济基础，并且不太会依靠价格指标而给自己挑选住房，同时当然也不会挑选超出自己经济能力的房屋；

所以可以删除掉一些属性，再次作图，只保留观察一下图片的效果：

> 只保留了大户型、别墅、配套设施、小户型。

<img src="/Users/charminzh/PycharmProjects/dataVisualization/Assignment_4/README.assets/image-20211209204951586.png" alt="image-20211209204951586" style="zoom:67%;" />

### 2.4 Source code

见 Jupyter Notebook 文档；