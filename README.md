# AzureAppPractice

## 目次

- [AzureAppPractice](#azureapppractice)
  - [目次](#目次)
  - [概要](#概要)
  - [画面構成](#画面構成)
  - [制御側](#制御側)

## 概要

- 空調管理のサンプルアプリ
- 仮想のオフィスでの温湿度・CO2の状況のリアルタイム表示、グラフでその履歴が見れるようなアプリ
- ウェブ画面から空調の稼働、換気のON/OFFを設定できる

## 画面構成

- index： 仮想オフィスの温湿度・CO2状況をリアルタイムで表示
- history: 各パラメータ項目の履歴をグラフで表示
- setting: 空調の稼働、換気のON/OFFを設定

## 制御側

- 仮想の空調機器達から与えられた値を毎秒記録する
  - このアプリでは実際に機器とつなぐわけではないので、機器の値は時刻に応じた架空の値を出力する。
- 仮想の空調機器から与えられた値は現在値として記録しindexの画面に表示、またcsv形式で一分間隔で記録し、１週間分のデータを保持して、history画面の表示に用いる