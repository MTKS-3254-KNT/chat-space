$(function() {
  function addUser(user) { // 検索した内容を表示させる関数の定義
    let html = // 追加したいHTMLのDOMツリーを変数に定義（検証でコピー）
      `<div class="chat-group-user clearfix">
        <p class="chat-group-user__name">${user.name}</p>
        <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
      </div>`;
    $("#user-search-result").append(html); // 指定した要素の最後に子要素として上記の変数を追加
  }
  function addNoUser() { // 検索したユーザーが見つからなかった時に表示する関数の定義
    let html = // 追加したいHTMLのDOMツリーを変数に定義（検証でコピー）
      `<div class="chat-group-user clearfix">
        <p class="chat-group-user__name">ユーザーが見つかりません</p>
      </div>`;
    $("#user-search-result").append(html); // 指定した要素の最後に子要素として上記の変数を追加
  }



  function addDeleteUser(name, id) { //追加されたユーザーの表示箇所を移動する関数
    let html = // 追加したいHTMLのDOMツリーを変数に定義
    `<div class="chat-group-user clearfix" id="${id}">
      <p class="chat-group-user__name">${name}</p>
      <div class="user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn" data-user-id="${id}" data-user-name="${name}">削除</div>
    </div>`;
    $(".js-add-user").append(html); // 指定した要素の最後に子要素として上記の変数を追加
  }

  function addMember(userId) { //追加したメンバー情報をグループに追加
    console.log(userId)
    let html = `<input value="${userId}" name="group[user_ids][]" type="hidden" id="group_user_ids_${userId}" />`;
    $(`#${userId}`).append(html); //ユーザーIDは⬆で追加したHTML要素の間に入る
  }



  $("#user-search-field").on("keyup", function() { // 入力フォームに文字入力を条件にイベント発生する関数の定義
    let input = $("#user-search-field").val(); // 入力された文字列を取得し変数へ代入
    $.ajax({ // ajax通信を開始する記述
      type: "GET", // 通信方法：HTTPメソッド
      url: "/users", // リンク先の指定（今回はusers#index）
      data: { keyword: input }, // 送信データの内容（今回は検索ワード）
      dataType: "json" // サーバーから値を返す際のType
    })
      .done(function(users) { //通信成功したときの記述
        $("#user-search-result").empty(); //指定した要素の子要素のみ削除する
        
        if (users.length !== 0) { //配列に入っている結果の個数を確認し、条件分岐
          users.forEach(function(user) { //検索結果がある場合ユーザーを連続表示
            addUser(user); // 上記関数にユーザー名を引数で渡し表示
          });
        } else if (input.length == 0) { //検索結果にユーザーがいない場合の処理
          return false; //返り値がないことを記述（可読性向上のため）
        } else { // 上記の条件以外の場合
          addNoUser(); // ユーザーが見つかりませんと表示するHTMLを作成する。
        }
      })
      .fail(function() { // 通信に失敗した場合の関数
        alert("通信エラーです。ユーザーが表示できません。"); //エラーしたことをアラートで表示する。
      });
  });

  $(document).on("click", ".chat-group-user__btn--add", function() {
    // 追加ボタンを押した時の関数 $(document).onにすることであとから追加されたクラスのノードを取得できる
    const userName = $(this).attr("data-user-name"); // クリックした要素のvalu（ユーザー名）を取得し変数に定義
    const userId = $(this).attr("data-user-id");     // クリックした要素のvalu（ユーザーID）を取得し変数に定義
    $(this) // 選択されたノードを取得
      .parent() //選択された親要素を取得
      .remove();//選択された要素を削除する
    addDeleteUser(userName, userId);//上記の関数を使用し、選択されたユーザーの表示をグループメンバーの方へ表示
    addMember(userId);//👆で追加したHTMLの要素の２行目（IDの子要素）にグループに追加する情報を持ったHTML要素を追加する（hiddenなので非表示）
  });

  $(document).on("click", ".chat-group-user__btn--remove", function() { //削除ボタンを押したときの関数
    $(this) //選択されているノードを取得
      .parent() //親要素を取得
      .remove();//選択された要素を削除する（削除された要素の中にグループに追加するための情報も含まれるためメンバーからも削除される）
  });
});