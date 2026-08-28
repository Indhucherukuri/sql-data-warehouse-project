CREATE OR ALTER PROCEDURE Bronze.load_Bronze AS
BEGIN
DECLARE @Start_time DATETIME, @End_time DATETIME, @Batch_start_time DATETIME, @Batch_end_time DATETIME;
SET @Batch_start_time= GETDATE();
 BEGIN TRY 
        PRINT '==========================================';
        PRINT 'Loading Bronze layer';
        PRINT '==========================================';

        PRINT '------------------------------------------';
        PRINT 'Loading CRM tables';
        PRINT '------------------------------------------';

        SET @Start_time= GETDATE();
        PRINT '>> Truncating Table: Bronze.crm_cust_info';
        TRUNCATE TABLE Bronze.crm_cust_info

        PRINT '>> Inserting Data Into: Bronze.crm_cust_info';
        BULK INSERT Bronze.crm_cust_info                                             
        FROM 'C:\sql\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'   
        WITH(
           FIRSTROW= 2,
           FIELDTERMINATOR= ',',
           TABLOCK
        );
        SET @End_time= GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second,@Start_time,@End_time) AS NVARCHAR)+ ' Seconds';
        PRINT '--------------------------------------'

        SET @Start_time= GETDATE();
        PRINT '>> Truncating Table: Bronze.crm_prd_info';
        TRUNCATE TABLE Bronze.crm_prd_info

        PRINT '>> Inserting Data Into: Bronze.crm_prd_info';
        BULK INSERT Bronze.crm_prd_info
        FROM 'C:\sql\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH(
            FIRSTROW= 2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @End_time= GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second,@Start_time,@End_time) AS NVARCHAR)+ ' Seconds';
        PRINT '--------------------------------------'

        SET @Start_time= GETDATE();
        PRINT '>> Truncating Table: Bronze.crm_sales_details';
        TRUNCATE TABLE Bronze.crm_sales_details

        PRINT '>> Inserting Data Into: Bronze.crm_sales_details';
        BULK INSERT Bronze.crm_sales_details
        FROM 'C:\sql\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH(
            FIRSTROW= 2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @End_time= GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second,@Start_time,@End_time) AS NVARCHAR)+ ' Seconds';
        PRINT '--------------------------------------'

        PRINT '----------------------------------------';
        PRINT 'Loading ERP tables'
        PRINT '----------------------------------------';

        SET @Start_time= GETDATE();
        PRINT '>> Truncating Table: Bronze.erp_cust_az12';
        TRUNCATE TABLE Bronze.erp_cust_az12

        PRINT '>> Inserting Data Into: Bronze.erp_cust_az12';
        BULK INSERT Bronze.erp_cust_az12
        FROM 'C:\sql\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH(
            FIRSTROW= 2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @End_time= GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second,@Start_time,@End_time) AS NVARCHAR)+ ' Seconds';
        PRINT '--------------------------------------'

        SET @Start_time= GETDATE();
        PRINT '>> Truncating Table: Bronze.erp_loc_a101';
        TRUNCATE TABLE Bronze.erp_loc_a101

        PRINT '>> Inserting Data Into: Bronze.erp_loc_a101';
        BULK INSERT Bronze.erp_loc_a101
        FROM 'C:\sql\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH(
            FIRSTROW= 2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @End_time= GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second,@Start_time,@End_time) AS NVARCHAR)+ ' Seconds';
        PRINT '--------------------------------------'

        SET @Start_time= GETDATE();
        PRINT '>> Truncating Table: Bronze.erp_px_cat_g1V2';
        TRUNCATE TABLE Bronze.erp_px_cat_g1V2

        PRINT '>> Inserting Data Into: Bronze.erp_px_cat_g1V2';
        BULK INSERT Bronze.erp_px_cat_g1V2
        FROM 'C:\sql\sql-data-warehouse-project\datasets\source_erp\px_cat_g1V2.csv'
        WITH(
            FIRSTROW= 2,
            FIELDTERMINATOR= ',',
            TABLOCK
        );
        SET @End_time= GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second,@Start_time,@End_time) AS NVARCHAR)+ ' Seconds';
        PRINT '--------------------------------------'
        SET @Batch_end_time= GETDATE();

        PRINT '========================================='
        PRINT 'LOADING BRONZE LAYER IS COMPLETED';
        PRINT 'Total load duration: ' + CAST(DATEDIFF(second,@Batch_start_time,@Batch_end_time) AS NVARCHAR)+ 'seconds';
        PRINT '========================================='
 END TRY
 BEGIN CATCH
     PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
     PRINT 'ERROR MESSAGE'+ error_message();
     PRINT 'ERROR MESAAGE'+ CAST(error_number() AS NVARCHAR);
     PRINT 'ERROR STATE'+ CAST(error_state() AS NVARCHAR);
 END CATCH 
END

