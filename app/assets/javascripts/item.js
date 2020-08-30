window.addEventListener('load', function(){
  console.log("addEventListner");
  let btn = $(".header2__under--catBtn");
  btn.click(function(){
    console.log("category clicked");
    $(this).addClass("box_exa"); });
  
  $(function(){
    $('.dropdwn li').hover(function(){
        $("ul:not(:animated)", this).slideDown();
    }, function(){
        $("ul.dropdwn_menu",this).slideUp();
    });
  });
});

