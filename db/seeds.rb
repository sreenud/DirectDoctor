# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

roles = ['admin', 'doctor', 'patient', 'author', 'data_entry', 'guest']
existing_roles = Role.all.map(&:name)

roles.each do |role|
  unless existing_roles.include?(role)
    Role.create!(name: role)
  end
end

unless User.find_by_email("srinivasavarma.d@gmail.com")
  user = User.new(
    full_name: "Srinivasa Varma",
    first_name: "Srinivasa",
    last_name: "Varma",
    email: "srinivasavarma.d@gmail.com",
    password: 'varma123',
  )
  user.add_role(:admin)
  user.save!
end

unless Category.find_by_name("Concierge")
  category = Category.new(
    name: "Concierge",
    slug: "concierge",
  )
  category.save!
end
