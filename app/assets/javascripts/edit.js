// 商品説明文カウント引継ぎ
$(document).ready(function(){
  var count = $('#product_explanation').val().length;
  $('.main__description__counter-js').text(count);
});

// 販売手数料の引継ぎ
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