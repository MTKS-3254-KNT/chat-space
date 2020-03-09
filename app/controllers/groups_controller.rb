class GroupsController < ApplicationController

  def index
  end

  def new
    @group = Group.new # 空のレコードを取得
    @group.users << current_user # ユーザー情報を配列に追加
  end

  def create
    # binding.pry
    @group = Group.new(group_params) #受け取った情報を変数に代入
    if @group.save # newで取得した空のレコードに保存
      redirect_to root_path, notice: 'グループを作成しました' #リダイレクトでrootへ、フラッシュメッセージ表示
    else
      render :new # @group変数を上書きされないようにrenderで表示
    end
  end

  def edit
    @group = Group.find(params[:id]) # 編集するgroupのレコードを変数に代入
  end

  def update
    @group = Group.find(params[:id]) # 受け取った引数を変数に代入
    if @group.update(group_params) # 変更をテーブルに反映
      redirect_to root_path, notice: 'グループを更新しました' #リダイレクトでrootへ、フラッシュメッセージ表示
    else
      render :edit # @group変数を上書きされないようにrenderで表示
    end
  end

private

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end                     #👆配列に対して保存を許可したい場合は、キーの名称と関連づけてバリューに[]と記述
#     {"name"=>"新規グループ", "user_ids"=>["", "1", "3"]}
#      Group.create(name: "グループ１", user_ids: [1, 2])

end
