## importing custom functions
from helpers import get_client, get_postgres_engine
from extract import fetch_data
from load import load_csv_to_postgres
from sqlalchemy.orm import sessionmaker
from sqlalchemy import text
from datetime import datetime, timedelta


client = get_client()
engine = get_postgres_engine()

### modification to get max_date from staging table (last loaded date)
Session = sessionmaker(bind=engine)
session = Session()
result = session.execute(text('select max(pickup_date) from "STG".tripdata'))
max_date = result.fetchone()[0]
session.close()

### getting the new date
new_date = (datetime.strptime(max_date, '%Y-%m-%d') + timedelta(days=1)).date()

query = f'''
        select pickup_date, vendor_id, passenger_count, trip_distance, payment_type, fare_amount, tip_amount 
        from tripdata
        where pickup_date = toDate('{max_date}') + 1
        '''


def main():
    '''
    Main function to run the data pipeline modules
    1. ------
    2. -----

    Paramters: None

    Returns: None
    '''

    #extract the data
    fetch_data(client=client, query=query)

    #load the data
    load_csv_to_postgres('tripdata.csv', 'tripdata', engine, 'STG')

    ## execute stored procedure
    Session = sessionmaker(bind=engine)
    session = Session()
    session.execute(text('CALL "STG".agg_tripdata()'))
    session.commit()

    print('Stored procedure executed')

    print(f'pipeline executed successfully for {new_date}')


if __name__ == '__main__':
    main()