class Admin::CategoriesController < Admin::BaseController
  include ApplicationHelper

  load_and_authorize_resource

  def index; end

  def new
    check_root_category
    @category_new = Category.new
  end

  def create
    if params[:id] == "0"
      @category_new = Category.new category_params
    else
      find_category
      @category_new = Category.new category_params.merge(parent_id: params[:id])
    end
    if @category_new.save
      flash[:success] = t("controller.category.create_success")
      category_redirect @category_new
    else
      check_root_category
      flash[:danger] = t("controller.category.create_fail")
      render :new
    end
  end

  def show
    @category_child = @category.children
  end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t("controller.category.update_success")
      category_redirect @category
    else
      flash[:danger] = t("controller.category.update_fail")
      render :edit
    end
  end

  def destroy
    if category_has_no_product_are_being_ordered @category
      if @category.destroy
        flash[:success] = t("controller.category.delete_success")
      else
        flash[:danger] = t("controller.category.delete_error")
      end
    else
      flash[:notice] = t("controller.category.delete_fail")
    end
    category_redirect @category
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def category_redirect category
    if category.parent
      redirect_to admin_category_path category.parent
    else
      redirect_to admin_categories_path
    end
  end

  def check_root_category
    params[:id] == "0" ? @category = 0 : ""
  end
end
