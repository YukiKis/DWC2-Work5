class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @comment_new = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to books_path
    end
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  def search
    if params[:ub] == "1" && params[:how] == "1"
      @books = Book.searched_by_user_whole(params[:search])
    elsif params[:ub] == "1" && params[:how] == "2"
      @books = Book.searched_by_user_head_part(params[:search])
    elsif params[:ub] == "1" && params[:how] == "3"
      @books = Book.searched_by_user_tail_part(params[:search])
    elsif params[:ub] == "1" && params[:how] == "4"
      @books = Book.searched_by_user_part(params[:search])
    elsif params[:ub] == "2" && params[:how] == "1"
      @books = Book.searched_by_book_whole(params[:search])
    elsif params[:ub] == "2" && params[:how] == "2"
      @books = Book.searched_by_book_head_part(params[:search])
    elsif params[:ub] == "2" && params[:how] == "3"
      @books = Book.searched_by_book_tail_part(params[:search])
    elsif params[:ub] == "2" && params[:how] == "4"
      @books = Book.searched_by_book_part(params[:search])
    else
      @books = Book.all
    end 
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end