class BaseDecorator < SimpleDelegator
  include ActionView::Helpers::TextHelper

  def self.wrap_all(collection)
    collection.map { |element| new(element) }
  end

  def initialize(model)
    @model = model
    super(model)
  end

  def ==(other)
    @model == other
  end
end
