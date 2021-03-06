class UsersController < ApplicationController

  before_action :authenticate_user!
  
  def index
  	  @users = User.all
	    @book = Book.new
  end

  def show
  	  @user = User.find(params[:id])
  	  @book = Book.new
  end

  def edit
  	  @user = User.find(params[:id])
  end

  def update
  	  @user = User.find(params[:id])
  	  if @user.update(user_params)
         flash[:notice] = "User information was updated successfully."
  	     redirect_to user_path(current_user)
  	  else
  	  	 render :edit
  	  end
  end

  def books
  	  @users = User.all
      @book = Book.new
      @book = Book.all
  end

private
  def user_params
   	  params.require(:user).permit(:name, :introduction, :image)
   end
end
