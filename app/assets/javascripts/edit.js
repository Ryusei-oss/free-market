// 商品説明文カウント引継ぎ
$(function(){
  $(document).ready(function(){
    var count = $('#product_explanation').val().length;
    $('.main__description__counter-js').text(count);
  });
});

// 販売手数料の引継ぎ
$(function(){
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
  $(document).ready(function(){
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
  })
});
// function categoryOption(category){
//   var optionHtml = `<option value="${category.id}">${category.name}</option>`;
//   return optionHtml;
// }