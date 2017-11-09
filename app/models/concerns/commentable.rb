module Concerns::Commentable
  extend ActiveSupport::Concern

  included do

    acts_as_commontable

    def self.is_commentable?
      is_commentable
    end

  end

end