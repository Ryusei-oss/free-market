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