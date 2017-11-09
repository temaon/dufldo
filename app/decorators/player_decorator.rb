class PlayerDecorator < UserDecorator

  def main_image(format = :gallery)
    @photo ||= object.photo.try(:url, format).to_s
  end

  def team
    @team ||= object.team.try :decorate
  end

  def slug_path
    (object.try(:slug).present? ? object.slug.try(:slug) : url_helpers.player_path(object.id)).to_s
  end

  def slug_url
    (object.try(:slug).present? ? URI.join(root_url, object.slug.try(:slug)).to_s : url_helpers.player_url(object.id)).to_s
  end

  def position
    object.profile.try(:position)
  end

  def name
    object.profile.try(:full_name).to_s || object.profile.try(:name).to_s
  end

  def birthday(format = '%d %b, %Y')
    object.profile.try(:birthday) ? I18n.l(object.profile.birthday, format: format) : nil
  end

  def place
    object.profile.try(:place)
  end

  def weight
    object.profile.try(:weight).to_s
  end

  def height
    object.profile.try(:height).to_s
  end

  def team_name
    team.try(:name) || 'Без команды'
  end

  def team_logo
    team.try(:logo, :gallery) || 'comming-soon/logo.png'
  end

  def description
    object.profile.try(:description)
  end

  def goals_count
    object.career.try(:goals_count)
  end

end