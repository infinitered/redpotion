class Contributer
  # TODO: when cdq is included some events are not firing correctly.
  # this works like a CDQ model, but not using CDQ right now without CDQ we can
  # use create the feature we are trying to build here, but we need to sort out
  # the CDQ thing
  attr_accessor :name

  def initialize(properties)
    self.name = properties[:name]
  end

  def self.all
    @all ||= %w{twerth squidpunch GantMan shreeve chunlea markrickert}.collect do |name|
      Contributer.new(name: name)
    end
  end
end
