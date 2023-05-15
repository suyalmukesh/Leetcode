#!/usr/bin/env python
# coding: utf-8

# # Assignment One : Read data from source and update salary where name is equal to 'mukesh'

# In[13]:


from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("Demo").getOrCreate()

data = [('mukesh','suyal','M',3000),
        ('rohan','sharma','M',5000),
        ('neha','suyal','F',9000)      
       
       ]
schema = ["firstname","lastname","gender","salary"]

df1 = spark.createDataFrame(data,schema=schema)

df1.printSchema()

df1.show(truncate=False)


# In[14]:


from pyspark.sql.functions import when
df2 = df1.withColumn("salary", when(df1.firstname == "mukesh",1000).otherwise(df1.salary))
df2.show()


# # Assignment 2 : Update the same record in Target RDBMS table , which may exist in RDS 

# In[ ]:


## Now I assume we have MySQL database in RDS and I am reffering myDB as schema and tablename is employee 
## We need to make a DataBase Connection 

import mysql.connector
user = 'mukesh'
pwd  = '*****'

connection_string = {"host" : "<id address>","user":user,"password":pwd,"database":"myDB" }

# broadcast to each partition 
broadcast_connection = spark.broadcast(connection_string)


# This Code Block will fail ( as expected ) because we have not installed mysql plugin in our pyspark . 
# Also, we don't have mysql installed or accessed 


# In[16]:


## Creating this function to process a single row of dataframe 
## Mysql connection is involved here , so it will fail as we don't have MYSQL installed in local or RDS

def process_row(row,cursor_select,curs_insert,curs_update):
    firstname = row.__getitem__("firstname")
    lastname  = row.__getitem__("lastname")
    gender = row.__getitem__("gender")
    salary = row.__getitem__("salary")
    
    # Since I was asked to update based on firstname (where name = 'mukesh')
    sql = f"select * from myDB.employee where firstname = '{firstname}'"
    cursor_select.execute(sql)
    records = curdor_select.fetchall()
    
    count = len(records)
    
    if count > 0 : 
        operation = 'UPDATE'
    else:
        operation = 'INSERT'
        
    if operation == 'UPDATE':
        values = (salary,firstname)
        sql_string = """update myDB.employee set salary=%s where firstname=%s"""
        curs_update.execute(sql_string,val)
        
    elif operation == "INSERT":
        values = (firstname,lastname,gender,salary)
        sql_string = """
                        insert into myDB.employee (firstname,lastname,gender,salary)
                        values (%s,%s,%s,%s)
                     """
        curs_insert.execute(sql_string)
        


# In[ ]:


## This function will parse each row of dataframe and send to above function 
## Mysql connection is involved here , so it will fail as we don't have MYSQL installed in local or RDS

def process_dataframe(partition):
    # Get the broadcasted connection values 
    connection_properties = broadcast_connection.value
    
    # Extract values from this connection_properties
    database = connection_properties.get('database')
    user = connection_properties.get("user")
    password = connection_properties.get("password")
    host = connection_properties.get("host")
    
    db_conn = mysql.connector.connect (
    host=host,
    user=user,
    password=password,
    host=host
    )
    
    dbc_insert = db_conn.cursor(prepared=True)
    dbc_update = db_conn.cursor(prepared=True)
    dbc_select = db_conn.cursor(prepared=True)
    
    for row in partition:
        process_row(row,dbc_select,dbc_insert,dbc_update)
        
    db_conn.commit()
    dbc_insert.close()
    dbc_select.close()
    dbc_update.close()
    


# In[24]:


# Now we have already updated the dataframe above as : 
df2.show()


# In[ ]:


# Now we have to write this dataframe to Existing Target Table ( RDBMS )
# Also , it is an UPSERT operation , so we are updating existing record and Inserting new record
# It will not work again as mysql database is not in place 

df2.rdd.foreachPartition(process_dataframe)

## COMPLETED ### 

