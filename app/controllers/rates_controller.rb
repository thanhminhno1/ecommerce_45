class RatesController < ApplicationController
  include ApplicationHelper

  def rating
    @product = Product.find_by id: params[:product_id]
    return render json: {}, status: 400 unless @product
    review = @product.reviews.find_or_create_by(user_id: current_user.id) do |item|
      item.number_star = params[:number_star]
    end
    review.update number_star: params[:number_star]
    return render json: {}, status: 400 unless review.save
    avg_rating @product
    render json: {}
  end

  private

  def avg_rating product
    product.update avg_star: product.reviews.average(:number_star)
    return render json: {}, status: 400 unless product.save
  end
end
