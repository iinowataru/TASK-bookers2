class BooksController < ApplicationController
before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @books = Book.all
    @user = @book.user
  end

  def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   if @book.save
     flash[:notice]= "You have created book successfully."
      redirect_to book_path(@book.id)
   else
     @books = Book.all
     @user = User.all
     @user = current_user
     render :index
   end
  end

  def edit
  end

  def update
  @book.update(book_params)
  if @book.update(book_params)
  flash[:notice]= "You have created book successfully."
  redirect_to book_path(@book.id)
  else
  render :edit
  end
  end

def destroy
  @book.destroy
  redirect_to books_path
end

private
def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
end
def book_params
  params.require(:book).permit(:title, :body, :name, :introduction, :profile_image)
end
end