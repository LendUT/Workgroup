module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80, type: "rounded")
    # gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    # gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # image_tag(gravatar_url, alt: user.name,  class: "gravatar img-#{type}")
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                       :class => "gravatar img-#{type}",
                       :gravatar => { :size => size })
  end

  def user_tab
    %w[tasks invitations followers follows comments groups].include?(params[:tab]) ? params[:tab] : nil
  end
end
