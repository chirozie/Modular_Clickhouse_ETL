from sqlalchemy import create_engine
import clickhouse_connect
from dotenv import load_dotenv
import os

load_dotenv(override=True)

def get_client():
    '''
    Connects to a clickhouse database using parameters from a .env file

    parameters: None

    Returns:
    - clickhouse_connect.Client: A database client object
    '''
    ## getting credentials
    host = os.getenv('ch_host')
    port = os.getenv('ch_port')
    user = os.getenv('ch_user')
    password = os.getenv('ch_password')

    ## connect to database
    client = clickhouse_connect.get_client(host=host, port=port, username=user, password=password, secure=True)

    return client


def get_postgres_engine():
    '''
    constructs a SQLalchemy engine object for postgres DB from .env file

    Parameters: None

    Returns:
    - sqlalchemy engine (sqlalchemy.engine.Engine)
    '''
    engine = create_engine("postgresql+psycopg2://{user}:{password}@{host}:{port}/{dbname}".format(
                           user = os.getenv('pg_user'),
                           password = os.getenv('pg_password'),  
                           host = os.getenv('pg_host'),
                           port =os.getenv('pg_port'),
                           dbname = os.getenv('pg_dbname')      
                                )
                        )
    
    return engine

