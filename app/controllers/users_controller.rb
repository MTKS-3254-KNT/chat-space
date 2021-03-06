class UsersController < ApplicationController

  def index
    @users = User.search(params[:keyword], current_user.id)
    # クラスメソッドのsearchで検索キーワードと検索者のIDを渡し、返り値を変数に代入
    respond_to do |format|
      format.html
      format.json
    end
  end

  # 別解（後で読み返せるようにメモしてます）
  # def index
  #   return nil if params[:keyword] == ""
  #   @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
  #   respond_to do |format|
  #     format.html
  #     format.json
  #   end
  # end

  def edit
  end

  def update
    # binding.pry
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
