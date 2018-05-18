class ProductsController < ApplicationController
  include ApplicationHelper

  layout "home"

  def show
    @product = Product.find_by id: params[:id]
    redirect_to root_path, notice: t("controller.product.not_found") unless @product
    flash[:notice] = t("controller.product.recently_fail") unless add_recently_product @product
  end
end
