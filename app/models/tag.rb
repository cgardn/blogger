class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings, dependent: :delete_all

  def to_s
    name
  end

end
