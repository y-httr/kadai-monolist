class UsersController < ApplicationController
  before_action :require_user_logged_in?, only: [:show]
  
  def show
    @user =User.find(params[:id])
    #.uniqは１つの商品にWant,Haveしていた場合の重複を防ぐため
    @items = @user.items.uniq
    @count_want = @user.want_items.count
  end

  def create
    @user=User.new(user_params)
    if @user.save
      flash[:success]="ユーザを登録しました"
      redirect_to @user
    else
      flash.now[:danger]="ユーザの登録に失敗しました"
      render :new
    end
  end

  def new
    @user=User.new
  end
  
  private 
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
