#
# consider tests at the end of file
# as usage examples and docs
#
module OneOf

  # some preprocessing
  #
  # possibilities - { symbol: lambda/proc, , timeout: n }
  #
  def one_of possible

    if secs = possible[:timeout]
      possible = possible.dup
      was = Time.now
      possible[:timeout] = -> {
        Time.now - was >= secs
      }
    end

    _one_of possible
  end


  def _one_of possible
    loop do
      possible.each_pair { |name, block|

        found = case block.arity
                when 1 then instance_eval &block
                when 0 then instance_eval { block.call }
                else raise 'wut do ya expect mah?'
                end

        return name if found
      }
    end
  end

end

if __FILE__ == $0
  require 'maxitest/autorun'

  describe OneOf do
    it 'runs until one option is true and returns its name' do
      extend OneOf

      right = %w[ a b c ].sample

      name = one_of\
        a: -> { @name == 'a' },
        b: -> { @name == 'b' },
        c: -> { @name == 'c' },
        x: -> {
          @name = right if rand(1..100) == 1
          false
        }

      name.must_equal right.to_sym
    end

    describe 'possibilites' do
      it 'is a hash of symbol => lambda/proc with 0..1 arity, that are instance_eval-ed' do
        extend OneOf
        got = []

        one_of\
          zero: -> { got << self; false },
          one:  -> x { got << self; got << x; false },
          finish:   -> { true }
        got.must_equal [self] * 3
      end

      it 'can have a :timeut key and a value - seconds' do
        extend OneOf

        was = Time.now
        secs = 0.01

        got = one_of\
          any: -> { false },
          timeout: secs

        got.must_equal :timeout
        (Time.now - was).must_be :>=, secs
      end
    end
  end
end
