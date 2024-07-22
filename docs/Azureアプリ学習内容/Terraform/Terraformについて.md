# Terraformについて

- Azureのリソース情報を管理する方法としてTerraformを用いるときの手順や方法についてまとめたもの

## 目次

- [Terraformについて](#terraformについて)
  - [目次](#目次)
  - [参考](#参考)
  - [インストール](#インストール)
  - [TerraFormテンプレートの記載](#terraformテンプレートの記載)
  - [TerraFormコードの実行](#terraformコードの実行)

## 参考

- https://learn.microsoft.com/ja-jp/azure/app-service/provision-resource-terraform
- https://zenn.dev/yupon55/articles/d4d0c10634fb5d

## インストール

- ubuntuのコンテナ環境でのinstall方法

```bash
$ wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
$ echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ hashicorp.list
$ sudo apt update && sudo apt install terraform
```

## TerraFormテンプレートの記載

ディレクトリ構成

```bash
.
├── main.tf            # tfファイル全体の設定
├── variables.tf       # 変数をまとめたもの
├── random.tf          # 乱数
├── resource_groups.tf # リソースグループの設定
├── service_plans.tf   # サービスプラン(料金設定)
├── web_app.tf         # AppService(flaskウェブアプリ)の設定
├── function_app.tf    # Function App(API)の設定
└── source_control.tf  # ソースコントロール(デプロイ)の設定

```

Terraformの書き方については参考元を参照

## TerraFormコードの実行

```bash
# main.tfがあるディレクトリで実行
$ terraform init
$ terraform plan
$ terraform apply # 入力を求められたときに"yes"を入力
```
