$(function () {

  // パブリックキーを書いてpayjpと通信できる状態にする
  Payjp.setPublicKey('pk_test_c5793331e39a6960b2f6a476');
  // 投稿ボタンを定義
  const card_btn = $('#add-card-btn');

  if (card_btn != null) {
    // 投稿ボタンが押されたら発火
    card_btn.click(function (e) {
      e.preventDefault();
      $(function () {
        // カードの情報を定数cardに代入。
        const card = {
          number: $('#card-num-input').val(),
          exp_month: $('#month-select').val(),
          exp_year: $('#year-select').val(),
          cvc: $('#security-code-input').val(),
        }
        form = $("#chargeForm")
        // この記述でtokenを呼び出してます。
        Payjp.createToken(card, function (status, response) {
          if (status === 200) {  //成功した場合。statusが200だと通信成功らしいです。
            // inputをappendしています valueは生成したデータで。
            form.append($('<input name="payjp_token" type="hidden">').val(response.id));
            // これでcreateアクションが呼ばれます。
            form.submit();
            // これが出たらカード情報が登録されます
            alert("カード情報を登録しました");
          } else {
            // カード情報が正しくないor入力漏れがあるとこちらが表示されます
            alert("正しいカード情報を入力してください");
          }
        })
      });
    });
  }

  // 正しく購入できた時のアラート
  $(".payjp-button").on(function(){
    alert("購入ができました");
  });
    
  

});