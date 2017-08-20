# frozen_string_literal: true

require 'support/use_case_example_service'

class UseCaseExampleTrigger
  def trigger(n)
    result = UseCaseExampleService.new.call(n)
    result.success { |data| return data }
    result.n_is_two { |data| return data }
    result.n_is_three { |data| return data }
    result.n_is_four { |data| return data }
  end
end
