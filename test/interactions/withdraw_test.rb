require 'test_helper'

class WithdrawTest < ActiveSupport::TestCase

  test 'should perform withdraw when all banknotes are present' do
    outcome = Withdraw.run amount: 123
    assert outcome.errors.blank?
    assert_equal outcome.result, { 50=>2, 10=>2, 2=>1, 1=>1 }
  end

  test 'should perform withdraw when few kinds of banknotes are absent' do
    Banknote.one.update   quantity: 0
    Banknote.two.update   quantity: 0
    Banknote.five.update  quantity: 0
    outcome = Withdraw.run amount: 1115
    assert outcome.errors.blank?
    assert_equal outcome.result, { 50=>21, 25=>1, 10=>4 }
  end

  test 'should not perform withdraw if amount greater than total' do
    outcome = Withdraw.run amount: Banknote.total + 1
    assert_not outcome.errors.blank?
    assert_equal outcome.errors.full_messages.to_sentence, "Amount must be less than #{Banknote.total}"
  end

  test 'should not perform withdraw if there is a lack of banknotes' do
    Banknote.one.update_all quantity: 0
    Banknote.two.update_all quantity: 0
    outcome = Withdraw.run amount: 123
    assert_not outcome.errors.blank?
    assert_equal outcome.errors.full_messages.to_sentence, "Result is negative.There is a lack of banknotes to perform withdraw"
  end

  test 'should not perform withdraw if amount is not valid' do
    outcome = Withdraw.run amount: 'wahaha'
    assert_not outcome.errors.blank?
    assert_equal outcome.errors.full_messages.to_sentence, "Amount is not a valid integer"
  end
end
