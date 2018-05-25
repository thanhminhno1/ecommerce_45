module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:div, msg, class: "alert alert-danger") }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h3>#{sentence}</h2>
      <div>#{messages}</div>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.any?
  end

end
