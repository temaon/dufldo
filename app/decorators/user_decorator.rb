class UserDecorator < MainDecorator

  def photo(format = :thumb)
    object.photo.try(:url, format).to_s
  end

  def slug_path
    (object.try(:slug).present? ? object.slug.try(:slug) : url_helpers.user_path(object.id)).to_s
  end

  def slug_url
    (object.try(:slug).present? ? URI.join(root_url, object.slug.try(:slug)).to_s : url_helpers.user_url(object.id)).to_s
  end

  def formatted_date(format = '%b %d, %Y')
    object.date.strftime(format)
  end

  def real_name
    object.profile.try(:name)
  end

  def full_name
    object.profile.try(:full_name) || object.profile.try(:name) || object.username
  end

end