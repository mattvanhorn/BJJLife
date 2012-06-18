module ApplicationHelper

  def standard_header(replacement_text=nil, &additional_content)
    header_text = (replacement_text.presence || t('.header'))
    extra = capture_haml(&additional_content) if block_given?
    capture_haml do
      haml_tag :div, :class => "row header" do
        haml_tag( :h2, "#{header_text}".html_safe)
        haml_concat extra.html_safe unless extra.blank?
      end
    end
  end

  def stripe_javascript
    if controller.controller_name == 'orders'
      javascript_include_tag("https://js.stripe.com/v1/")
    end
  end

  def order_form_javascript
    if controller.controller_name == 'orders'
      javascript_include_tag("orders")
    end
  end
end
