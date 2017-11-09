module Concerns::Extensions
  extend ActiveSupport::Concern
  def find_nested_query(params, key)
    id = params[:id]
    model_name = params[:model_name]
    object = (id.present? && model_name.present?)? model_name.classify.safe_constantize.try(:find, id) : nil
    value = object.try(key)
    return object, value
  end
end