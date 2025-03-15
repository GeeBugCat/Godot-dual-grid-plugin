# Godot-dual-grid-plugin
# Godot双网格瓦片地图插件

## 安装
	将文件夹放进项目根目录的addons文件夹中(如果没有就创建一个)

![Alt text](dualgridtilemaplayer/READMEIMG/image.png)

	再在 项目 → 项目设置 → 插件 中启用DualGridTilemapLayer即可

![Alt text](dualgridtilemaplayer/READMEIMG/image-1.png)
![Alt text](dualgridtilemaplayer/READMEIMG/image-2.png)

## 设置
	目前只支持正方形总计6块图块的瓦片集;

	瓦片集模板按以下绘制:

![Alt text](dualgridtilemaplayer/READMEIMG/%E5%9C%B0%E5%BD%A2%E6%A8%A1%E6%9D%BF.png)
![Alt text](dualgridtilemaplayer/READMEIMG/%E7%BB%98%E5%88%B6%E6%A8%A1%E6%9D%BF.png)

	并且按以下顺序设置备选图块:

![Alt text](dualgridtilemaplayer/READMEIMG/%E5%A4%87%E9%80%89%E5%9B%BE%E5%9D%97%E6%A8%A1%E6%9D%BF.png)

	如何设置备选图块：

	在tileset面板中

![Alt text](dualgridtilemaplayer/READMEIMG/image-3.png)

	点击选择

![Alt text](dualgridtilemaplayer/READMEIMG/image-4.png)

	右键需要创建的图块生成备选图块

![Alt text](dualgridtilemaplayer/READMEIMG/image-5.png)

	加号生成更多的备选图块

![Alt text](dualgridtilemaplayer/READMEIMG/image-6.png)

	选择备选图块并在左侧渲染栏中编辑为模板样式

![Alt text](dualgridtilemaplayer/READMEIMG/image-7.png)

	将设置好的tileset设置给插件节点即可
![Alt text](dualgridtilemaplayer/READMEIMG/b66f2112a11950ef86bef859a1fdc705.png)
## 使用
	使用占位符进行绘制,而且你可以在编辑器中预览,不过整片图块编辑时需要再次点击鼠标才会渲染修改

	使用此节点的set_tile(vector2)来进行程序化绘制,在指定世界网格的坐标绘制图块

## 其他
	目前此插件一个图层只支持一种地形,不过我也建议一个图层只使用一个地形,一来我可以懒得更新匹配多种地形的功能(不是),二来可以避免绘制指数级增长的图块,将优先级更高的图块显示在更上方即可

	绘制图块需要注意的
	斜向的路径会很奇怪,尽量避免绘制这种地形,而绘制更宽的斜向路径
