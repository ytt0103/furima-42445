// payjp.js（このファイル）を読み込む関数を定義
const pay = () => {
  // gonを使ってコントローラーから渡された公開鍵を取得
  const publicKey = gon.payjp_public_key;

  // PAY.JPの初期化
  const payjp = Payjp(publicKey); // PAY.JPライブラリを初期化

  // elementsインスタンス（入力フォームを生成するもの）を作成
  const elements = payjp.elements();

  // カード番号入力欄のelementを作成
  const numberElement = elements.create('cardNumber');
  // 有効期限入力欄のelementを作成
  const expiryElement = elements.create('cardExpiry');
  // CVC入力欄のelementを作成
  const cvcElement = elements.create('cardCvc');

  // HTML側のIDに合わせて、マウントする場所を修正します
  // （id="number" → id="number-form" など）
  numberElement.mount('#number-form'); // カード番号
  expiryElement.mount('#expiry-form'); // 有効期限 ※月と年が一体型なので、これでOK
  // expiryElement.mount('#exp_year'); // ← この行は不要なので削除
  cvcElement.mount('#cvc-form'); // CVC

  // 購入ボタン（id="button"）がクリックされたときの処理
  const form = document.getElementById('charge-form'); // フォーム全体を取得
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // Railsのフォーム送信処理をいったん停止

    // PAY.JPにカード情報を送信してトークンを作成
    payjp.createToken(numberElement).then(function(response) {
      if (response.error) {
        // トークン作成失敗時
        alert(response.error.message);
        // 購入ボタンを再度押せるようにする
        form.querySelector('input[type="submit"]').disabled = false;
      } else {
        // トークン作成成功時
        const token = response.id; // トークンを取得

        // フォームにトークン情報を埋め込む
        const tokenInput = document.createElement("input");
        tokenInput.setAttribute("type", "hidden"); // 見えないようにする
        tokenInput.setAttribute("name", "order_address[token]"); // パラメーター名を "order_address[token]" にする
        tokenInput.setAttribute("value", token); // トークンの値を設定
        form.appendChild(tokenInput); // フォームに追加

        // カード情報をフォームから削除する（サーバーに送信しないため）
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();

        // フォームの送信処理を再開
        form.submit();
      }
    });
  });
};

// ページが読み込まれたとき、またはTurboが動いたときに `pay` 関数を実行
window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);