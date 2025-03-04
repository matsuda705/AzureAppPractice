# AzureAppPractice

## 目次

- [AzureAppPractice](#azureapppractice)
  - [目次](#目次)
  - [概要](#概要)
  - [リンク](#リンク)
  - [画面構成](#画面構成)
  - [core構成](#core構成)
  - [アプリ全体のシーケンス図](#アプリ全体のシーケンス図)
  - [ネットワーク構成図](#ネットワーク構成図)

## 概要

- 室内空調IoT管理のサンプルアプリ
  - 仮想のオフィスでの温湿度・CO2の状況のリアルタイム表示をする
  - [未実装]グラフでその値の履歴が見れる
  - [未実装]ウェブ画面から空調の稼働、換気のON/OFFを設定できる

## リンク

- https://mk-flask-web-app.azurewebsites.net/ : WebUI表示画面
- https://mk-flask-core-app.azurewebsites.net/get_current_data : 上記アプリのサーバーからのみアクセス可能

## 画面構成

- index： 仮想オフィスの温湿度・CO2状況をリアルタイムで表示
- [未実装]history: 各パラメータ項目の履歴をグラフで表示
- [未実装]setting: 空調の稼働、換気のON/OFFを設定

## core構成

- 仮想の空調機器情報を乱数で更新し、jsonファイルに保存
- flaskサーバーで/get_currentでAPIを受け付ける

## アプリ全体のシーケンス図

- webアプリとcoreアプリはAPIを通じて連携
- jsonファイルの内容を交換している

![シーケンス図](docs/images/app_sequence.png)

## ネットワーク構成図

![構成図_1](docs/images/構成図_1.png)