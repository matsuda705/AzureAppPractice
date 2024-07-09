import json
import os

from flask import Flask, jsonify

# CSVファイルのパス
current_dir = os.path.dirname(os.path.abspath(__file__))
current_data_path = os.path.join(
    current_dir, 'measure_value/current_value/current_data.json'
)

# flask設定
app = Flask(__name__, static_folder="./statics")


@app.route('/get_current_data')
def get_current_data():
    data = _get_current_data()
    return jsonify(data)


def _get_current_data() -> dict:
    """
    現在の測定データを取得
    """
    try:
        with open(current_data_path, 'r') as file:
            data = json.load(file)
        return data
    except Exception() as e:
        print(e)
        return []
