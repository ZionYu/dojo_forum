namespace :dev do

  task fake_user: :environment do
    User.destroy_all
      
    url = "https://uinames.com/api/?ext&region=england"

    40.times do
      response = RestClient.get(url)
      data = JSON.parse(response.body)

    user = User.create!(
      name: data["name"],
      email: data["email"],
      remote_avatar_url: data["photo"],
      password: "12345678",
      introduction: "Hello! My name is #{data["name"]} #{FFaker::Tweet.body}"
      )
    end
    puts "have created #{User.count} fake users"
  end

  task fake_post: :environment do
    Post.destroy_all

    User.all.each do |user|
      5.times do |i|
        purview = ["All", "Friend", "Myself"]
        user.posts.create!(
          title:FFaker::Book.genre,
          content: FFaker::Lorem.sentence(50),
          status: "published",
          purview: purview.sample,
          viewed_count: rand(1..50)
        )
      end
    end

    Post.all.each do |post|
      rand(1..3).times do |i|
        PostCategory.create!(category: Category.all.sample, post: post)
      end
    end
    puts "have created #{Post.count} fake posts"
  end

  task fake_friend: :environment do
    Friendship.destroy_all

    User.all.each do |user|
      10.times do |i|
        user.friendships.create!(
          friend: User.all.where.not(id: user)[i],
          status: 'pending'
          )
      end
    end
    puts "have created #{Friendship.count} fake friends"
  end

  task fake_reply: :environment do
    Reply.destroy_all

    User.all.each do |user|
      rand(10..20).times do |post|
        post = Post.published.sample
        post.replies.create!(
          comment: FFaker::Lorem.sentence(10),
          user: user,
          created_at: FFaker::Time::between(Time.new(2018, 10, 07), Time.new(2018, 10, 13))
        )
      end
    end
    puts "have created #{Reply.count} fake replies"
  end

  task fake_collect: :environment do
    Collect.destroy_all

    User.all.each do |user|
      3.times do |post|
        post = Post.published.sample
        post.collects.create!(user: user)
      end
    end
    puts "have created #{Collect.count} fake collects"
  end

  task fake_all: :environment do
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_post'].execute
    Rake::Task['dev:fake_friend'].execute
    Rake::Task['dev:fake_reply'].execute
    Rake::Task['dev:fake_collect'].execute
  end

end