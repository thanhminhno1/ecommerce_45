class HomeController < ApplicationController
  layout "home"

  def index
    @categories = Category.list_parents.ordered_by_name
    @products = Product.ordered_by_name.page(params[:page])
                       .per(Settings.product.per_page)
  end
end
