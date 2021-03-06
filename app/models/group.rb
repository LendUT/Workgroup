class Group < ApplicationRecord
  has_many :members, inverse_of: :group, :dependent => :destroy
  has_many :users,   through: :members
  has_many :tasks,   inverse_of: :group
  has_many :invitations

  validates :name,        presence: true, length: { maximum: 50 }
  validates :area,        presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 200 }

  # Search method
  def self.search(search)
    where("name LIKE ? or area LIKE ? or description LIKE ?","%#{search}%",
                                                             "%#{search}%",
                                                             "%#{search}%")
  end
end
