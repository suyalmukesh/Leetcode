from pyspark import * 
from pyspark.sql import SparkSession 

sc = SparkSession.builder.appName("Word Count").getOrCreate()

rdd1 = sc.sparkContext.textFile("/Users/mukesh/desktop/Spark/Input/songs.txt")
print(f"Partition_Count : {rdd1.getNumPartitions()}")

splitrdd = rdd1.flatMap(lambda x:x.split(" "))

maprdd = splitrdd.map(lambda x:(x,1))

countrdd = maprdd.reduceByKey(lambda a,b:a+b)

countrdd.coalesce(1).saveAsTextFile("/Users/mukesh/desktop/Spark/Output/count_words2")

print("-----------------------------------------------------------")



