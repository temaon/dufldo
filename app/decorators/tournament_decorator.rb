class TournamentDecorator < MainDecorator

  def main_image(format = :gallery)
    object.images.try(:first).try(:url, format).to_s
  end

  def rounds
    @rounds ||= object.rounds
  end

  def statistics
    @statistics ||= object.rounds.map {|round| {title: "#{round.name} - й тур", content: round.statistic} if round.statistic.present? }.compact if rounds.present?
  end

  def second_image
    object.images.try(:second).try(:url, :gallery)
  end

  def slug_path(anchor = nil)
    url = (object.try(:slug).present? ? object.slug.try(:slug) : url_helpers.tournament_path(object.id)).to_s
    url += "##{anchor}" if anchor.present?
    url
  end

  def slug_url
    object.try(:slug).present? ? URI.join(root_url, object.slug.try(:slug)).to_s : url_helpers.tournament_url(object.id)
  end

  def formatted_date(format = '%d %b, %Y')
    object.created_at.present? ? I18n.l(object.created_at, format: format) : nil
  end

end