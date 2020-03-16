$(function(){ 
  function buildHTML(message){
   if ( message.image ) {
     var html =
      `<div class="chat_messages__group">
        <div class="chat_messages__group__gatmessage">
          <div class="chat_messages__group__gatmessage__username">
            ${message.user_name}
          </div>
          <div class="chat_messages__group__gatmessage__date">
            ${message.created_at}
          </div>
        </div>
        <div class="chat_messages__group__gatmessage__message">
          <p class="chat_messages__group__gatmessage__message__content">
            ${message.text}
          </p>
        </div>
        <img class="chat_messages__group__gatmessage__message__image" src=${message.image} >
        </div>
      </div>`
     return html;
   } else {
     var html =
      `<div class="chat_messages__group">
        <div class="chat_messages__group__gatmessage">
          <div class="chat_messages__group__gatmessage__username">
            ${message.user_name}
          </div>
          <div class="chat_messages__group__gatmessage__date">
            ${message.created_at}
          </div>
        </div>
        <div class="chat_messages__group__gatmessage__message">
          <p class="chat_messages__group__gatmessage__message__content">
            ${message.text}
          </p>
        </div>
      </div>`
     return html;
   };
 }

$('#new_message').on('submit', function(e){
 e.preventDefault();
 var formData = new FormData(this);
 var url = $(this).attr('action')
 $.ajax({
   url: url,
   type: "POST",
   data: formData,
   dataType: 'json',
   processData: false,
   contentType: false
 })
  .done(function(data){
    var html = buildHTML(data);
    $('.chat_messages').append(html);
    $('form')[0].reset();
    $('.message-box__btn').prop("disabled", false);
    $('.chat_messages').animate({ scrollTop: $('.chat_messages')[0].scrollHeight});
  })
  .fail(function() {
    alert("メッセージ送信に失敗しました");
    $('.message-box__btn').prop("disabled", false);
});
})
});
