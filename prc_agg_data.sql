CREATE OR REPLACE PROCEDURE "STG".agg_tripdata(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	v_runtime TIMESTAMP;
	v_status TEXT;
	v_error_msg TEXT;
BEGIN
	v_runtime := NOW();
	v_status := 'SUCESSS';
	v_error_msg := NULL;
	
	INSERT INTO "EDW".daily_agg_tripdata
	SELECT cast(pickup_date as date),
		sum(passenger_count) tot_passenger_count,
		avg(passenger_count) avg_passenger_count,
		sum(trip_distance) tot_distance,
		avg(trip_distance) avg_distance,
		sum(fare_amount) tot_tfare,
		avg(fare_amount) avg_tfare,
		sum(tip_amount) tot_tip,
		avg(tip_amount) avg_tip
	from "STG".tripdata
	GROUP BY cast(pickup_date as date);
	
	INSERT INTO "EDW".daily_agg_tripdata_channel
	SELECT cast(pickup_date as date),
		payment_type,
		sum(passenger_count) tot_passenger_count,
		avg(passenger_count) avg_passenger_count,
		sum(trip_distance) tot_distance,
		avg(trip_distance) avg_distance,
		sum(fare_amount) tot_tfare,
		avg(fare_amount) avg_tfare,
		sum(tip_amount) tot_tip,
		avg(tip_amount) avg_tip
	from "STG".tripdata
	GROUP BY cast(pickup_date as date), payment_type;

	--log the outcome
	INSERT INTO "STG".procedure_logs(runtime, status, error_msg)
	VALUES (v_runtime, v_status, v_error_msg);

EXCEPTION
	WHEN OTHERS THEN
		v_status := 'FAILED';
		v_error_msg := SQLERRM;
		
		INSERT INTO "STG".procedure_logs(runtime, status, error_msg)
		VALUES (v_runtime, v_status, v_error_msg);
	
END;
$BODY$;
