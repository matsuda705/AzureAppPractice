# API_keyについて

- フロントアプリでAPI keyを保持せずに受け渡す方法についてまとめる

## 目次

- [API\_keyについて](#api_keyについて)
  - [目次](#目次)
  - [概要](#概要)
  - [方法](#方法)
    - [App Serviceの環境変数にAPIキーを保存](#app-serviceの環境変数にapiキーを保存)
    - [KeyVaultでAPIキーを管理する](#keyvaultでapiキーを管理する)
- [API\_keyについて](#api_keyについて-1)
  - [目次](#目次-1)
  - [概要](#概要-1)
  - [方法](#方法-1)
    - [App Serviceの環境変数にAPIキーを保存](#app-serviceの環境変数にapiキーを保存-1)
    - [KeyVaultでAPIキーを管理する](#keyvaultでapiキーを管理する-1)

## 概要

- 現在実装したアプリでは、APIのkeyを直接記載している
- セキュリティ上好ましくないため、別の方法でAPIキーを保管する方法についてまとめる

現在のコード

```py
@app.route('/get_current_data')
def get_current_data():
    api_key = "JVjsDSgHReooM0RZ1U6STsmrQIwIPDoAv4ByC4L-vAXyAzFu6MvXDQ%3D%3D"  # ★実際のAPIキー
    url = f"https://jbsmkfunctionapp.azurewebsites.net/api/get_current_data?code={api_key}"
    response = requests.get(
        url
    )

    return jsonify(response.json())
```

## 方法

- App Serviceの環境変数にAPIキーを保存する
- KeyVaultでAPIキーを管理する


### App Serviceの環境変数にAPIキーを保存

- pythonでの場合
- 参考 https://note.com/minaul/n/nfe6b852b13d1

1. Azure Portalより環境変数を設定
![](image-1.png)
2. pythonの標準ライブラリの機能`os.environ`から取得できることを確認。下記画像は環境変数を設定したApp ServiceのSSH上で実行したpythonコード。
![](image-3.png)

環境変数`DUMMY_ENV_KEY`を取得する場合のpythonコード

```py
import os

print(os.environ["DUMMY_ENV_KEY"])  # 出力: "dummy_env_key" (設定した環境変数の値)
```

### KeyVaultでAPIキーを管理する

(参考)KeyVaultの概要 https://learn.microsoft.com/ja-jp/azure/key-vault/general/overview
(参考)Key Vault を活用した API キーの保護 https://zenn.dev/microsoft/articles/f0cf3272e3d3eb

- 手順
  - KeyVaultにAPIキーを保存
  - 認証を受けたアクセスに対してのみAPIキーを渡す

(引用したネット構成図)

# API_keyについて

- フロントアプリでAPI keyを保持せずに受け渡す方法についてまとめる

## 目次

- [API\_keyについて](#api_keyについて)
  - [目次](#目次)
  - [概要](#概要)
  - [方法](#方法)
    - [App Serviceの環境変数にAPIキーを保存](#app-serviceの環境変数にapiキーを保存)
    - [KeyVaultでAPIキーを管理する](#keyvaultでapiキーを管理する)
- [API\_keyについて](#api_keyについて-1)
  - [目次](#目次-1)
  - [概要](#概要-1)
  - [方法](#方法-1)
    - [App Serviceの環境変数にAPIキーを保存](#app-serviceの環境変数にapiキーを保存-1)
    - [KeyVaultでAPIキーを管理する](#keyvaultでapiキーを管理する-1)

## 概要

- 現在実装したアプリでは、APIのkeyを直接記載している
- セキュリティ上好ましくないため、別の方法でAPIキーを保管する方法についてまとめる

現在のコード

```py
@app.route('/get_current_data')
def get_current_data():
    api_key = "JVjsDSgHReooM0RZ1U6STsmrQIwIPDoAv4ByC4L-vAXyAzFu6MvXDQ%3D%3D"  # ★実際のAPIキー
    url = f"https://jbsmkfunctionapp.azurewebsites.net/api/get_current_data?code={api_key}"
    response = requests.get(
        url
    )

    return jsonify(response.json())
```

## 方法

- App Serviceの環境変数にAPIキーを保存する
- KeyVaultでAPIキーを管理する


### App Serviceの環境変数にAPIキーを保存

- pythonでの場合
- 参考 https://note.com/minaul/n/nfe6b852b13d1

1. Azure Portalより環境変数を設定
![](image-1.png)
2. pythonの標準ライブラリの機能`os.environ`から取得できることを確認。下記画像は環境変数を設定したApp ServiceのSSH上で実行したpythonコード。
![](image-3.png)

環境変数`DUMMY_ENV_KEY`を取得する場合のpythonコード

```py
import os

print(os.environ["DUMMY_ENV_KEY"])  # 出力: "dummy_env_key" (設定した環境変数の値)
```

### KeyVaultでAPIキーを管理する

(参考)KeyVaultの概要 https://learn.microsoft.com/ja-jp/azure/key-vault/general/overview
(参考)Key Vault を活用した API キーの保護 https://zenn.dev/microsoft/articles/f0cf3272e3d3eb

- 手順
  - KeyVaultにAPIキーを保存
  - 認証を受けたアクセスに対してのみAPIキーを渡す

参考のネット構成図([引用](https://zenn.dev/microsoft/articles/f0cf3272e3d3eb))

![alt text](image.png)