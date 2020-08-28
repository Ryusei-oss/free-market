FactoryBot.define do

  factory :user do
    last_name              {"abe"}
    first_name             {"taro"}
    last_name_kana         {"abe"}
    first_name_kana        {"taro"}
    birthday               {"1999/1/1"}
    nickname               {"abec"}
    tell                   {"09099999999"}
    email                 {"kkk@gmail.com"}
#     password              {"00000000"}
#     password_confirmation {"00000000"}
  end

end