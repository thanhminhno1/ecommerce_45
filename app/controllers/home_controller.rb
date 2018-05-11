class HomeController < ApplicationController
  layout "home"

  def index
    @products = Product.ordered_by_name.page(params[:page])
                       .per(Settings.product.per_page)
  end
end
