class BooksController < ApplicationController
	 before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    if
      @book.save
      flash[:notice] = "successfully"
      redirect_to book_url(@book)
    else
      flash[:notice] = "error"
      render :index
    end
  end
  
  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if
      @book.update(book_params)
      flash[:notice] = "successfully."
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "error"
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_url
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    redirect_to(books_url) unless @book.user == current_user
  end

end