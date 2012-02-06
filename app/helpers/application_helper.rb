module ApplicationHelper

  def title
    if !@title.nil?
     "Ruby on Rails Tutorial Sample App | " + @title
    end
  end

end
