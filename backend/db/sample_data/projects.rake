namespace :db do
  namespace :sample_data do
    namespace :projects do

      desc "Remove all projects"
      task :wipe do
        Project.delete_all
      end

      desc "Populate the DB with fake projects."
      task :load do
        return if Project.count > 0
        10.times do |n|
          Project.create(
            :name =>        Faker::Lorem.words(2..5).join(" ").titleize,
            :description => Faker::Lorem.sentences(1..6).join(" "),
            :deadline =>    (Date.today + rand(20).days).end_of_day,
            :goal =>        (2 + rand(20)) * 5000.00,
            :user =>        User.first
          )
        end
      end
    end

    task :wipe => 'projects:wipe'
    task :load => 'projects:load'
  end
end
