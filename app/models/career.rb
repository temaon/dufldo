class Career < ApplicationRecord
  belongs_to :player, inverse_of: :career
end
