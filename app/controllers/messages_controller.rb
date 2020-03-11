class MessagesController < ApplicationController
  before_action :set_group #先にプライベートメソッドを読み込みすることでコントローラ全てで変数を使えるようにする。

  def index
    @message = Message.new # 空のメッセージレコードの作成
    @messages = @group.messages.includes(:user) #グループidとリンクするメッセージとユーザー情報を取得し変数に代入
    # binding.pry
  end

  def create
    @message = @group.messages.new(message_params) #グループに送信されたメッセージを新しいレコードを作成し変数に代入
    if @message.save #変数に代入されたメッセージ情報をテーブルに保存
      redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'# 保存ができたらメッセージを送信したグループにリダイレクト
    else
      @messages = @group.messages.includes(:user) #保存ができなかったら最新の情報を変数に代入しindexへ移動
      flash.now[:alert] = 'メッセージを入力してください。'#フラッシュメッセージの表示
      render :index #リダイレクトではなく直接indexへ移動
    end
  end

  private

  def message_params # 送信されたメッセージを取得し、メッセージテーブルのtextとimage、投稿したユーザーidを取得したハッシュを変数に代入
    params.require(:message).permit(:text, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id]) #取得したグループidを元にグループのレコードをインスタンス変数に代入
  end

end
