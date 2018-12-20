# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot'
#Dir[Rails.root.join('spec/factories/*.rb')].each {|f| require f }

GitLog.delete_all
730.times do
  git_log = FactoryBot.build(:sequencial_git_log)
  git_log.author_name = "tanaka"
  git_log.save
  git_log = FactoryBot.build(:sequencial_git_log)
  git_log.author_name = "suzuki"
  git_log.save
  git_log = FactoryBot.build(:sequencial_git_log)
  git_log.author_name = "sato"
  git_log.save
end
