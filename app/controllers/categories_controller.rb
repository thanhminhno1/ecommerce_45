class CategoriesController < ApplicationController
  include ApplicationHelper

  layout "home"

  def show
    @category = Category.find_by id: params[:id]
    redirect_to root_path, notice: t("controller.category.not_found") unless @category
    list_id_product = get_all_product_by_category(@category, [])
    @products = Product.list_product(list_id_product).page(params[:page])
                       .per(Settings.product.per_page)
  end
end
