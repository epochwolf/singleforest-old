class RichTextFormBuilder < Formtastic::SemanticFormBuilder 
  def rich_input(method, options)
    form_helper_method = :text_area
    type = :text
    html_options = options.delete(:input_html) || {}
    html_options = default_string_options(method, type).merge(html_options) if [:numeric, :string, :password].include?(type)
    if html_options[:class] 
      html_options[:class] +=" rich"
    else
      html_options[:class] ="rich"
    end
    hint = "<a href='/pages/Markdown' target='new'>Markdown</a> and HTML allowed."
    if options[:hint] 
      options[:hint] << "<br/>" << hint
    else
      options[:hint] = hint
    end
    self.label(method, options_for_label(options)) << "<div class=\"rich-text-field\">" <<
    self.send(form_helper_method, method, html_options) << "</div>"
  end
end