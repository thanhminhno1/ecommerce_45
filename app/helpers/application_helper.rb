module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

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
end
