CREATE procedure metadata.insert_staging_metadata
    @pipeline_run_id VARCHAR(255),
    @table_name VARCHAR(255),
    @processed_date DATETIME2
AS
    INSERT INTO [nyc_project_warehouse].[metadata].[processing_log] (pipeline_run_id, table_processed, rows_processed, latest_processed_pickup_datetime, processed_datetime, file_name)
    select 
    @pipeline_run_id as pipeline_run_id,
    @table_name as table_processed,
    rows_processed,
    latest_processed_pickup_datetime,
    @processed_date as processed_datetime,
    file_name 
    from(
    
    select 
    count(*) as rows_processed, 
    max(tpep_pickup_datetime) as latest_processed_pickup_datetime,
    a.file_name
    from (
        select stg.file_name,stg.tpep_pickup_datetime from stg.nyc_taxi_yellow  stg
        left join [nyc_project_warehouse].[metadata].[processing_log] met
        on stg.file_name=met.file_name where met.file_name is null
          )a group by file_name


    )b
    

