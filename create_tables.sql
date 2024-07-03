   -- Ensure the log table exists
    CREATE TABLE IF NOT EXISTS "STG".procedure_log (
        run_time TIMESTAMP NOT NULL,
        status TEXT,
        error_message TEXT
    );

    -- Create tables if they do not exist
    CREATE TABLE IF NOT EXISTS "EDW".daily_agg_trip_data(
        pickup_date date PRIMARY KEY NOT NULL,
        tot_passenger_count int,
        avg_passenger_count int,
        tot_distance float,
        avg_distance float,
        tot_fare float,
        avg_fare float,
        total_tip float,
        avg_tip float
    );

    CREATE TABLE IF NOT EXISTS "EDW".vendor_daily_agg_trip_data(
        pickup_date date NOT NULL,
        vendor text,
        tot_passenger_count int,
        avg_passenger_count int,
        tot_distance float,
        avg_distance float,
        tot_fare float,
        avg_fare float,
        total_tip float,
        avg_tip float,
        PRIMARY KEY (pickup_date, vendor)
    );

    CREATE TABLE IF NOT EXISTS "EDW".channel_daily_agg_trip_data(
        pickup_date date NOT NULL,
        payment_type text,
        tot_passenger_count int,
        avg_passenger_count int,
        tot_distance float,
        avg_distance float,
        tot_fare float,
        avg_fare float,
        total_tip float,
        avg_tip float,
        PRIMARY KEY (pickup_date, payment_type)
    );