# Azureアプリ学習内容

## 目次

- [Azureアプリ学習内容](#azureアプリ学習内容)
  - [目次](#目次)
  - [参考リンク](#参考リンク)
  - [用いたサービスについて](#用いたサービスについて)
    - [devcontainer](#devcontainer)
    - [gitHub Actions](#github-actions)
    - [App Service](#app-service)

## 参考リンク

- [【 Azure App Service 】デプロイを GitHub Actions で行う方法](https://qiita.com/Futo_Horio/items/cd39976604692d6de001)
- [App Serviceの基本をまとめた](https://qiita.com/y__saito/items/44d06a0bcf703aadba55)
- [Visual Studio Code で Azure Web App の作成とデプロイをする](https://qiita.com/y__saito/items/9e4db7f6967bc4994350)

## 用いたサービスについて

- 用いたサービス
  - devcontainer(VSCodeの機能)
  - gitHub Actions
  - App Sevice
- 以下の項目で実行までに必要な手順を書く

### devcontainer

- ローカルでの仮想の開発環境として、dockerを使うときにdockerコンテナをVSCodeから楽に起動・管理する拡張機能
- 使用手順概要
  - Docker Desktopをインストール後
    - (参考)[Windows 11にDocker Desktopを入れる手順（令和5年最新版）](https://qiita.com/zembutsu/items/a98f6f25ef47c04893b3)
  - VSCodeの拡張機能であるdevcontainerを使ってコンテナを起動
    - (参考)[VSCode と devcontainer で始める開発環境構築](https://qiita.com/haruhikonyan/items/291e1e5413a827fc6d9a)
- 今回はPythonのFlaskアプリを使ったので、公式で用意されているpython3.12の環境を使用

devcontainer.json(拡張機能から自動作成されたものを変更)

```json
{
  // コンテナ名
	"name": "Python 3",
	// イメージ名
	"image": "mcr.microsoft.com/devcontainers/python:1-3.12-bullseye",

	// コンテナ起動時に行うコマンド、pythonライブラリのインストールを行う
	"postCreateCommand": "pip3 install --user -r requirements.txt"
}

```

### gitHub Actions

- Azure Web Appにコードをデプロイする手段の一つ
- GitHubとAzure Serviceを連携させて、GitHubにアップしたブランチのコードをAzure Web Appにそのままデプロイする機能
- 詳細手順は下記参考リンクが詳しいため参照
  - [【 Azure App Service 】デプロイを GitHub Actions で行う方法](https://qiita.com/Futo_Horio/items/cd39976604692d6de001)
- 今回はGitHub上でブランチを分けて別のアプリを実装しており、それぞれのブランチに対してGitHubActionを設定している

GitHub Actions ワークフロー設定ファイル(.gitHub/workflow/(ブランチ名)_(App Serviceの名前).yml に自動生成される)

```yml
# Docs for the Azure Web Apps Deploy action: https://github.com/Azure/webapps-deploy
# More GitHub Actions for Azure: https://github.com/Azure/actions
# More info on Python, GitHub Actions, and Azure App Service: https://aka.ms/python-webapps-actions

name: Build and deploy Python app to Azure Web App - mk-flask-web-app

on:
  push:
    branches:
      - dev-webui
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

  # (略)

  deploy:
    runs-on: ubuntu-latest
    needs: build
    # (略)
      - name: 'Deploy to Azure Web App'
        uses: azure/webapps-deploy@v2
        id: deploy-to-webapp
        with:
          app-name: 'mk-flask-web-app'
          slot-name: 'Production'
          publish-profile: ${{ secrets.AZUREAPPSERVICE_PUBLISHPROFILE_04E3F2B0AA9B4D1988C565DF04F7AA1D }}
          package: './WebUI' # flask実行コード(app.py)を配置しているディレクトリ名
```

### App Service

- githubからのデプロイ完了後、AppServiceの機能でflaskサーバーが自動起動する
