RSpec::Matchers.define :be_a_decorated do |undecorated_object|

  failure_messages = []

  match do |decorated_object|
    decorator_matcher = be_a(decorator_class)
    failure_messages << decorator_matcher.failure_message unless decorator_matcher.matches?(decorated_object)

    extracted_matcher = be(undecorated_object)
    failure_messages << extracted_matcher.failure_message unless extracted_matcher.matches?(decorated_object.__getobj__)

    failure_messages.empty?
  end

  chain :with, :decorator_class

  failure_message do |_actual|
    failure_messages.join("\n")
  end

end
