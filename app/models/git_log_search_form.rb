class GitLogSearchForm
  include ActiveModel::Model

  attr_accessor :search_type, :since, :until
end
