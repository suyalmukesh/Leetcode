from pyspark.sql import SparkSession 

spark = SparkSession.builder.appName("Test Mukesh").getOrCreate()

input_df = spark.read.csv("/Users/mukesh/Desktop/Leetcode/Leetcode/SPARK/RDD/Outputs/Fire_Incidents/*",header=True)
input_df.printSchema()
print(input_df.rdd.getNumPartitions())
input_df.repartition(15)
print(input_df.rdd.getNumPartitions())


input_df.write.option("header",True).csv('/Users/mukesh/Desktop/Leetcode/Leetcode/SPARK/RDD/Outputs/sample')





