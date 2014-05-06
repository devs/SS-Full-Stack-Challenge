FactoryGirl.define do
  factory :user do
    name     "Finn"
    email    "finn@dog.com"
    password "password"
    password_confirmation "password"
  end
end