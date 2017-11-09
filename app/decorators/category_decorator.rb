class CategoryDecorator < MainDecorator

  def slug_path
    object.try(:slug).present? ? object.slug.try(:slug) : url_helpers.category_path(object.id)
  end

  def slug_url
    object.try(:slug).present? ? URI.join(root_url, object.slug.try(:slug)).to_s : url_helpers.category_url(object.id)
  end

  def main_image
    object.main_image.try(:url, :gallery).presence || 'default_banner.png'
  end

end