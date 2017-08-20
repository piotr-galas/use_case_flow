# frozen_string_literal: true

require 'spec_helper'
require 'support/use_case_example_trigger'

RSpec.describe UseCaseFlow do
  it 'return proper values in trigger' do
    expect(UseCaseExampleTrigger.new.trigger(1)).to eq 'one'
    expect(UseCaseExampleTrigger.new.trigger(2)).to eq :two
    expect(UseCaseExampleTrigger.new.trigger(3)).to eq :three
    expect(UseCaseExampleTrigger.new.trigger(4)).to eq :four
  end

  it 'return proper values in service' do
    expect(UseCaseExampleService.new.call(1).name).to be :success
    expect(UseCaseExampleService.new.call(2).name).to be :n_is_two
    expect(UseCaseExampleService.new.call(3).name).to be :n_is_three
    expect(UseCaseExampleService.new.call(4).name).to be :n_is_four
  end
end
