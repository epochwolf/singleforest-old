module SFExtensions
  
  =begin
        #regex to capture a url
        /(?:^|\s)
        (?#start-url \1)(
          (?#protocol \2)(http|https|ftp|ftps|irc|gopher)
          :\/\/
          (?#domain \3)([^\/\s]+)
          (?#path \4?)([^\s]+)?
        )(?#end-url)
        (?:\s|$)/
  =end
  URL_REGEX = /(?:^|\s)(?#start-url \1)((?#protocol \2)(http|https|ftp|ftps|irc|gopher):\/\/(?#domain \3)([^\/\s]+)(?#path \4?)([^\s]+)?)(?#end-url)(?:\s|$)/
  
  def pre_parse(text)
    text = url_to_hyperlink(text)
    text
  end
  
  def post_parse(text)
    text = make_links_no_follow(text)
  end
  
  # TODO: Implement
  def make_links_no_follow(text)
    text
  end
  
  # TODO: Test this.
  def url_to_hyperlink(str)
      link = '<a href ="\1">\1</a>'
      str.gsub(SFExtensions::URL_REGEX, link)
    end
end