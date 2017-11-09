class SmallBannerDecorator < MainDecorator

  def main_image(format = :medium)
    object.main_image.try(:url, format).to_s
  end

end