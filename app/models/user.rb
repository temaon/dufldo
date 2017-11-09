class User < ApplicationRecord
  include RailsAdmin::User

  after_create :assign_default_role
  before_save :set_default_type


  #impressionist
  is_impressionable counter_cache: true, column_name: :watches_count, unique: :request_hash

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :news, dependent: :destroy, source: :news, inverse_of: :user
  accepts_nested_attributes_for :news, allow_destroy: true

  acts_as_commontator

  def is_admin?
    self.has_role? :admin
  end

  def set_default_type
    self.type = 'Account' if type.blank?
  end

  private

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

end
