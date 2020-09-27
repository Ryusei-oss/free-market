FactoryBot.define do

  factory :user do
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

  factory :tanaka, class: User do
    last_name              {"田中"}
    first_name             {"二郎"}
    last_name_kana         {"たなか"}
    first_name_kana        {"じろう"}
    birthday               {"1999-1-1"}
    nickname               {"abec"}
    tell                   {"09099999999"}
    email                 {"aaa@gmail.com"}
    password              {"1111111"}
    password_confirmation {"1111111"}
  end

end