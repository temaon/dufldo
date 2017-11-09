class GameDecorator < MainDecorator

  def get_results(sep = ':')
    "#{home_team_result || '--'} #{sep} #{guest_team_result || '--'}"
  end

  def home_team(decorate = false)
    @home_team ||= decorate ? game.home_team_structure.team.try(:decorate) : game.home_team_structure.team
  end

  def guest_team(decorate = false)
    @guest_team ||= decorate ? game.guest_team_structure.team.try(:decorate) : game.guest_team_structure.team
  end

  def formatted_date(format = '%d %b %Y %I:%M')
    object.date.present? ? I18n.l(object.date, format: format) : nil
  end

  def slug_path
    (object.try(:slug).present? ? object.slug.try(:slug) : url_helpers.tournament_game_path(object.tournament.id, object.id)).to_s
  end

  def slug_url
    (object.try(:slug).present? ? URI.join(url_helpers.root_url, object.slug.try(:slug)).to_s : url_helpers.tournament_game_url(object.tournament.id, object.id)).to_s
  end

end