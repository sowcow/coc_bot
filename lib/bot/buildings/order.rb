module Buildings

  class Order
    def initialize unused: false, &block
      @unused = unused
      if unused
        @perform = DO_NOTHING
      else
        raise ORDER_NOT_IMPLEMENTED unless block
        @perform = block
      end
    end
    DO_NOTHING = proc { }
    ORDER_NOT_IMPLEMENTED =\
      "hey, this order isn't implemented!"

    def unused?; @unused end

    def perform somewhere
      somewhere.instance_eval &@perform
    end
  end
end
