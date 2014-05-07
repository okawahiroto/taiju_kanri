class WeightsController < ApplicationController

  def new
    @weight = Weight.new(user: current_user)
  end

  def create
    @weight = Weight.new(weight_params)
    @weight.user = current_user
    if @weight.save
      redirect_to user_path(@weight.user), notice: '体重を登録しました'
    else
      render 'new'
    end
  end

  def edit
    @weight = Weight.find(params[:id])
  end

  def update
    @weight = Weight.find(params[:id])
    if @weight.update(weight_params)
      redirect_to user_path(@weight.user), notice: '体重を変更しました'
    else
      render 'edit'
    end
  end

  def destroy
    @weight = Weight.find(params[:id])
    @weight.destroy
    redirect_to user_path(@weight.user), notice: '体重を削除しました'
  end

  private

    def weight_params
      params.require(:weight).permit(:date, :weight)
    end
end
