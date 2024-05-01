namespace :users do
  desc 'Create users'
  task create_users: :environment do
    User.create!(
      [
        {
          email: 'test1@gmail.com',
          password: 'test1@123'
        },
        {
          email: 'test2@gmail.com',
          password: 'test2@123'
        },
        {
          email: 'bob@gmail.com',
          password: 'bob@123'
        }
      ]
    )
    puts 'Users created successfully.'
  end
end
