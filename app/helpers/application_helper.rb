module ApplicationHelper

  def flash_class level
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-warning"
    when :danger then "alert alert-danger"
    end
  end

  def draw_sidebar category
    content_tag :li, class: "collapsed active" do
      concat draw_sub category
      category.children.each do |child|
        concat content_tag(:ul, draw_sidebar(child), id: "cat#{category.id}",
          class: "sub-menu nav nav-list collapse")
      end
    end
  end

  def draw_sub category
    content_tag(:a, class: "accordion-heading",
      "data-target": "#cat#{category.id}", "data-toggle": "collapse") do
      if category.children.any?
        concat content_tag(:span, nil,
          class: "pull-right fa fa-angle-down fa-lg")
      end
      concat category.name
    end
  end

  def list_category
    @categories = Category.list_parents.ordered_by_name
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_cart
    return unless session[:cart]
    session[:cart].delete_if{|key, value| value == 0}
    @current_cart ||= Product.product_in_cart(session[:cart].keys)
    @current_cart.map do |item|
      item.quantity_in_cart = session[:cart][item.id.to_s]
    end
    @current_cart
  end

  def option_for_status_order
    Order.statuses.to_a.map { |w| [w[0].humanize, w[1]] }
  end

  def check_available_product_to_order
    current_cart.each do |product|
      if product.quantity < product.quantity_in_cart.to_i
        redirect_to cart_path, notice: t("controller.order.not_enough_quantity")
        return
      end
    end
  end

  def total_cart
    session[:cart].values.inject(0){|sum,x| sum + x }
  end
end
