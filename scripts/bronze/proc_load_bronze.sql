/* 
Stored procedure: load bronze layer (source -> bronze)
Script purpose: loads data into the 'bronze' schema from external CSV files
Performs:
- Truncates the bronze tables before loading data
- Use "BULK INSERT" command to load data from csv to bronze tables.

USAGE: 
- EXEC bronze.load_bronze
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time Datetime, @end_time DATETIME
	BEGIN TRY
		Print '================================='
		PRINT 'Loading Bronze Layer'
		Print '================================='
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
	
		);

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
	
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' +  CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';


		TRUNCATE TABLE bronze.crm_sales_details;

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
	
		);


		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp/cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
	
		);

		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp/px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
	
		);

		TRUNCATE TABLE bronze.erp_loc_a101

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\ASUS\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp/loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
	END TRY
	BEGIN CATCH
		PRINT '========================'
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'EROR MESAGE' + ERROR_MESSAGE();
		PRINT 'EROR MESAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'EROR MESAGE' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '========================'

	END CATCH
END
