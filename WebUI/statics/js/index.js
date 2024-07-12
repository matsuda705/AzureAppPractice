$(document).ready(function() {

    function updateAirconCard($card_unit, unit_data) {
        // エアコンカード部分の更新
        $status_val = $card_unit.find(".status-val");
        $card_unit.find(".set-temp").text(unit_data["temp"] + " ℃");

        $status_val.removeClass('heater');
        $status_val.removeClass('cooler');
        if (unit_data["mode"] === "heat") {
            $status_val.text("暖房");
            $status_val.addClass('heater');
        } else {
            $status_val.text("冷房");
            $status_val.addClass('cooler');
        }
    }

    function updateFanCard($card_unit, unit_data) {
        // 換気扇カード部分の更新
        $status_bool = $card_unit.find(".status-bool")
        $status_bool.removeClass('high-alert');
        $status_bool.removeClass('low-alert');
        if (unit_data["value"] === true) {
            $status_bool.text("ON")
            $status_bool.addClass('high-alert');
        } else {
            $status_bool.text("OFF")
            $status_bool.addClass('low-alert');
        }
    }

    function updateCO2Card($card_unit, unit_data) {
        // Co2濃度計カード部分の更新
        $co2_val = $card_unit.find(".co2-val")
        $co2_val.text(unit_data["value"] + " ppm")

        $co2_val.removeClass('high-alert');
        if (unit_data["value"] >= 1000) {
            $co2_val.addClass('high-alert');
        }
    }

    function updateThermoHygroCard($card_unit, unit_data) {
        // 温湿度計カード部分の更新
        $card_unit.find(".get-temp").text(unit_data["temp"] + " ℃");
        $card_unit.find(".get-humidity").text(unit_data["humidity"] + " %");
    }

    function fetchApiData() {
        $.ajax({
            // /get_dummyはテスト用API
            // url: '/get_dummy',
            url: '/get_current_data',
            type: 'GET',
            success: function(data) {
                data.forEach(unit_data => {
                    unit_id = unit_data["name"];
                    $card_unit = $("#" + unit_id);
                    

                    if (unit_id.includes("air_conditioner")) {
                        updateAirconCard($card_unit, unit_data);
                    }

                    if (unit_id.includes("fan")) {
                        updateFanCard($card_unit, unit_data);
                    }

                    if (unit_id.includes("co2_monitor")) {
                        updateCO2Card($card_unit, unit_data);
                    }

                    if (unit_id.includes("thermohygrometer")) {
                        updateThermoHygroCard($card_unit, unit_data);
                    }
                });
            },
            error: function(error) {
                console.log('API呼び出し中にエラーが発生しました:', error);
            }
        });
    }

    fetchApiData()
    // 1000ミリ秒（1秒）ごとにfetchApiData関数を実行
    setInterval(fetchApiData, 5000);

    $("#index_navbar").addClass('active');
});