import json
import time

from services.measure import Measure

# CSVファイルのパス
current_data_path = 'measure_value/current_value/current_data.json'


def _update_json(file_path, data) -> bool:
    """
    jsonファイルを更新する
    """
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=4)


def main() -> None:
    measure = Measure()

    try:
        while True:
            latest_data = measure.get_all_data()
            _update_json(current_data_path, latest_data)

            time.sleep(10)
    except Exception() as e:
        print(e)


if __name__ == "__main__":
    main()
