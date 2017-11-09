class MainBannerDecorator < MainDecorator

  def formatted_date(format = '%m/%d/%Y')
    object.date.strftime(format) if object.date.present?
  end

  def main_image(format = :gallery)
    object.main_image.try(:url, format).to_s
  end

end