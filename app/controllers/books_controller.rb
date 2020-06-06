class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  def index
    @books = current_user.books.order(finished_at: :desc)
  end

  def show
  end

  def new
    @book = Book.new
    @book.book_authors.build
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
    params.require(:book).permit(:title, :genre, :finished_at, :description,book_authors_attributes: [:author])
  end

  def set_book
    @book = current_user.books.find(params[:id])
  end
end
