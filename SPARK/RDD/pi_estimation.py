from pyspark.sql import SparkSession
import random
def inside(p):
    x, y = random.random(), random.random()
    return x*x + y*y < 1

if __name__ == "__main__":
    NUM_SAMPLES = 100 
    sc = SparkSession.builder.appName("Pi Estimation").getOrCreate()
    
    count = sc.sparkContext.parallelize(range(0, NUM_SAMPLES)) \
             .filter(inside).count()
    print("Pi is roughly %f" % (4.0 * count / NUM_SAMPLES))

