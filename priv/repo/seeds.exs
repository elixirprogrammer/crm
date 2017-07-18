# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Crm.Repo.insert!(%Crm.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Crm.{Repo, User, Contact, ContactGroup, Note}

Repo.delete_all User
(1..10) |> Enum.each(fn n ->
  User.reg_changeset(%User{}, %{
                        name: Faker.Name.title,
                        username: "usertest#{n}",
                        password: "password123",
                        password_confirmation: "password123"})
  |> Repo.insert!()
end)

groups = ["Family", "Work", "Designers", "Developers", "Leads", "Friends"]
Repo.delete_all ContactGroup
(1..10) |> Enum.each(fn n ->
  Enum.each(groups, fn(g) ->
    ContactGroup.changeset(%ContactGroup{user_id: n}, %{name: g})
    |> Repo.insert!()
  end)
end)

Repo.delete_all Contact
(1..10) |> Enum.each(fn u ->
  (1..50) |> Enum.each(fn _ ->
    Contact.changeset(%Contact{user_id: u}, %{
      name: Faker.Name.title,
      company: Faker.Company.name,
      email: Faker.Internet.free_email,
      phone: Faker.Phone.EnUs.phone,
      address: Faker.Address.street_address,
      contact_group_id: :rand.uniform(6)
    })
    |> Repo.insert!()
  end)
end)

Repo.delete_all Note
(1..10) |> Enum.each(fn u ->
  (1..50) |> Enum.each(fn c ->
    (1..5) |> Enum.each(fn _ ->
      Note.changeset(%Note{user_id: u, contact_id: c}, %{
        body: Faker.Lorem.paragraph(%Range{first: 1, last: 2})
      })
      |> Repo.insert!()
    end)
  end)
end)
