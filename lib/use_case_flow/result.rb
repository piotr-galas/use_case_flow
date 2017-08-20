# frozen_string_literal: true

module UseCaseFlow
  class Result
    attr_reader :name

    def initialize(name, *args)
      @name = name
      @args = args
      @was_called = false

      define_singleton_method(name) do |&block|
        block.call(*@args)
        @was_called = true
      end

      define_singleton_method("#{name}?") do
        true
      end
    end

    def else
      yield unless @was_called
    end

    def else_fail!
      self.else { raise "unhandled Result '#{@name}' with args: #{@args.inspect}" }
    end

    # rubocop:disable Style/MethodMissing
    def method_missing(_method_name, *_args, &_block)
      false
    end

    def values
      @args
    end

    def value
      @args.first
    end
  end
end

class Success < UseCaseFlow::Result
  def initialize(*args)
    super(:success, *args)
  end
end

class Failure < UseCaseFlow::Result
  def failure?
    true
  end
end
