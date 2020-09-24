FactoryBot.define do

  factory :user do
    id {1}
    last_name              {"阿部"}
    first_name             {"太朗"}
    last_name_kana         {"あべ"}
    first_name_kana        {"たろう"}
    birthday               {"1999-1-1"}
    nickname               {"abec"}
    tell                   {"09099999999"}
    email                 {"kkk@gmail.com"}
    password              {"000000000"}
    password_confirmation {"000000000"}
  end

end