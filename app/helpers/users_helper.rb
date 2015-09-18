module UsersHelper

  def formatted_user_profile_link(user)
    link_to name_displayed_for(user), user_path(user)
  end

  def name_displayed_for(user)
    user.name.blank? ? user.login : user.name
  end

  def name_and_or_login_for(user)
    if user.name.blank?
      user.login
    else
      "#{user.name} (#{user.login})"
    end
  end

end
