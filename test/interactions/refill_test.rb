require 'test_helper'

class RefillTest < ActiveSupport::TestCase

  test 'should perform refill' do
    outcome = Refill.run banknotes: { "1"=>1, "2"=>1, "5"=>1, "10"=>1, "25"=>1, "50"=>1 }
    assert outcome.errors.blank?
    assert_equal outcome.result[:amount], 93
  end

  test 'should  perform refill only for valid banknotes kinds ' do
    outcome = Refill.run banknotes: { "1"=>1, "5"=>2, "13"=>3 }
    assert outcome.errors.blank?
    assert_equal outcome.result[:amount], 11
  end

  test 'should not perform refill when all banknotes kinds are invalid' do
    outcome = Refill.run banknotes: { "6"=>1, "13"=>1 }
    assert_not outcome.errors.blank?
    assert_equal outcome.errors.full_messages.to_sentence, "Result is negative.Banknotes must be present to perform refill"
  end

  test 'should  perform refill only for valid banknotes values ' do
    outcome = Refill.run banknotes: { "1"=>1, "25"=> -5 }
    assert outcome.errors.blank?
    assert_equal outcome.result[:amount], 1
  end

  test 'should not perform refill when all banknotes values are invalid' do
    outcome = Refill.run banknotes: { "1"=>1, "25"=>"wahaha" }
    assert_not outcome.errors.blank?
    assert_equal outcome.errors.full_messages.to_sentence, "Banknotes has an invalid nested value (\"25\" => \"wahaha\")"
  end
end
