class ProductsController < ApplicationController
  layout "home"

  def show
    @product = Product.find_by id: params[:id]
    redirect_to root_path, notice: t("controller.product.not_found") unless @product
  end
end
