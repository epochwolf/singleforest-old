# encoding: utf-8
module ApplicationHelper
  def title(str)
    # TODO fill in this function later
    #perhaps set the page title?
    @page_title = str + " - Singleforest"
  end
  
  def nav(str)
    @active_navigation = str
  end
  
  def heading_link(title, link)
    cls= (title.downcase == @active_navigation.to_s.downcase)? "active" : "inactive"
    link_to title, link, :class => cls
  end
  
  def continue_redirect
    hidden_field_tag :return_uri, params[:return_uri] if params[:return_uri]
  end
  
  def return_to_here(url=nil)
    url ||= request.request_uri
    hidden_field_tag :return_uri, url
  end
  
  # ----------------
  # FIELD PROCESSING
  # ----------------
  
  def dt(datetime, options={})
    options = {
      :format => "%b %d, %Y %H:%M UTC",
    }.update options
    return "Null" if datetime.nil?
    datetime.strftime(options[:format])
  end
  
  #print a boolean item
  def b(item, options={})
    options = {
      :true => "Yes",
      :false => "No",
      :nil => "No"
    }.update options
    if item.nil?
      options[:nil]
    elsif item
      options[:true]
    else
      options[:false]
    end
  end
  
  RICH = SanitizeMods::ALL_SANITIZE_OPTIONS
  SIMPLE = SanitizeMods::LIMITED_SANITIZE_OPTIONS
  
  def h_hint
    "Formatting not supported. Linebreaks are ignored."
  end
  
  def rich(str) 
    return "" if str.blank?
    str = SanitizeMods.markdown(str)
    Sanitize.clean(str, RICH).html_safe!
  end

  # --------
  # CONTROLS
  # --------
  
  def partial(partial, local_variable_name, data = nil)
    name = local_variable_name.to_sym
    data = instance_variable_get("@#{local_variable_name}") if data.nil? #Assume local is an instance variable name if data is nil
    render :partial => partial, :locals => {name => data}
  end
  
  def paginate(object, labels=["Newer", "Older"])
    js = <<-EOL
    window.location = "#{url_for :page => ""}".replace(/page=/i, "page="+document.getElementById("paginate_jump_field").value);
    EOL
    js2 = <<-EOL
    EOL
    str = will_paginate(object, :previous_label => "« #{labels[0]}", :next_label => "#{labels[1]} »", :outer_window => 2, :container => false)
    content_tag(:div, :class=>"paginate") do 
      str+
      content_tag(:input, nil, :type => "text", :id => "paginate_jump_field", :size=>3, :value => (params[:page] || 1)) + 
      observe_field(:paginate_jump_field, :function => js)
    end if str
  end
  
  # Content box, draws a content box.
  # Options
  # <tt>rank</tt> - 
  # <tt>user_id</tt> - 
  def control_box(title, options={}, &block)
    if options.has_key?(:rank) || options.has_key?(:user_id)
      return false unless rank?(options[:rank], :user_id => options[:user_id])
    end
    concat(
      content_tag(:div, :class => "controls") do
        content_tag(:div, :class => "top") do
          title
        end + 
        content_tag(:div, :class => "body") do 
          capture(&block)
        end
      end
    )
  end
  
  # Content box, draws a content box.
  # Options
  # <tt>rank</tt> - 
  # <tt>user_id</tt> - 
  def control(options={}, &block)
    if options.has_key?(:rank) || options.has_key?(:user_id)
      return false unless rank?(options[:rank], :user_id => options[:user_id])
    end
    concat(
      content_tag(:div, :class => "control") do
        capture(&block)
      end
    )
  end
end
