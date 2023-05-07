from pyspark.sql import SparkSession

if __name__ == "__main__":
    
    sc = SparkSession.builder.appName("odyssey").getOrCreate()
    
    odyssey = sc.sparkContext.textFile("/Users/mukesh/Desktop/Leetcode/Leetcode/SPARK/RDD/Inputs/odyssey.mb.txt")

    odyssey2 = odyssey.flatMap(lambda x : x.split(" "))

    print(f"odyssey : {odyssey2}")
    #ßprint(odyssey.take(5)) 

    odysse3 = odyssey2.map(lambda x :x.lower()).filter( lambda x : '_' not in x and x not in ['in','the','The'])
    print(odysse3.take(100))

    #  Q: How can we find uses of all regular verbs in past tense?
    past_tense = odysse3.filter(lambda x: x.endswith('ed'))
    print("PAST TENSE")
    print(past_tense.take(10))


    # Q: How can we remove all punctuation marks?
    list_punctuation = odysse3.filter(lambda x : x in ("\\p{Punct}"))
    print(list_punctuation.take(100))
    no_punctuation = odysse3.filter(lambda x: x.replace("\\p{Punct}", ""))

    print(no_punctuation.take(10))

