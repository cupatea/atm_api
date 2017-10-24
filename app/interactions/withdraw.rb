require 'active_interaction'

class Withdraw < ActiveInteraction::Base
  integer :amount

  def execute
    _set_bank
    _find_simple_result
    _find_complicated_result unless _check_result @result
    if _check_result @result
       _reduce_banknotes_quantity
       _create_transaction
       @result
    else
       nil
    end
  end

private

  def _set_bank
    @bank = {}
    Banknote.kinds.map{ |key,value| @bank[value] = Banknote.public_send(key).take.quantity }
    @bank = @bank.reject{ |banknote, count| count.zero? or banknote > amount }
  end

  def _check_result result
    result.to_a.map{ |banknote,count| banknote * count }.inject(&:+) == amount
  end

  def _greedy_algorithm amount, bank, result = {}
    bank.each do |banknote,count|
      result[banknote] = amount / banknote < count ? amount / banknote : count
      amount -= result[banknote] * banknote
    end
    result
  end

  def _modified_greedy_algorithm amount, bank, combination
    result = @result.reject{ |banknote, count| not combination.include? banknote}
    combination.each do |value|
      bank = bank.reject{ |banknote, count| banknote == value }
      result[value] = @result[value] > 1 ? @result[value] - 1 : 1
      amount -= result[value] * value
    end
     _greedy_algorithm amount, bank, result
  end

  def _find_complicated_result
    (1 .. @bank.keys.length - 1).each do |num|
      @bank.keys.combination(num).to_a.each do |combination|
        temporary_result = _modified_greedy_algorithm amount, @bank, combination
        @result = temporary_result if _check_result temporary_result
      end
      break if _check_result @result
    end
  end

  def _find_simple_result
    @result = _greedy_algorithm amount, @bank
  end

  def _reduce_banknotes_quantity
    @result.map{ |key,value| Banknote.find_by_kind(key).update quantity: value }
  end

  def _create_transaction
    Transaction.create amount: amount, banknotes: @result
  end

end
