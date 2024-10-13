from dataclasses import dataclass
from database.select import select_list

@dataclass
class ProductInfoResponse:
    result: tuple
    error_massage: str
    status: bool


def model_route(db_config, user_input_data, sql_provider):
    error_massage = ''
    if 'prod_category' not in user_input_data or user_input_data['prod_category'] == "":
        print('user_input_data=', user_input_data)
        error_massage = 'Категория не найдена'
        result = ()
        return ProductInfoResponse(result, error_massage=error_massage, status=False)
    elif user_input_data['prod_category'].isdigit() == False:
        print('user_input_data=', user_input_data)
        error_massage = 'Категория должна быть натуральным числом'
        result = ()
        return ProductInfoResponse(result, error_massage=error_massage, status=False)
    _sql = sql_provider.get('product.sql', prod_category=user_input_data['prod_category'])
    print('_sql=', _sql)
    result, schema = select_list(db_config, _sql)
    if result == -1:    # если по данной категории ничего не найдено
        error_massage = f"Курсор не создан"
        return ProductInfoResponse(result, error_massage=error_massage, status=False)
    if len(result) == 0:    # если по данной категории ничего не найдено
        error_massage = f"данные по категории {user_input_data['prod_category']} не найдены"
        return ProductInfoResponse(result, error_massage=error_massage, status=False)
    print(result)
    print(schema)
    return ProductInfoResponse(result=result, error_massage=error_massage, status=True)