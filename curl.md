curlでhtmlの内容を取得する
普通にURLアクセスしてhttpのレスポンスした文字列を取得する方法です。APIに接続するときとかスクレイピングなんかの土台部分になるかと思います。

<?php
// gethtml.php
$base_url = 'https://www.google.co.jp/';
$curl = curl_init();

curl_setopt($curl, CURLOPT_URL, $base_url);
curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'GET');
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false); // 証明書の検証を行わない
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);  // curl_execの結果を文字列で返す

$response = curl_exec($curl);
curl_close($curl);

echo $response;
ブラウザーでこのPHPでアクセスするとアクセス先の内容がそのまま表示されると思います。phpからコマンドラインで叩くと普通に文字列だけ返ってきます。

ヘッダー、ステータスを取得する
httpのレスポンスヘッダーも取得したいときは、CURLOPT_HEADERで取得します。

<?php

$base_url = 'https://www.google.co.jp/';
$curl = curl_init();

curl_setopt($curl, CURLOPT_URL, $base_url);
curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'GET');
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false); // 証明書の検証を行わない
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);  // curl_execの結果を文字列で返す
curl_setopt($curl, CURLOPT_HEADER, true); //←こいつを追加

$response = curl_exec($curl);
curl_close($curl);

echo $response;
実行すると、

HTTP/1.1 200 OK
Date: Wed, 20 Jul 2016 01:17:27 GMT
Expires: -1
Cache-Control: private, max-age=0
Content-Type: text/html; charset=Shift_JIS
P3P: CP="This is not a P3P policy! See https://www.google.com/support/accounts/answer/151657?hl=en for more info."
Server: gws
X-XSS-Protection: 1; mode=block
X-Frame-Options: SAMEORIGIN
Set-Cookie: NID=82=cFm_B-eGmagQF2L9iXzvIvfbK08ggEenfCxfIeEDUT_nOXuxJ-AMo3iWBqssF7Jk-2BQnLdLkQSYaJBXLWqh53YymAEnMlqgpFyAA6QL-VGejKO-ZK4VKDRkgCje5lLv; expires=Thu, 19-Jan-2017 01:17:27 GMT; path=/; domain=.google.co.jp; HttpOnly
Alternate-Protocol: 443:quic
Alt-Svc: quic=":443"; ma=2592000; v="36,35,34,33,32,31,30,29,28,27,26,25"
Accept-Ranges: none
Vary: Accept-Encoding
Transfer-Encoding: chunked
....
こんな感じで普通にヘッダーが取得できます。

POSTする
これだと画像投稿とかに対応してませんが、文字列だけならいけます。

$base_url = 'http://example.com/';
$data = 'test1=aaa&test2=bbb';

$curl = curl_init();
curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_URL, $base_url);
$response = curl_exec($curl);
curl_close($curl);

echo $response;
