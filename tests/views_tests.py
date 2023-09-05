import os
import pytest
from . import execute_sql_to_df
from . import read_sql

@pytest.fixture()
def select1_script():
    path = os.getenv("/home/alister/Desktop/DB/dundukovni-project/scripts/view1_select.sql")
    return read_sql(path)

@pytest.fixture()
def select2_script():
    path = os.getenv("/home/alister/Desktop/DB/dundukovni-project/scripts/view2_select.sql")
    return read_sql(path)

@pytest.fixture()
def select3_script():
    path = os.getenv("/home/alister/Desktop/DB/dundukovni-project/scripts/view3_select.sql")
    return read_sql(path)

@pytest.fixture()
def select4_script():
    path = os.getenv("/home/alister/Desktop/DB/dundukovni-project/scripts/view4_select.sql")
    return read_sql(path)

@pytest.fixture()
def select5_script():
    path = os.getenv("/home/alister/Desktop/DB/dundukovni-project/scripts/view5_select.sql")
    return read_sql(path)

@pytest.fixture()
def select6_script():
    path = os.getenv("/home/alister/Desktop/DB/dundukovni-project/scripts/view6_select.sql")
    return read_sql(path)


@pytest.fixture()
def select1_df(select1_script, sqlalchemy_conn):
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select1_script
    )

@pytest.fixture()
def select2_df(select2_script, sqlalchemy_conn):
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select2_script
    )

@pytest.fixture()
def select3_df(select3_script, sqlalchemy_conn):
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select3_script
    )

@pytest.fixture()
def select4_df(select4_script, sqlalchemy_conn):
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select4_script
    )

@pytest.fixture()
def select5_df(select5_script, sqlalchemy_conn):
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select5_script
    )

@pytest.fixture()
def select6_df(select6_script, sqlalchemy_conn):
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select6_script
    )


def test(select1_df):
    assert select1_df.query("hidden_firstname == 'Г***й'")['rating'].iloc[0] == 3.5

def test(select2_df):
    assert select2_df.query("hidden_firstname == 'Ф***р'")['rating'].iloc[0] == 4.6

def test(select3_df):
    assert select3_df.query("driver_surname == 'Данилов'")['client_surname'].iloc[0] == 'Смирнов'

def test(select4_df):
    assert select4_df.query("driver_firstname == 'Константин'")['car_number'].iloc[0] == 'Р509ОО'

def test(select5_df):
    assert select5_df.query("driver_firstname == 'Виктория'")['car_number'].iloc[0] == 'Е234РК'

def test(select6_df):
    assert select6_df.query("client_firstname == 'Ольга'")['cost'].iloc[0] == 1000