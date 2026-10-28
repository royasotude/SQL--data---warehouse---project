create or alter procedure bronze.load_bronze as 
begin
	DECLARE @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
		set @batch_start_time = getdate();
		print '----------------------------------------';
		print 'Loading Bronze Layer';
		print '----------------------------------------';

		print '----------------------------------------';
		print ' Loading CRM Tables';
		print '----------------------------------------';

		set @start_time = GETDATE();
		print '>> Truncating Table: bronze.crm_cust_info'
		truncate table bronze.crm_cust_info;
		print '>> Inserting Data into: bronze.crm_cust_info'
		bulk insert bronze.crm_cust_info
		from 'F:\projects\SQL-dataware-house_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			FIRSTROW =	2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
			set @end_time = GETDATE();
			print '>> Load Duration: ' + cast(datediff(second, @start_time , @end_time) as nvarchar) + 'seconds';
			print '>> ------------'

		set @start_time = getdate();
		print '>> Truncating Table: bronze.crm_prd_info'
		truncate table bronze.crm_prd_info;
		print '>> Inserting Data into: bronze.crm_prd_info'
		bulk insert bronze.crm_prd_info
		from 'F:\projects\SQL-dataware-house_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			FIRSTROW =	2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
			set @end_time = getdate();
			print '>> Load Duration: ' + cast(datediff(second, @start_time , @end_time) as nvarchar) + 'seconds';
			print '>> -------------'

		
		set @start_time = getdate();
		print '>> Truncating Table: bronze.crm_sales_details'
		truncate table bronze.crm_sales_details;
		print '>> Inserting Data into: crm_sales_details'
		bulk insert bronze.crm_sales_details
		from 'F:\projects\SQL-dataware-house_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			FIRSTROW =	2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
			set @end_time = getdate()
			print '>> Load Duration: ' + cast(datediff(second, @start_time , @end_time) as nvarchar) + 'seconds';
			print '>> -------------'


		print '----------------------------------------';
		print ' Loading ERP Tables';
		print '----------------------------------------';


		set @start_time = getdate();
		print '>> Truncating Table: bronze.erp_cust_az12'
		truncate table bronze.erp_cust_az12;
		print '>> Inserting Data into: bronze.erp_cust_az12'
		bulk insert bronze.erp_cust_az12
		from 'F:\projects\SQL-dataware-house_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			FIRSTROW =	2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
			set @end_time = getdate()
			print '>> Load Duration: ' + cast(datediff(second, @start_time , @end_time) as nvarchar) + 'seconds';
			print '>> -------------'


		set @start_time = getdate();
		print '>> Truncating Table: bronze.erp_loc_a101'
		truncate table bronze.erp_loc_a101;
		print '>> Inserting Data into: bronze.erp_loc_a101'
		bulk insert bronze.erp_loc_a101
		from 'F:\projects\SQL-dataware-house_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			FIRSTROW =	2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
			set @end_time = getdate();
			print '>> Load Duration: ' + cast(datediff(second, @start_time , @end_time) as nvarchar) + 'seconds';
			print '>> -------------'


		set @start_time = getdate();
		print '>> Truncating Table: bronze.erp_px_cat_g1v2'
		truncate table bronze.erp_px_cat_g1v2;
		print '>> Inserting Data into: bronze.erp_px_cat_g1v2'
		bulk insert bronze.erp_px_cat_g1v2
		from 'F:\projects\SQL-dataware-house_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			FIRSTROW =	2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
			set @end_time = getdate();
			print '>> Load Duration: ' + cast(datediff(second, @start_time , @end_time) as nvarchar) + 'seconds';
			print '>> -------------'

			set @batch_end_time = getdate();
			print '>> ======================== '
			print 'Loading Bronze Layer is Completed'
			print '>>  Total Load Duration: ' + cast(datediff(second, @batch_start_time , @batch_end_time) as nvarchar) + 'seconds';
			print '>> ======================== '

		end try
		begin catch 
		print '========================================';
		print 'Error Occured During Loading Bronze Layer';
		print 'Error Message' + ERROR_MESSAGE();
		print 'Error Message'  + CAST (ERROR_NUMBER() AS NVARCHAR);
		print 'Error Message'  + CAST (ERROR_STATE() AS NVARCHAR);
		print '========================================';

		end catch
end 

