module UsersHelper
  def liked_articles_request?
    controller.try(:liked_request?) || false
  end
end
