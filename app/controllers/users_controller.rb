class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id])
    respond_to do |f|
        f.html {render :show}
        f.json {render json: @project}
    end
  end 
end
