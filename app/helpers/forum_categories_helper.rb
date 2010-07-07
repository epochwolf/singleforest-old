module ForumCategoriesHelper
  def toplevel_title(str)
    ForumCategory::TOP_LEVELS_SELECT.each do |k, v|
      return k if v == str
    end
  end
end
