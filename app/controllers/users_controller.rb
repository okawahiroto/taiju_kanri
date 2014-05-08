class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 15).order('name ASC')
  end

  def show
    @user = User.find(params[:id])
    @weights = @user.weights.paginate(page: params[:page], per_page: 14).order('date DESC')

    current_weight = Weight.current_weight(@user)
    if current_weight.nil?
      @current_weight = '-'
      @current_date = '----年--月--日'
    else
      @current_weight = current_weight.weight
      @current_date = current_weight.date.strftime('%Y年%m月%d日')
    end

    @graph_data = @weights.order('date ASC').group(:date).sum(:weight)
    @min_value_in_chart = @weights.select(:weight).order('weight DESC').first
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user, notice: 'ユーザー情報を登録しました'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報を更新しました'
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: 'ユーザー情報を削除しました'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :target_weight, :password,
                                  :password_confirmation)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: 'サインインしてください'
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
