module UsersHelper
  def user_link(user)
    unless user.kind_of? User
      if user.respond_to?(:_user)
        user = user._user
      elsif user.respond_to?(:user)
        user = user.user
      else
        return "[error]"
      end
    end
    if user.banned?
      cls = "user banned"
    elsif user.closed?
      cls = "user closed"
    elsif user.name
      cls = "user"
    end
    #Add user symbol
    
    link_to(user.name, user_path(user), :class => cls)
  end
  
  def rank_text(user_or_rank)
    rank = ((user_or_rank.is_a? User) ? user_or_rank.rank : user_or_rank)
    case rank
    when 100 then "Lycaon pictus"
    when 80..99 then "Canid"
    when 50...80 then "Citrus Bush"
    when 0...50 then "Legume"
    else 
      "Fruit of the Tree of the Knowledge of Good and Evil"
    end
  end
end
