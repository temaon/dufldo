class MainDecorator < Draper::Decorator
  delegate_all

  delegate :url_helpers, to: 'Rails.application.routes'

end