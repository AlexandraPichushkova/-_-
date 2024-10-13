import json, os
from flask import Flask, render_template, Blueprint, current_app, request
from database.select import select_list, select_dict
from database.sql_provider import SQLProvider
from model_route import model_route

app = Flask(__name__)

# f = open('../data/db_config.json')   # .. - на 2 директории выше
# db_config = f.read()
# print(db_config)
# f.close()

with open('../data/db_config.json') as f:    # автоматическое удаление объектов
    app.config['db_config'] = json.load(f)    # добавили db_config в глобальный словарь - можно обратиться ото всюду из проекта
    #print(db_config)


provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))    # соединяем путь к текущей дериктории и sql шаблон
# for key, value in provider.scripts.items():
#     v = provider.scripts[key]
#     print(key, ':', v)



# @app.route('/', methods =['GET', 'POST'])  # по умолч принимает только гет
# def product_index():
#     #prod_category = 1
#     if request.method == 'GET':
#         return render_template('input_category.html')
#     else:
#         print(f"Received form data: {request.form}")
#         prod_category = request.form.get('prod_category')  #в составе объекта реквест словарь форм метод гет ключ прод_категори=1
#         print(prod_category)
#         _sql = provider.get('product.sql', prod_category=prod_category)    #Получает SQL-запрос из объекта provider, подст знач. prod_category
#         products = select_dict(app.config['db_config'], _sql)
#         if products:
#             prod_title = 'Результат из БД'
#             return render_template('dynamic.html', prod_title=prod_title, products=products)  # 1-из динамик, 2 - из этой фукции
#       #  return 'Все хорошо'
#         else:
#            return 'Результат не получен'


@app.route('/', methods=['GET'])
def product_handle():
    return render_template('input_category.html')

@app.route('/', methods=['POST'])
def product_result_handle():
    user_input_data = request.form      #Получает данные, отправленные через POST-запрос
    user_info_result = model_route(app.config['db_config'], user_input_data, provider)     #### содержит result error_mas status
    if user_info_result.status:
        products = user_info_result.result
        prod_title = 'Результаты из БД'
        return render_template('dynamic.html', prod_title=prod_title, products=products)
    else:
        #return 'Что-то пошло не так'
        return f"Что-то пошло не так! Ошибка: {user_info_result.error_massage}"

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5001)