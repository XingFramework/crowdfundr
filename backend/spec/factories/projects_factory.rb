FactoryGirl.define do
  factory :project do
    name "The Xing Framework"
    description "A neat new integrated web development platform."
    deadline Date.today + 30.days
    goal 20000.00

    factory :project_with_pledges do
      transient do
        pledges_count 1
      end

      after(:create) do |project, evaluator|
        create_list(:pledge, evaluator.pledges_count, project: project)
      end
    end
  end
end
