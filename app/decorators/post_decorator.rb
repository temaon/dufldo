class PostDecorator < MainDecorator
  delegate :current_page, :per_page, :offset, :total_entries, :total_pages

  def initialize(object, second)
    self.extend "Modules::#{object.template.to_s.classify}".safe_constantize
    super
  end

  def slug_path
    (object.try(:slug).present? ? object.slug.try(:slug) : url_helpers.post_url(object.id)).to_s
  end

  def slug_url
    (object.try(:slug).present? ? URI.join(url_helpers.root_url, object.slug.try(:slug)).to_s : url_helpers.post_url(object.id)).to_s
  end

  def formatted_date(format = '%d %b, %Y')
    object.date.present? ? I18n.l(object.date, format: format) : nil
  end

end