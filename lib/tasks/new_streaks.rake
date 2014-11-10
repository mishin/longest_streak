namespace :new_streaks do
  desc "Fetch Longest Streak for GitHub Users"
  task populate: :environment do
    rate_limit = 5000
    connection = Connection.new
    last = User.where.not(longest_streak: nil).maximum(:id)
    User.find_each(start: last, batch_size: 10) do |user|
      page = Page.new(user.username)
      if page.streak != "error"
        user.update_attribute(:longest_streak, page.streak)
      end
    end
  end
end
