import json
import os
import requests

from flask import Flask, render_template, jsonify

current_dir = os.path.dirname(os.path.abspath(__file__))
DUMMY_DATA_PATH = os.path.join(current_dir, "dummy/dummy_data.json")
# CORE_API_KEY = os.environ["FUNCTION_APP_API_KEY"]
# FUNCTION_APP_NAME = os.environ["FUNCTION_APP_NAME"]
# CORE_API_URL = f"https://{FUNCTION_APP_NAME}.azurewebsites.net/api/get_current_data?code={CORE_API_KEY}"

# 空調機器の名前
machine_name_data = {
    "aircon_a": "エアコンA",
    "aircon_b": "エアコンB",
    "fan": "換気扇",
    "co2_measure": "CO2濃度計",
    "thermo_a": "温湿度計A",
    "thermo_b": "温湿度計B"
}

app = Flask(__name__, static_folder="./statics")


@app.route('/')
def index():
    return render_template("index.html")


@app.route('/history/<name>')
def history(name):
    return render_template(
        'history.html',
        machine_name=machine_name_data[name]
    )


@app.route('/setting')
def setting():
    return render_template("setting.html")


@app.route('/get_current_data')
def get_current_data():
    try:
        # url = CORE_API_URL
        url = '/get_dummy'
        response = requests.get(
            url
        )

        return jsonify(response.json())
    except Exception as e:
        # エラーが発生した場合にエラーメッセージとステータスコードを返す
        return jsonify(error=str(e)), 500


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
