RSpec::Matchers.define :contain_decorated do |*undecorated_objects|

  failure_messages = []

  match do |decorated_objects|
    extracted_objects = decorated_objects.map(&:__getobj__)

    decorator_matcher = all(be_a(decorator_class))
    failure_messages << decorator_matcher.failure_message unless decorator_matcher.matches?(decorated_objects)

    extracted_matcher = contain_exactly(*undecorated_objects)
    failure_messages << extracted_matcher.failure_message unless extracted_matcher.matches?(extracted_objects)

    failure_messages.empty?
  end

  chain :with, :decorator_class

  failure_message do |_actual|
    failure_messages.join("\n")
  end

end
