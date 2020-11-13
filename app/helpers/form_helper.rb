module FormHelper
  def form_group_for(form, field, opts={}, &block)
    object = form.object

    value         = object[field]
    is_invalid    = object.errors[field].present?
    error_message = object.errors[field].try(:first)

    label       = opts.fetch(:label) { true }
    label_text  = opts.fetch(:label_text) { nil }
    placeholder = opts.fetch(:placeholder) { '' }

    content_tag :div, class: "form-group" do
      concat form.label(field, label_text, class: 'control-label') if label
      if block_given?
        yield
      else
        concat form.text_field(field, value: value, class: "form-control #{'is-invalid' if is_invalid }", placeholder: placeholder)
      end
      concat content_tag(:div, error_message, class: 'invalid-feedback')
    end
  end
end
