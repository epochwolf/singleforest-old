module ForumThreadsHelper
  #helper to clean up forums_cagetories/show 
  def sunk_deleted_text(thread)
    arr = []
    arr << "sunk" if thread.sunk?
    arr << "deleted" if thread.deleted?
    if arr.empty?
      ""
    else
      arr.join ", "
    end
  end
  
  #helper to clean up forums_threads/show
  def sinking_deleting_text(thread)
    arr = []
    arr << "sinking" if thread.sunk?
    arr << "deleting" if thread.deleted?
    if arr.empty?
      ""
    else
      arr.to_sentence
    end
  end
end
