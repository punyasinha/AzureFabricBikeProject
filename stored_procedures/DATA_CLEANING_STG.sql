CREATE PROCEDURE stg.DATA_CLEANING_STG
@start_date DATETIME2,
@end_date DATETIME2
as
SELECT * FROM landing.nyc_taxi_yellow WHERE tpep_pickup_datetime>@start_date and tpep_pickup_datetime<@end_date
