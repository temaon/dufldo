class TeamDecorator < MainDecorator

  def main_image(format = :gallery)
    object.main_image.try(:url, format).to_s
  end

  def logo(format = :thumb)
    object.logo.try(:url, format).to_s
  end

  def second_image
    object.images.try(:second).try(:url, :gallery).to_s
  end

  def slug_path(anchor = nil)
    url = (object.try(:slug).present? ? object.slug.try(:slug) : url_helpers.team_path(object.id)).to_s
    url += "##{anchor}" if anchor.present?
    url
  end

  def slug_url
    (object.try(:slug).present? ? URI.join(root_url, object.slug.try(:slug)).to_s : url_helpers.team_url(object.id)).to_s
  end

  def formatted_date(format = '%b %d, %Y')
    object.created_at.strftime(format)
  end

  def title
    object.name
  end

end