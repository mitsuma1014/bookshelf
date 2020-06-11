class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  def index
    @q = current_user.books.ransack(params[:q])
    @books = @q.result(distinct: true)
  end

  def show
  end

  def new
    @book = Book.new
    3.times{ @book.book_authors.build }
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to :books, notice: "本棚に『#{@book.title}』を追加しました。"
    else 
      render :new
    end
  end
  
  def edit
    if @book.book_authors.count == 0
      3.times{ @book.book_authors.build }  
    elsif @book.book_authors.count == 1 
      2.times{ @book.book_authors.build }
    elsif @book.book_authors.count == 2
       @book.book_authors.build
    end
  end
  
  def update
    if @book.update(book_params)
      redirect_to :books, notice: "読書記録を更新しました。"
    else
      render :edit
    end
  end
  
  def destroy
    @book.destroy
    redirect_to :books, notice: "本棚から#{@book.title}を削除しました。"
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :genre, :finished_at, :description,book_authors_attributes: [:id,:author])
  end
  
  def set_book
    @book = current_user.books.find(params[:id])
  end
end
