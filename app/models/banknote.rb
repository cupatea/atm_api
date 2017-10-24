class Banknote < ApplicationRecord
  enum kind: { fifty: 50, quarter: 25, ten: 10, five: 5, two: 2, one: 1 }

  validates :kind, :quantity, presence: true
  validates :kind, uniqueness: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :total, -> { kinds.map{ |key,value| public_send(key).take.quantity * value }.inject(&:+) }
end
