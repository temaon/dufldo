class ResultDecorator < Draper::Decorator

  delegate_all

  def team
    object.team_structure.team
  end

  def team_decorate
    @team_decorate ||= (object.team_structure.present? ? object.team_structure.team.try(:decorate) : nil)
  end



end