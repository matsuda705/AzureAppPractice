import random


class Measure:
    '''
    各空調機器の制御状態を取得するクラス
    '''
    def __init__(self):
        """
        初期処理
        """

    def get_all_data(self) -> dict:
        """
        すべてのデータを取得して返す
        """
        all_data = []

        # エアコンの計測データを追加
        all_data.append(self.simulate_air_conditioner("A"))
        all_data.append(self.simulate_air_conditioner("B"))

        # 換気扇の計測データを追加
        all_data.append(self.simulate_fan())

        # 二酸化炭素測定機の計測データを追加
        all_data.append(self.simulate_co2_monitor())

        # 温湿度計の計測データを追加
        all_data.append(self.simulate_thermohygrometer("A"))
        all_data.append(self.simulate_thermohygrometer("B"))

        return all_data

    def simulate_air_conditioner(self, id) -> dict:
        """
        エアコン計測データのシミュレート
        """
        ret_data = {
            "name": f'air_conditioner_{id}',
            "temp": random.randint(0, 100),
            "mode": random.choice(["cool", "heat"])
        }

        return ret_data

    def simulate_fan(self) -> dict:
        """
        換気扇のシミュレート
        """
        ret_data = {
            "name": 'fan',
            "value": random.choice([True, False])
        }

        return ret_data

    def simulate_co2_monitor(self) -> dict:
        """
        二酸化炭素測定機のシミュレート
        """
        ret_data = {
            "name": 'co2_monitor',
            "value": random.randint(500, 1100)
        }

        return ret_data

    def simulate_thermohygrometer(self, id) -> dict:
        """
        温湿度計のシミュレート
        """
        ret_data = {
            "name": f'thermohygrometer_{id}',
            "temp": random.randint(0, 100),
            "humidity": random.randint(0, 100)
        }

        return ret_data
