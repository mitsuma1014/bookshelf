class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @q = Review.all.ransack(params[:q])
    @reviews = @q.result(distinct: true).order(created_at: :desc).page(params[:page]) .per(10)
  end

  def new
    @review = Review.new
    Review::AUTHORS_FORM.times{ @review.review_authors.build }
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to :reviews, notice: "『#{@review.title}』の感想を投稿しました。"
    else
      render :new
    end
  end

  def edit
    if @review.review_authors.count == (Review::AUTHORS_FORM - 3)
      Review::AUTHORS_FORM.times{ @review.review_authors.build }
    elsif @review.review_authors.count == (Review::AUTHORS_FORM - 2)
      (Review::AUTHORS_FORM - 1).times{@review.review_authors.build }
    elsif @review.review_authors.count == (Review::AUTHORS_FORM - 1)
        @review.review_authors.build
    end
  end

  def update
    if @review.update(review_params)
      redirect_to :reviews, notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to :reviews, notice: "投稿を削除しました。"
  end

  private

  def review_params
    params.require(:review).permit(:title, :genre, :content,review_authors_attributes: [:id, :author])
  end

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def ensure_correct_user
    @review = Review.find_by(id: params[:id])
    if !@review.owned_by?(current_user)
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end
end
