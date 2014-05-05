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

  private

    def weight_params
      params.require(:weight).permit(:date, :weight)
    end
end
