class Participant < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, email: true
  validates :phone, presence: true
  belongs_to :event
end
