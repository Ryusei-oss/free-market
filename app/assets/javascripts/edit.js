$(document).on('turbolinks:load', function(){
  $(function(){

    function buildHTML(count) {
      var html = `<div class="preview-box" id="preview-box__${count}">
                    <div class="upper-box">
                      <img src="" alt="preview">
                    </div>
                    <div class="lower-box">
                      <div class="update-box">
                        <label class="edit_btn"></label>
                      </div>
                      <div class="delete-box" id="delete_btn_${count}">
                        <span>削除</span>
                      </div>
                    </div>
                  </div>`
      return html;
    }

    // 編集
    if (window.location.href.match(/\/products\/\d+\/edit/)){
      //登録済み画像のプレビュー表示欄の要素を取得する
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
      //プレビューにidを追加
      $('.preview-box').each(function(index, box){
        $(box).attr('id', `preview-box__${index}`);
      })
      //削除ボタンにidを追加
      $('.delete-box').each(function(index, box){
        $(box).attr('id', `delete_btn_${index}`);
      })
      var count = $('.preview-box').length;
      //プレビューが5あるときは、投稿ボックスを消しておく
      if (count == 5) {
        $('.label-content').hide();
      }
    }

    function setLabel() {
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
    }

    $(document).on('change', '.hidden-field', function() {
      setLabel();
      //hidden-fieldのidの数値のみ取得
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //labelボックスのidとforを更新
      $('.label-box').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_image`});
      //選択したfileのオブジェクトを取得
      var file = this.files[0];
      var reader = new FileReader();
      //readAsDataURLで指定したFileオブジェクトを読み込む
      reader.readAsDataURL(file);
      //読み込み時に発火するイベント
      reader.onload = function() {
        var image = this.result;
        //プレビューが元々なかった場合はhtmlを追加
        if ($(`#preview-box__${id}`).length == 0) {
          var count = $('.preview-box').length;
          var html = buildHTML(id);
          //ラベルの直前のプレビュー群にプレビューを追加
          var prevContent = $('.label-content').prev();
          $(prevContent).append(html);
        }
        //イメージを追加
        $(`#preview-box__${id} img`).attr('src', `${image}`);
        var count = $('.preview-box').length;
        //プレビューが5個あったらラベルを隠す 
        if (count == 5) { 
          $('.label-content').hide();
        }

        if ($(`#product_images_attributes_${id}__destroy`)){
          $(`#product_images_attributes_${id}__destroy`).prop('checked',false);
        } 

        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        if(count < 5){
          //プレビューの数でラベルのオプションを更新する
          $('.label-box').attr({id: `label-box--${count}`,for: `product_images_attributes_${count}_image`});
        }
      }
    });
    // 画像の削除
    $(document).on('click', '.delete-box', function() {
      var count = $('.preview-box').length;
      setLabel(count);
      //item_images_attributes_${id}_image から${id}に入った数字のみを抽出
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //取得したidに該当するプレビューを削除
      $(`#preview-box__${id}`).remove();
       //削除用チェックボックスの有無で判定
      if ($(`#product_images_attributes_${id}__destroy`).length == 0) {
        //フォームの中身を削除 
        $(`#product_images_attributes_${id}_image`).val("");
        var count = $('.preview-box').length;
        //5個めが消されたらラベルを表示
        if (count == 4) {
          $('.label-content').show();
        }
        setLabel(count);
        if(id < 5){
          $('.label-box').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_image`});
        }
      } else {
        //投稿編集時
        $(`#product_images_attributes_${id}__destroy`).prop('checked',true);
        //5個めが消されたらラベルを表示
        if (count == 4) {
          $('.label-content').show();
        }
        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        //削除したプレビューのidによって、ラベルのidを変更する
        if(id < 5){
          $('.label-box').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_image`});
        }
      }
    });
  });
});




// 商品説明文カウント引継ぎ
$(document).on('turbolinks:load', function(){
  var count = $('#product_explanation').val().length;
  $('.main__description__counter-js').text(count);
});

// 販売手数料の引継ぎ
$(document).on('turbolinks:load', function(){
  $(document).ready(function(){
    var inputPrice = Number($('#product_price').val());
    if(inputPrice >= 300 && inputPrice < 10000000){
      var fee = Math.floor(inputPrice * 0.1);
      var profit = inputPrice - fee;
      $('.fee_value').text("¥" + fee.toLocaleString()),
      $('.profit_value').text("¥" + profit.toLocaleString())
    }else{
      $('.fee_value').text("ー");
      $('.profit_value').text("ー");
    }
  });
});

//カテゴリープルダウンの出しわけ
$(function(){
  function categoryOption(category){
    var optionHtml = `<option value="${category.id}">${category.name}</option>`;
    return optionHtml;
  }
  $(document).on('change', '.main__detail__category-box', function(){
    let parentCategoryId = $(this).val();
    if(parentCategoryId == ''){
      $('.main__detail__category-children').remove();
      $('.main__detail__category-grandchildren').remove();
    }else{
      $.ajax({
        url: 'category_children',
        type: 'GET',
        data: { parent_id: parentCategoryId },
        dataType: 'json'
      })
      .done(function(category_children){
        $('.main__detail__category-children').remove();
        $('.main__detail__category-grandchildren').remove();
        let optionHtml = '';
        category_children.forEach(function(child){
          optionHtml += categoryOption(child);
        });
        $('#error-category').before(`<div class="main__detail__category-space">
                                        <select class="main__detail__category-children" id="children_category" "name="product[category_id]" required="required">
                                          <option value="">選択してください</option>
                                          ${optionHtml}
                                        </select>
                                      </div>`
        );
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      });
    }
  });
  $(document).on('change', '.main__detail__category-children', function(){
    let childrenCategoryId = $(this).val();
    if(childrenCategoryId == ''){
      $('.main__detail__category-grandchildren').remove();
    }else{
      $.ajax({
        url: 'category_grandchildren',
        type: 'GET',
        data: { child_id: childrenCategoryId },
        dataType: 'json'
      })
      .done(function(category_grandchildren){
        $('.main__detail__category-grandchildren').remove();
        let optionHtml = '';
        category_grandchildren.forEach(function(grandchildren){
          optionHtml += categoryOption(grandchildren);
        });
        $('#error-category').before(`<div class="main__detail__category-space">
                                        <select class="main__detail__category-grandchildren" id="grandchildren_category" name="product[category_id]" required="required">
                                          <option value="">選択してください</option>
                                          ${optionHtml}
                                        </select>
                                      </div>`
        );
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      });
    }
  });
});