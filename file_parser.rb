  class FileParser
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def inputs
      return [] unless file_present? || File.read(name)
      return [] unless File.read(name)
      parse
    end

    private

    def file_present?
      return false unless name
      File.file?(name)
    end

    def parse
      traffic_data = []

      IO.foreach(name) do |line|
        line = line.strip
        unless line.empty?
          traffic_data << line
        end
      end
      traffic_data
    end
  end