require 'yaml'

class TroopConfigs
  def initialize file
    @file = file
    @config = config = YAML.load_file file

    last_hash = config.find { |x|
      x.has_key? :last rescue false
    }
    if last_hash
      @last = last_hash[:last]
      config.delete last_hash
    end


    @all = config.map { |entry|
      case entry
      when String
        Troop.new name: entry, command: entry
      when Hash
        raise unless entry.size == 1
        entry = entry.to_a.first
        Troop.new name: entry[0], command: entry[1]
      else raise
      end
    }
  end

  def each_ordered &block
    all = @all.dup

    if @last
      last = all.find { |x| x.named? @last }
      all.delete last
      all.unshift last
      all.each &block
    else
      all.each &block
    end
  end

  def used troop
    @last = troop
    cfg = @config + [ { last: troop.name } ]
    File.write @file, YAML.dump(cfg)
  end


  class Troop
    attr_reader :name, :command

    def initialize(name: , command: )
      @name = name
      @command = command
    end

    def named? name
      @name == name
    end
  end
end
