$('li.video a').click(function(){
  Analytical.event('Click Video', {page: document.location.pathname, id: $(this).parent().attr('id'), url: this.href});
});
$('article.post header a').click(function(){
  Analytical.event('Follow Blog Link', {page: document.location.pathname, url: this.href});
});
