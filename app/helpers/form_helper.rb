module FormHelper
  def form_group_for(form, model, field, opts={}, &block)
    value         = model[field]
    is_invalid    = model.errors[field].present?
    error_message = model.errors[field].try(:first)

    label       = opts.fetch(:label) { true }
    placeholder = opts.fetch(:placeholder) { '' }

    content_tag :div, class: "form-group" do
      concat form.label(field, class: 'control-label') if label
      if block_given?
        yield
      else
        concat form.text_field(field, value: value, class: "form-control #{'is-invalid' if is_invalid }", placeholder: placeholder)
      end
      concat content_tag(:div, error_message, class: 'invalid-feedback')
    end
  end
end

# <div class="form-group <%= 'has_error' if role.errors[:name].any? %>">
#     <label>Role name</label>
#     <%= f.text_field :name, value: role.name, class: 'form-control is-invalid', placeholder: 'Role name' %>
#     <%= content_tag(:div, role.errors[:name].try(:first), class: 'is-invalid') %>
#   </div>
#   <%= f.submit 'Create', class: 'btn btn-primary' %>

#   module FormHelper
#     def errors_for(form, field)
#         content_tag(:p, form.object.errors[field].try(:first), class: 'help-block')
#     end

#     def form_group_for(form, field, opts={}, &block)
#         label = opts.fetch(:label) { true }
#         has_errors = form.object.errors[field].present?

#         content_tag :div, class: "form-group #{'has-error' if has_errors}" do
#             concat form.label(field, class: 'control-label') if label
#             concat capture(&block)
#             concat errors_for(form, field)
#         end
#     end
# end