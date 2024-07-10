import json
import os
# import requests

from flask import Flask, render_template, jsonify

current_dir = os.path.dirname(os.path.abspath(__file__))
DUMMY_DATA_PATH = os.path.join(current_dir, "dummy/dummy_data.json")

app = Flask(__name__, static_folder="./statics")


@app.route('/')
def index():
    return render_template("index.html")


# @app.route('/get_current_data')
# def get_current_data():
#     response = requests.get(
#         "https://mk-flask-core-app.azurewebsites.net/get_current_data"
#     )

#     return jsonify(response.json())


@app.route('/get_dummy')
def get_dummy():
    data = _get_dummy_data()
    return jsonify(data)


def _get_dummy_data():
    """
    テスト用 ダミーのjsonデータを取得して返す
    """
    try:
        with open(DUMMY_DATA_PATH, 'r') as file:
            data = json.load(file)
        return data
    except Exception() as e:
        print(e)
        return []


if __name__ == '__main__':
    app.run()
