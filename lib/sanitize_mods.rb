module SanitizeMods


LIMITED_SANITIZE_OPTIONS = {
  :protocols=>{
    "a"=>{"href"=>["http", "https"]},
  }, 
  :elements=>["a", "b", "blockquote", "br", "caption", "cite", "code", "dd", 
              "dl", "dt", "em", "i", "li", "ol", "p", "pre", "q", "small", 
              "strike", "strong", "sub", "sup", "tt", "u", "ul"],
  :attributes=>{
    "ul"=>["type"], 
    "a"=>["href", "title"], 
    "ol"=>["start", "type"], 
  },
  :transformers => []
}


ALL_SANITIZE_OPTIONS = {
  :protocols=>{
    "a"=>{"href"=>["http", "https"]},
  }, 
  :elements=>["a", "abbr", "b", "blockquote", "br", "code", "col",
              "colgroup", "dd", "dl", "dt", "em", "h1", "h2", "h3", "i", "li",
              "ol", "p", "pre", "q", "small", "strike", "strong", "sub", "sup",
              "table", "tbody", "td", "tfoot", "th", "thead", "tr", "tt", "u",
              "ul"],
  :attributes=>{
    "abbr" => ["title"],
    "colgroup"=>["span", "width"], 
    "col"=>["span", "width"], 
    "ul"=>["type"], 
    "a"=>["href", "title", "name"], 
    "q" => ["cite"],
    "blockquote" => ["cite"],
    "td"=>["abbr", "axis", "colspan", "rowspan", "width"], 
    "table"=>["summary", "width"], 
    "ol"=>["start", "type"], 
    "th"=>["abbr", "axis", "colspan", "rowspan", "scope", "width"]
  },
  :transformers => []
}

MARKDOWN_OPTIONS = {
    :strict_mode => false,
    :auto_links => true,
    }
  
  def self.markdown(str)
    BlueCloth.new(str, MARKDOWN_OPTIONS).to_html
  end

  TRANSFORMER = Proc.new do |env|
    case(env[:node].name)
    when "" then nil
    else
      nil
    end
  end
end


# wikilink = "<a href=\"http://en.wikipedia.org/wiki/#{str}\">#{str.humanize}</a>"
# license = "<a href=\"http://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License\">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>" 
# "<cite>Taken from: Wikipedia Artcile: #{wikilink} under #{license}</cite>"