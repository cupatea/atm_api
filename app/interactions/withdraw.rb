require 'active_interaction'

class Withdraw < ActiveInteraction::Base
  integer :amount
  hash :bank do
    integer :'50'
    integer :'25'
    integer :'10'
    integer :'5'
    integer :'2'
    integer :'1'
  end

  def execute
    _set_useful_bank
    _find_simple_result
    _find_complicated_result unless _check_result @result
    _check_result(@result) ? @result : nil
  end

private

  def _set_useful_bank
    @useful_bank = {}
    bank.map{ |key,value| @useful_bank[key.to_i] = value }
    @useful_bank = @useful_bank.reject{ |banknote, count| count.zero? or banknote > amount }
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
    (1 .. @useful_bank.keys.length - 1).each do |num|
      @useful_bank.keys.combination(num).to_a.each do |combination|
        result = _modified_greedy_algorithm amount, @useful_bank, combination
        @result = result if _check_result result
      end
      break if _check_result @result
    end
  end
  def _find_simple_result
    @result = _greedy_algorithm amount, @useful_bank
  end
end
