
unless User.where(login: 'admin').exists?
  User.create!(
    {
      login: 'admin',
      admin: true,
      password: 'admin',
      password_confirmation: 'admin',
      username: 'admin',
      email: 'admin@mail.com'
    }
  )
end

unless User.where(login: 'user').exists?
  User.create!(
    {
      login: 'user',
      admin: false,
      password: 'user',
      password_confirmation: 'user',
      username: 'user',
      email: 'user@mail.com'
    }
  )
end