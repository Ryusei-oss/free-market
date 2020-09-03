$(function(){
    $('#image-box').on('click', function(e){
      console.log('hoge');
      e.preventDefault()
    });



    
  });

// 商品説明文カウント
$(function(){
  $('.main__description-box').keyup(function(){
    var count = $(this).val().length;
    $('.main__description__counter-js').text(count);
  });
});

//販売価格手数料利益計算
$(function(){
  $('.main__price__selling__price__box-input').change(function(){
    var inputPrice = Number($(this).val());
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

// フォーム入力チェック
//商品名が未入力
$(function(){
  $('.main__name__product-box').blur(function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-name').text('入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-name').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});

//商品説明が未入力
$(function(){
  $('.main__description-box').blur(function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-text').text('入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-text').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});

//カテゴリーが未選択
$(function(){
  $('.main__detail__category-box').blur(function(){
    let value = $(this).val();
    if(value == ""){
      $('#error-category').text('選択してください');
      $(this).css('border-color','red');
    }else{
      $('#error-category').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});

// 商品の状態が未選択
$(function(){
  $('.main__detail__quality-box').blur(function(){
    let value = $('#product_quality_id').val();
    if(value == ""){
      $('#error-quality').text('選択してください');
      $(this).css('border-color','red');
    }else{
      $('#error-quality').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});

//配送料の負担が未選択
$(function(){
  $('.main__delivery__charge-box').blur(function(){
    let value = $('#product_shipping_charge_id').val();
    if(value == ""){
      $('#error-charge').text('選択してください');
      $(this).css('border-color','red');
    }else{
      $('#error-charge').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});

//配送元の地域が未選択
$(function(){
  $('.main__delivery__area-box').blur(function(){
    let value = $('#product_area_id').val();
    if(value == ""){
      $('#error-area').text('選択してください');
      $(this).css('border-color','red');
    }else{
      $('#error-area').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});

//配送までの日数が未選択
$(function(){
  $('.main__delivery__date-box').blur(function(){
    let value = $('#product_delivery_date_id').val();
    if(value == ""){
      $('#error-date').text('選択してください');
      $(this).css('border-color','red');
    }else{
      $('#error-date').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  });
});

// 価格入力で設定外の入力
$(function(){
  $('.main__price__selling__price__box-input').blur(function(){
    let value = $(this).val();
    if(value < 300 || value > 9999999){
      $('#error-price').text('300以上9999999以下で入力してください');
      $(this).css('border-color','red');
    }else{
      $('#error-date').text('');
      $(this).css('border-color','rgb(204, 204, 204)');
    }
  })
});

//カテゴリープルダウンの出しわけ
$(function(){
  function categoryOption(category){
    var optionHtml = `<option value="${category.id}">${category.name}</option>`;
    return optionHtml;
  }
  $('.main__detail__category-box').change(function(){
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
  $('.main__detail').on('change', '#children_category', function(){
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