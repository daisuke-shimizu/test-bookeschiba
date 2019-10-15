class BooksController < ApplicationController

  before_action :authenticate_user!, only: [:show, :index, :edit]
  def top
  end

  def about
  end

  def index
  	  @book = Book.new
  	  @books = Book.all
  end

  def edit
  	  @book = Book.find(params[:id])
  end

  def show
      @books = Book.find(params[:id])
      @user = User.find(@books.user_id)
      @book = Book.new
  end

  def create
  	  @book = Book.new(book_params)
      @book.user_id = current_user.id
  	  if @book.save
        flash[:notice] = "Book was successfully created."
        redirect_to book_path(@book.id)
      else 
        @books = Book.all
         render :index
      end
  end

  def update
  	  @book = Book.find(params[:id])
  	  @book.update(book_params)
  	  if @book.save
  	  	flash[:notice] = "Book was successfully updated."
  	    redirect_to book_path(@book.id)
      else
        render :edit
  	  end
  end

  def destroy
  	  book = Book.find(params[:id])
  	  book.destroy
  	  if book.destroy
  	  	flash[:notice] = "Book was successfully destroyed."
  	    redirect_to '/books'
  	  end
  end

  private
    def book_params
      params.require(:book).permit(:title, :body, :image, :user_id)
    end
end
