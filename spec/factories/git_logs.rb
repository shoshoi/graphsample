FactoryBot.define do
  sequence :sequencial_date do |n| 
    (Date.new(2005, 1 , 1) + (n/3.to_f).ceil).to_s
  end 

  factory :git_log do
    author_name { "tanaka" }
    author_date { "#{DateTime.now.to_s}" }
    contributor_name { "tanaka" }
    contributor_date { "#{DateTime.now.to_s}" }
    change_loc { "10" }
    plus_loc { "10" }
    minus_loc { "10" }
    comment { "comment" }
  end

  factory :sequencial_git_log, class: GitLog do |n|
    author_name { "tanaka" }
    author_date { generate :sequencial_date }
    contributor_name { "tanaka" }
    contributor_date { author_date }
    change_loc { "#{plus_loc + minus_loc}" }
    plus_loc { rand(1..200) }
    minus_loc { rand(1..200) }
    comment { "comment" }
  end

end
