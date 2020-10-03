class SearchesController < ApplicationController    
  before_action :authenticate_user!

  def search
    if search_params[:ub] == "1" && search_params[:how] == "1"
      @books = Book.searched_by_user_whole(search_params[:search])
    elsif search_params[:ub] == "1" && search_params[:how] == "2"
      @books = Book.searched_by_user_head_part(search_params[:search])
    elsif search_params[:ub] == "1" && search_params[:how] == "3"
      @books = Book.searched_by_user_tail_part(search_params[:search])
    elsif search_params[:ub] == "1" && search_params[:how] == "4"
      @books = Book.searched_by_user_part(search_params[:search])
    elsif search_params[:ub] == "2" && search_params[:how] == "1"
      @books = Book.searched_by_book_whole(search_params[:search])
    elsif search_params[:ub] == "2" && search_params[:how] == "2"
      @books = Book.searched_by_book_head_part(search_params[:search])
    elsif search_params[:ub] == "2" && search_params[:how] == "3"
      @books = Book.searched_by_book_tail_part(search_params[:search])
    else
      @books = Book.searched_by_book_part(search_params[:search])
    end
  end

  private
    def search_params
      params.permit(:ub, :how, :search, :utf8, :commit)
    end
end
