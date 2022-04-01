> @Time    : 2021/11/17 3:37 下午\
@Author  : Jiaming Zhang\
@FileName: REQUIREMENT.md\
@Github  : https://github.com/CharmingZh

# 2021-2022-1《数据可视化》- 作业_3

- 要求

  - **编程语言python** 

  - **提交每一题的代码以及结果截图**

  - **每一题一个代码源文件**

  - **一个综合的结果描述文档，说明每一题的结题思路及结果截图。**

 



1. 根据示例，读入向量场（jet.vecT，文本文件）。计算该向量场每个向量的模，存到文本文件(jetMag.txt)。

```shell
# 1.  向量场文件格式（数值以空格隔开）
第1行： 宽w 高h

第2行： 第1行向量(w个)x y x y … x y

第3行： 第2行向量(w个)x y x y … x y

…

第h+1行： 第h行向量(w个)x y x y … x y

# 2.  输出文件格式（数值以空格隔开）
第1行： 宽w 高h

第2行： 第1行(w个)m m … m

第3行： 第2行(w个)m m … m
…
第h+1行： 第h行向量(w个，中间空格隔开)m m … m
```
 

2. 读入题1中的向量模文件(jetMag.txt)，使用两种颜色映射方案来可视化。可视化时，直接在w×h的区域绘制不同颜色的点，点的颜色与该处数值大小相对应。

    1.  其中包含一种常用的颜色映射方案：蓝色对应数值低，红色对应数值高。

    2.  使用双线性插值提高可视化数据的分辨率，如绘制大小为(2*w）×(2*h)的区域，可对参考图像进行放缩

    3.  可以尝试将可视化结果保存成图像文件。

​                               ![image-20211117153653099](https://tva1.sinaimg.cn/large/008i3skNly1gwi6qxe4znj30c40c2wel.jpg)

3. 读入向量文件（jet.vecT）。并用箭头图标进行向量场可视化（如示例）。

 ![image-20211117153704110](https://tva1.sinaimg.cn/large/008i3skNly1gwi6r2z2fdj30lm0lo7cf.jpg)

4. 使用流线可视化方法对（jet.vecT）进行可视化。

    1.  随机生成10个点（种子点），过这些点生成流线。

    2.  均匀生成种子点（如每隔1点），生成流线。

 ![image-20211117153710649](https://tva1.sinaimg.cn/large/008i3skNly1gwi6r7bhhwj30lm0len5k.jpg)

5. 使用 [LIC方法](http://www.zhanpingliu.org/research/flowvis/lic/lic.htm) 可视化方法对（jet.vecT）进行可视化。

 ![image-20211117153720078](https://tva1.sinaimg.cn/large/008i3skNly1gwi6rchehzj30cg0cg0t9.jpg)
