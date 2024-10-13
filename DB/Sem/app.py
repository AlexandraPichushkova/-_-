from flask import Flask, render_template


app = Flask(__name__)



@app.route('/')     #декоратор, задающий адрес для вызова функции
def hello():
    return ('Hello world from flask\n')

@app.route('/static')
def static_index():
    return render_template('static.html')

@app.route('/dynamic')
def dynamic_index():
    prod_title = 'Товары отдела мясо'
    product = [
        {'prod_name': 'говядина', 'prod_measure': 'кг', 'prod_price': 1000},
        {'prod_name': 'свинина', 'prod_measure': 'кг', 'prod_price': 920},
        {'prod_name': 'баранина', 'prod_measure': 'кг', 'prod_price': 1200}
    ]
    return render_template('dynamic.html', prod_title=prod_title, products=product)  ## что за аргументы?


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5001)
