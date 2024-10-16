import json
from flask import Flask, render_template
from database.select import select_list, select_dict

app = Flask(__name__)

# f = open('../data/db_config.json')   # .. - на 2 директории выше
# db_config = f.read()
# print(db_config)
# f.close()

with open('../data/db_config.json') as f:    # автоматическое удаление объектов
    app.config['db_config'] = json.load(f)    # добавили db_config в глобальный словарь - можно обратиться ото всюду из проетка
  #  print(db_config)

@app.route('/')
def product_index():
    prod_category = 1
    _sql = f"""select prod_name, prod_measure, prod_price from product
            where prod_category = {prod_category}"""                         #""" - для разбиения запроса на несколько строк
    products = select_dict(app.config['db_config'], _sql)
    if products:
        prod_title = 'Результат из БД'
        return render_template('dynamic.html', prod_title=prod_title, products = products)  # 1-из динамик, 2 - из этой фукции
      #  return 'Все хорошо'
    else:
        return 'Результат не получен'

if __name__ == '__main__':
    app.run(host = '127.0.0.1', port = 5001)