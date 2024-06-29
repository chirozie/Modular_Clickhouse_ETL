import pandas as pd

#function to get data 
def fetch_data(client, query):
    '''
    fetches query results from a clickhouse database and writes to a csv file

    Parameters:
    - client(clikhouse_connect.Client)
    - query (A SQL select query)

    Returns: None
    '''

    #execute the query
    output = client.query(query)
    rows = output.result_rows
    cols = output.column_names

    #close the client
    client.close()
    
    #write to pandas df and csv file
    df = pd.DataFrame(rows, columns=cols)
    df.to_csv('tripdata.csv', index=False)

    print(f'{len(df)} rows successfully extracted')


