module UsersHelper

  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def delete_user_link(user)
    link_to "delete user", user, method: :delete, class:"label label-important",
                                    data: { confirm: "You sure?" }
  end

end
