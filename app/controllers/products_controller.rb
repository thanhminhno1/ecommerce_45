class ProductsController < ApplicationController
  include ApplicationHelper

  layout "home"

  def index
    @params_search = params[:product] || {name: ""}
    @products = Product.by_name(@params_search[:name]).page(params[:page])
                       .per(Settings.order.per_page)
  end

  def show
    @product = Product.find_by id: params[:id]
    redirect_to root_path, notice: t("controller.product.not_found") unless @product
    flash[:notice] = t("controller.product.recently_fail") unless add_recently_product @product
  end
end
