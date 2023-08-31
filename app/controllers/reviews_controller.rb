class ReviewsController < ApplicationController
  before_action :set_island, only: %i[create edit update]

  def create
    @review = Review.new(review_params)
    @review.booking = @booking
    if @review.save
      redirect_to island_path(@island), notice: 'Review submitted.'
    else
      render "islands/show", status: :unprocessable_entity
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to user_path(current_user)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_booking
    @booking = Island.find(params[:booking_id])
  end
end
