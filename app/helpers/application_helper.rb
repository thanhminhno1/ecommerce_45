module ApplicationHelper

  def flash_class level
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-warning"
    when :danger then "alert alert-danger"
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
    session[:cart].delete_if{|key, value| value.zero?}
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
      end
    end
  end

  def total_cart
    session[:cart].values.reduce(:+)
  end

  def check_rated product
    return unless current_user
    current_user.reviews.find_by product_id: product
  end

  def add_recently_product product
    return true unless current_user
    history = current_user.history
    if history
      array = history.products[1..-2].split(", ").map(&:to_i)
      array.delete product.id
      array.delete_at(0) if array.length == 5
      array << product.id
      return false unless history.update products: array.to_s
    else
      array = []
      array << product.id
      history = History.new user_id: current_user.id, products: array.to_s
    end
    history.save ? true : false
  end

  def recently_product
    return [] unless current_user && current_user.history
    array = current_user.history.products[1..-2].split(", ").map(&:to_i)
    begin
      return Product.find array.reverse
    rescue
      return []
    end
  end

  def category_has_no_product_are_being_ordered category
    return true unless category
    products = get_all_product_by_category category, []
    count = Order.pending.have_products(products).count
    count.zero?
  end

  def get_all_product_by_category category, products
    @products = products
    @products += category.products.pluck(:id)
    if category.children.any?
      category.children.each do |cat|
        get_all_product_by_category cat, @products
      end
    end
    @products
  end

  def product_are_not_being_ordered product
    return true unless product
    Order.pending.have_products(product.id).count.zero?
  end
end
