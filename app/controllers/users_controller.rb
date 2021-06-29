class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @users = User.all
  end
  def edit
  end

  def update
    if @user.update(user_params)
    flash[:notice]= "You have created book successfully."
    redirect_to user_path(@user.id)
    else
    render :edit
    end
  end

  private
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end

  end
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end



