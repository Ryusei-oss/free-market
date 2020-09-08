FactoryBot.define do

  factory :image do
    image   {File.open("#{Rails.root}/spec/images/test1.jpg")}
  end

end