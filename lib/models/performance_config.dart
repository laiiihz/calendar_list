class PerformanceConfig {
  ///缓存月视图
  int buildCacheMonth = 0;

  ///构建延时
  ///增加延时以提高性能
  Duration buildDelay = Duration(milliseconds: 400);
}
