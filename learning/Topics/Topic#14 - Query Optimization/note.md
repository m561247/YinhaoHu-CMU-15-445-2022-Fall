# 查询优化(Query Optimization)

---

## 关系表达式的转换

通过使用一系列的等价规则，优化器可以把原关系表达式转换为新的关系表达式。连接操作是比较费时的操作，通过关系表达式的转换，对连接操作重新排序，减少中间关系的大小，从而减少连接操作的用时。通过参考既定的等价规则来枚举一系列可以等价转化的表达式，比较不同选择的开销，从而选择最优表达式。通常来说，简单的枚举可能导致优化过程产生较大的时间和空间开销，可以选择不同表达式指向共同子表达式来减少空间开销、避免不必要的代换减少时间开销或者通过启发式方式找到优化表达式来加快优化过程。

---

## 开销评估

一个查询的开销涉及以下几个底层指标：

* CPU：比较小的开销，难以估算。

* 磁盘I/O：传输的块数。

* 内存：DRAM的使用量。

* 网络：传送的消息数量。

上述底层指标的估算可以从整个查询计划所产生的中间关系的大小来反映。

---

## 表达式结果集的估计统计数据

### 目录信息

目录存储的关于数据库关系的统计数据信息包括：1）关系的元组个数；2）关系的块数；3）单个元组的字节大小；4）每个块包含的元组个数；5）一个关系一个属性的不同值个数；6）柱状图；7）样本

### 选择运算结果大小的估计

对于单个等值判词，通过出现次数、平均分布假设以及柱状图可以估计结果大小。

对于单个比较判词，通过比较最值和平均分布假设可以估计结果大小。

对于复杂判词，通过选择度(selectivity)的相关运算可以估计结果大小。

### 连接运算结果大小的估计

当两个关系没有共同属性，那么结果大小为0。

当两个关系的共同属性是一种一个关系的主码，可以得到结果大小的一个上界。如果是外码，可以得到结果的确切大小。

当两个关系的共同属性不是任一关系的主码，通过平均分布假设估计结果大小。

### 其他运算结果大小的估计

包括投影、聚合、集合运算和外连接运算。

### 不同值的数量的估计

数据库关系的不同值可以通过统计数据计算得到。而中间结果的不同值估计有时用于下一级运算，可以通过一些运算方式比如样本估算估计得到。

---

## 执行计划的选择

### 基于开销的连接顺序选择

使用动态规划算法，求解原表达式的不同子表达式的最优顺序来找原表达式的最优顺序。记录每个子表达式的感兴趣顺序能够找出更准确的最优结果。两个值得考虑的边界优化是：1）让每个子表达式只被分一次；2）避免笛卡尔积纳入考虑。

### 用等价规则的基于开销的优化

物理等价规则：允许一个逻辑操作转换为一个物理操作。利用物理等价规则，可以找出所有可能的查询计划。通过避免相同子表达式的多份拷贝以及表达式的相同派生、记忆子表达式的最优解等方式，最优执行计划的寻找方案可以被更高效地执行。

### 启发式优化

基于开销的优化的缺点是优化本身，因为执行计划的可选空间可能非常大从而导致优化本身的开销会很大。通过使用启发式优化可以减少优化过程带来的开销。其包括的常见规则有：1）尽可能早地执行选择算子；2）尽可能早地执行投影算子。

### 不同关系数量的查询计划

* 单一关系：优化单一关系的查询的关键是找到最优的访问方法。可以通过既有的索引或者简单的启发式优化来实现。

* 多个关系：优化多个关系的查询的关键是找到最优的优化空间。有自顶向下(一个例子是 Volcano)和自底向上(一个例子是SystemR)两种方法来完成这样的搜索。

### 优化相关技术

*优化开销预算* 通过动态地设置一个优化过程允许的执行时间来避免优化过程本身造成过多的开销。

*计划缓存* 通过缓存查询的优化执行计划，在后续重新使用。通过此方式可以避免重复的优化，潜在地减少大量优化开销。

---
