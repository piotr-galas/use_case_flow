# frozen_string_literal: true

require 'use_case_flow'

class UseCaseExampleService
  def call(n)
    return Success.new('one') if n == 1
    return Failure.new(:n_is_two, :two) if n == 2
    return Failure.new(:n_is_three, :three) if n == 3
    Failure.new(:n_is_four, :four) if n == 4
  end
end
