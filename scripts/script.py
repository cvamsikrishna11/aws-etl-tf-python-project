import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.sql.functions import when, col, lit, year
from pyspark.sql.types import StringType
from awsglue.dynamicframe import DynamicFrame



## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Data source from the glue catalog
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "netflix-default-movies-database", table_name = "netflix_movies")

# Convert DynamicFrame to DataFrame for more flexible manipulation
df = datasource0.toDF()

# Dataframe details
print("Total number of rows in the dataframe: ", df.count())
print("First 5 rows of the dataframe: ", df.show())


# Convert 'release_year' from bigint to date
df = df.withColumn('release_year', df['release_year'].cast(StringType()))
df = df.withColumn('release_year', year(df['release_year']))

# One hot encoding for 'type' column
df = df.withColumn('type', when(col('type') == 'Movie', lit(1)).otherwise(lit(0)))

# Handling Null Values for 'director' column
df = df.na.fill({'director': 'Unknown'})

# Conversion from Dataframe to Dynamic Frame as expected by DynamoDB
dynamic_frame_write = DynamicFrame.fromDF(df, glueContext, "dynamic_frame_write")


# Write it out to DynamoDB
print("Inserting into DynamoDB successfully!!")
glueContext.write_dynamic_frame.from_options(frame = dynamic_frame_write,
                                             connection_type = "dynamodb",
                                             connection_options = {"dynamodb.output.tableName": "netflix-default-movies-table"})


print("Inserted into DynamoDB successfully!!")

job.commit()