1. FD文件夹里的是拍的FD图还有两个task的结果，都标好了，因为用到了fundamental矩阵，所以放到了这里
2. HG文件夹里的是拍的HG的图，还有一个task2的结果
3. cali_images 是相机标定用到的图
4. test是task4.1 Homography的预测，你看这个task里用的哪个图片的名字，就对应着这两幅图片。
5. test2 是task 4.2 Fundamental 的预测，同理，看读入的图片是啥名字，对应着这两幅图。
6. test4 是task 5.1 的结果，注意，这里我们用的是之前做的那两个没有格子的图，名字是new_7 和new_8。
7. calibrationSession.mat是相机标定的模块，打开方式是点matlab那个app，找到 camera calibrator， 点进这个app后选择打开已有session，然后打开这个就能看到整个session的情况了
    ，如果你感兴趣可以打开玩玩，虽然用不到了后面，因为里面的参数我已经保存了。
8. cameraParams.mat 是里面相机标定后得到的相机参数结果，可以看一下。

******： new_7, new_8,  FD9, FD10 都是没有改size的，其他的size 都改了， 最后， 我嫩叠