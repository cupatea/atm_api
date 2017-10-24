require 'active_interaction'

class Refill < ActiveInteraction::Base
  hash :banknotes do
    integer :'50', default: 0
    integer :'25', default: 0
    integer :'10', default: 0
    integer :'5',  default: 0
    integer :'2',  default: 0
    integer :'1',  default: 0
  end

  def execute
    _set_bank
    _perform_refill
    if _create_transaction.valid?
       @transaction
    else
       errors.merge! @transaction.errors
    end
  end

private

  def _set_bank
    @bank = {}
    banknotes.map{ |key,value| @bank[key.to_i] = value }
    @bank = @bank.reject{ |banknote, count| count.zero? }
  end

  def _perform_refill
    @bank.each do |key, value|
      banknote = Banknote.find_by_kind key
      banknote.update quantity: banknote.quantity + value if banknote
    end
  end

  def _create_transaction
    @transaction = Transaction.create kind: 'refill', banknotes: @bank
  end

end
