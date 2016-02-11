FactoryGirl.define do
  factory :pledge do
    amount 150.00
    comment "I support this project"
    association :project, factory: :project
  end
end
