class ServiceCall
  attr_accessor :data, :errors

  def initialize(data)
    @data = data.new
    @errors = []
  end

  def success?
    @errors.blank?
  end
end
