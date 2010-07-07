module LiteraturesHelper
  def tag_links(array_of_tags)
    return "<i>No tags</i>".html_safe! if array_of_tags.empty?
    array_of_tags.map! do |t|
      link_to(t.name, tag_path(t)) unless t.kind_of? String or t.nil?
    end 
    array_of_tags.join(', ')
  end
  
  def vote_text(vote)
    case vote.to_i
    when 1 then "Yes"
    when -1 then "No"
    when 0 then "No opinion"
    else 
      "Error"
    end
  end
  
  # TODO: choose a better name for this method
  def mature_text(literature, short=true)
    
    #Using a hard coded solution because I don't know how this will look tomorrow.
    unless literature.mature?
      short ? "no" : "Not Mature"
    else
      base = "Mature"
      if literature.mature_sex? && literature.mature_violence?
        short ? "sex, violence" : base + " (Sex, Violence)"
      elsif literature.mature_violence?
        short ? "violence" : base + " (Violence)"
      elsif literature.mature_sex?
        short ? "sex" : base + " (Sex)"
      else
        short ? "mature" : base
      end
    end
  end
end
