# AzureContainerRegistry利用手順

- 本文書はAzureContainerRegistry(ACR)利用手順についてまとめたもの

## 目次

- [AzureContainerRegistry利用手順](#azurecontainerregistry利用手順)
  - [目次](#目次)
  - [目的](#目的)
  - [手順](#手順)
    - [dockerイメージを作成](#dockerイメージを作成)
    - [azure操作](#azure操作)

## 目的

- AzureのApp Serviceに作成したアプリをデプロイする際にdocker imageをpushしてデプロイする方法について手順を記録する

## 手順

1. dockerイメージを作成
2. azure cliからazureにログイン
3. ACRに作成したimageをpush

### dockerイメージを作成

- flaskが動くアプリのdockerイメージファイルを作成

Dockerfile

```bash
FROM python:3.12.4-bullseye

WORKDIR /usr/src/python
COPY WebUI/requirements.txt ./
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

WORKDIR /usr/src
COPY WebUI/ ./

EXPOSE 8080 2222

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=8080"]
```

- 上記DockerfileとWebUIのフォルダが置かれたフォルダで以下を実行し、imageのビルドを行う

```bash
$ docker build . -t flask-web-app
```

- 作成したコンテナイメージの確認

```bash
docker run -d -p 8080:8080 flask-web-app
```

### azure操作

- (参考) https://qiita.com/weboshimashoten/items/da3713981679a6e92a29
- 詳細手順は上記リンクを参照するとして、実際行ったコマンドのみ記載

```bash
# azureへのログイン
$ az login --tenant {テナントID}
$ az account set --subscription {サブスクリプションID}

# dockerイメージのタグ付け
$ docker tag flask-web-app  {acrのリソース名}.azurecr.io/flask-web-app

# dockerイメージのpush
$ docker push {acrのリソース名}.azurecr.io/flask-web-app
```

上記手順でAppServiceにコンテナがpushされており、webアプリが動作していることを確認した。