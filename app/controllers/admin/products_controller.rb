class Admin::ProductsController < Admin::BaseController
  include ApplicationHelper

  before_action :find_category, except: %i(import_process import)
  before_action :find_product, only: %i(edit update show destroy)

  def index
    @params_search = params[:product] || {name_or_desc: ""}
    @products = @category.products.by_name_or_desc(@params_search[:name_or_desc])
                         .page(params[:page]).per(Settings.product.per_page)
  end

  def new
    @product = @category.products.new
  end

  def create
    @product = @category.products.new product_params
    if @product.save
      flash[:success] = t("controller.product.create_success")
      redirect_to admin_category_products_path @category
    else
      flash[:error] = t("controller.product.create_fail")
      render :new
    end
  end

  def edit; end

  def update
    if @product.update product_params
      flash[:success] = t("controller.product.update_success")
      redirect_to admin_category_products_path @category
    else
      flash[:error] = t("controller.product.update_fail")
      render :edit
    end
  end

  def show; end

  def destroy
    if product_are_not_being_ordered @product
      if @product.destroy
        flash[:success] = t("controller.product.delete_success")
      else
        flash[:danger] = t("controller.product.delete_error")
      end
    else
      flash[:notice] = t("controller.product.delete_fail")
    end
    redirect_to admin_category_products_path @category
  end

  def import_process
    unless params[:file]
      flash[:notice] = t("controller.product.file_not")
      redirect_to admin_product_import_path
      return
    end
    Product.import params[:file]
    flash[:success] = t("controller.product.import_success")
    redirect_to admin_categories_path
  end

  private

  def product_params
    params.require(:product).permit :name, :description, :price, :quantity,
      :image
  end

  def find_category
    @category = Category.find_by id: params[:category_id]
    return if @category
    flash[:notice] = t("controller.category.not_found")
    redirect_to admin_categories_path
  end

  def find_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:notice] = t("controller.product.not_found")
    redirect_to admin_categories_path
  end
end
