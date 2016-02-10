FactoryGirl.define do
  factory :project do
    name "The Xing Framework"
    description "A neat new integrated web development platform."
    deadline Date.today + 30.days
    goal 20000.00
    association :user
  end
end
