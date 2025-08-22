class DemonSlayer < ApplicationRecord
  validates :name, presence: true
  validates :kanji, presence: true
  validates :power, presence: true, numericality: { only_integer: true }

  default_scope { where(deleted_at: nil) }

end
