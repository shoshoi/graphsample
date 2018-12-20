require "date"

class AuthorsController < ApplicationController
  def index
    @search_form = GitLogSearchForm.new
    @search_form.since = '2005-01-01'
    @search_form.until = Time.new.strftime("%Y-%m-%d")
    @chart_data = GitLog.order("author_date ASC").order("author_name ASC").group("author_name").group("strftime('%Y年%W週',author_date)").sum("change_loc")
  end
  def search
    #@search_form = GitLogSearchForm.new
    @search_form = GitLogSearchForm.new(git_log_search_form_params)

    search_type = @search_form.search_type
    search_since = @search_form.since
    search_until = DateTime.parse(@search_form.until) + 1
    search_since = '2005-01-01' if search_since.blank?
    search_until = '2018-10-10' if search_until.blank?
    case search_type
      when 'year' then
        date_group = "strftime('%Y-01-01 00:00:00',author_date)"
      when 'month' then
        date_group = "strftime('%Y-%m-01 00:00:00',author_date)"
      when 'date' then
        date_group = "strftime('%Y-%m-%d 00:00:00',author_date)"
    end

    @chart_data = GitLog.where("author_date BETWEEN ? AND ?", search_since, search_until).order("author_date ASC").order("author_name ASC").group("author_name").group(date_group).sum("change_loc").reduce({}) do |result, (key, value)|
      author_name, author_date = key
      result[author_name] ||= {}
      result[author_name][author_date] = value
      result
    end
    #@chart_data2 = GitLog.where("author_date BETWEEN ? AND ?", search_since, search_until).order("author_date ASC").group(date_group).sum("change_loc")
    #chart_array = @chart_data2.to_a
    #chart_array.each do |item|
    #  @chart_data[["合計", "#{item[0]}"]] = item[1]
    #end

    @array = []
    @chart_data[@chart_data.keys[0]].each do |key, value|
      obj = {}
      obj["y"] = value
      obj["t"] = key
      @array.push obj
    end

    chart_dataset = []
    data = {}
    data[:label] = 'label'
    data[:data] = @array
    chart_dataset.push data
    gon.data = @array
    render :action => "index"
  end

  def git_log_search_form_params
    params.require(:git_log_search_form).permit(:since, :until, :search_type)
  end
end
