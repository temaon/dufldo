class NewsDecorator < MainDecorator
  delegate :current_page, :per_page, :offset, :total_entries, :total_pages

  def main_image(format = :gallery)
    object.images.try(:first).try(:url, format).to_s.presence || 'default.jpg'
  end

  def second_image
    (has_video? ? object.video.url_thumb : object.images.try(:second).try(:url, :gallery).to_s).presence || 'default.jpg'
  end

  def get_video
    (object.video.video_player if has_video?).to_s
  end

  def has_video?
    object.video.present?
  end

  def slug_path
    (object.try(:slug).present? ? object.slug.try(:slug) : url_helpers.news_path(object.id)).to_s
  end

  def slug_url
    (object.try(:slug).present? ? URI.join(url_helpers.root_url, object.slug.try(:slug)).to_s : url_helpers.news_url(object.id)).to_s
  end

  def formatted_date(format = '%d %b, %Y')
    object.date.present? ? I18n.l(object.date, format: format) : nil
  end

end