CREATE procedure metadata.insert_presentation_metadata
    @pipeline_run_id VARCHAR(255),
    @table_name VARCHAR(255),
    @processed_date DATETIME2
AS
    INSERT INTO [nyc_project_warehouse].[metadata].[processing_log] (pipeline_run_id, table_processed, rows_processed, latest_processed_pickup_datetime, processed_datetime)
    select 
    @pipeline_run_id as pipeline_run_id,
    @table_name as table_processed,
    count(*) as rows_processed, 
    max(tpep_pickup_datetime) latest_processed_pickup_datetime,
    @processed_date as processed_datetime
    from presentation.nyc_taxi_yellow
    

