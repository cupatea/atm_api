class Transaction < ApplicationRecord
  enum kind: [:refill, :withdraw]

  validates :kind,      presence: true
  validates :amount,    presence: true,  if: -> { kind == "withdraw" }
  validates :banknotes, presence: true,  if: -> { kind == "refill"   }
  before_save :save_amount,              if: -> { kind == "refill"   }


  def save_amount
    self.amount = banknotes.map{ |banknote,count| banknote.to_i * count.to_i }.inject(&:+)
  end
end
