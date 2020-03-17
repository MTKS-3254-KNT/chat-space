$(function (){ 
  function buildHTML(message) {
    if (message.text && message.image) {
      var html =
      `<div class="chat_messages__group" data-message-id="${message.id}">
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
        <img src=${message.image} class="chat_messages__group__gatmessage__message__image">
        </div>
      </div>`
    } else if (message.text) {
     var html =
      `<div class="chat_messages__group" data-message-id="${message.id}">
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
    } else if (message.image) {
      var html =
      `<div class="chat_messages__group" data-message-id="${message.id}">
        <div class="chat_messages__group__gatmessage">
          <div class="chat_messages__group__gatmessage__username">
            ${message.user_name}
          </div>
          <div class="chat_messages__group__gatmessage__date">
            ${message.created_at}
          </div>
        </div>
        <img src=${message.image} class="chat_messages__group__gatmessage__message__image">
        </div>
      </div>`
    };
  return html;
  };

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

  var reloadMessages = function() {
    var last_message_id = $('.chat_messages__group:last').data("message-id");
    //👆 カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得
    $.ajax({
      url: "api/messages", // ルーティングで設定した通り/groups/id番号/api/messagesとなるよう文字列を書く
      type: 'get', //ルーティングで設定した通りhttpメソッドをgetに指定
      dataType: 'json',
      data: {id: last_message_id} //dataオプションでリクエストに値を含める
    })
    .done(function(messages) {
      if (messages.length !== 0) {
      var insertHTML = '';
      //追加するHTMLの入れ物を作る
      $.each(messages, function(_i, message) {
      //配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
      insertHTML += buildHTML(message)
      });
      $('.chat_messages').append(insertHTML);
      //メッセージが入ったHTMLに、入れ物ごと追加
      $('.chat_messages').animate({ scrollTop: $('.chat_messages')[0].scrollHeight});
      }
    })
    .fail(function() {
      alert('error');
    });
    
  };
  if (document.location.href.match(/\/groups\/\d+\/messages/)) {
    setInterval(reloadMessages, 7000);
  }
});
