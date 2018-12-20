class GitLogImporter
  def self.execute(args=nil)
    args.each do |path|
      git_log_text = ""
      Dir.chdir(path) do
        git_log_text = `git log --stat --pretty=format:"%an, %ad, %cn, %cd, %s" --date=format:'%Y-%m-%d'`
      end
      self.import_log git_log_text
    end
  end

  private
  def self.import_log(log=nil)
    cnt = 0
    first_line, last_line = "", ""

    log.each_line do |str|
      first_line = str.chomp if cnt == 0
      if str.length > 1
        cnt += 1
      else
        # コミット毎の最初の行と最終行をログとして保存する
        puts self.save_git_log(first_line, last_line)
        cnt = 0
      end
      last_line = str
    end
  end
  def self.save_git_log(first_line=nil, last_line=nil)
    commit_inf = first_line.split(", ")
    loc_inf = last_line.split(", ").map! {|item| item.strip.split(" ")[0].to_i }
    plus_loc = loc_inf.length > 1 ? loc_inf[1] : 0 
    minus_loc = loc_inf.length > 2 ? loc_inf[2] : 0 

    git_log = GitLog.new
    git_log.author_name = commit_inf[0]
    git_log.author_date = commit_inf[1]
    git_log.contributor_name = commit_inf[2]
    git_log.contributor_date = commit_inf[3]
    git_log.comment = commit_inf[4]
    5.upto(commit_inf.length - 1) {|i| git_log.comment << ", #{commit_inf[i]}" }
    git_log.plus_loc = plus_loc
    git_log.minus_loc = minus_loc
    git_log.change_loc = plus_loc + minus_loc
    git_log.save

    git_log.inspect
  end
end

return if ARGV.length == 0
GitLog.delete_all
GitLogImporter.execute ARGV
