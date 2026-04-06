import pandas as pd
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv

load_dotenv()


# Create Engine (Single Source)
def get_engine():
    return create_engine(
        f"mysql+pymysql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}/{os.getenv('DB_NAME')}"
    )


# Upload DataFrame
def upload_dataframe(df, table_name, if_exists='replace'):
    engine = get_engine()
    try:
        df.to_sql(name=table_name, con=engine, if_exists=if_exists, index=False)
        return f"Data uploaded successfully to {table_name}"
    except Exception as e:
        raise Exception(f"Upload failed: {e}")


# Read Query
def read_query(query):
    engine = get_engine()
    try:
        df = pd.read_sql(query, con=engine)
        return df
    except Exception as e:
        raise Exception(f"Query failed: {e}")


# Test block
if __name__ == "__main__":
    try:
        df = read_query("SELECT COUNT(*) AS total_rows FROM final_dataset")
        print(df)
    except Exception as e:
        print(e)