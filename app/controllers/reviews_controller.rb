class ReviewsController < ApplicationController
  def index
    @q = Review.all.ransack(params[:q])
    @reviews = @q.result(distinct: true) 
  end

  def show
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
  end

  private

  def review_params
    params.require(:review).permit(:title, :genre, :content,review_authors_attributes: [:id, :author])
  end
end
