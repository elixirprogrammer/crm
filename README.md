# CRM Made By [Anthony Gonzalez](https://github.com/boilercoding/ "Anthony Gonzalez Github")

[Crm](https://elixir-phoenix-crm.herokuapp.com/ "Crm") contact manager system made with elixir/phoenix and [Drab](https://github.com/grych/drab "Drab") to handle the browser user interface.

![Crm Homepage](/crm-readme-img/crm-homepage.png "Crm Homepage")

### [_See Crm on Heroku here_](https://elixir-phoenix-crm.herokuapp.com/ "Crm")

You are encouraged to create an account, but if you want to get a feel of Crm first, you may log in with any of the following users (all having a password of `password123`):

- usertest1
- usertest2
- usertest3
- usertest4
- usertest5
- usertest6
- usertest7
- usertest8
- usertest9
- usertest10


## Main Features

1. [Log in required to view content](#log-in-required "Log In Required")
1. [Edit Account](#Edit-Account "Edit Account")
1. [Contacts](#contacts "Contacts")
1. [Notes](#notes "Notes")
1. [Pagination](#pagination "Pagination")
1. [My Groups](#my-groups "My Groups")
1. [Uploads](#uploads "Uploads")

## Details of Main Features

#### Log In Required

![Crm Landing Page](/crm-readme-img/crm-landing-page.png "Crm Landing Page")
![Crm Log in Page](/crm-readme-img/crm-login.png "Crm Log in Page")

In order to use the app you need to be an authenticated user, otherwise you will only see the landing page. I didn't use any packages, I made the authentication from scratch.

#### Edit Account

![Crm Edit Account Page](/crm-readme-img/crm-edit-account.png "Crm Edit Account Page")
Users have the ability to edit their accounts.


#### Contacts

![Crm Add Contact Page](/crm-readme-img/crm-new-contact.png "Crm Add Contact Page")

Logged in users can create contacts and groups to associate the contacts so they can filter by groups. When creating a new contact users have the ability to create groups and the drop down where you can associate the contact to a group will be automatically updated thanks to the use of [Drab](https://github.com/grych/drab "Drab") for realtime updates. Also you users can search for contacts.


#### Notes

![Crm View Contact Page](/crm-readme-img/crm-view-contact.png "Crm View Contact Page")

When viewing a contact users can add notes associated to that contact, delete and edit notes all done with [Drab](https://github.com/grych/drab "Drab") for realtime updates.


#### Pagination

Pagination for contacts and notes are done with the [Kerosene](https://github.com/elixirdrops/kerosene "Kerosene") package.


#### My groups

![Crm My Groups Page](/crm-readme-img/crm-manage-groups.png "Crm My Groups Page")

Users can delete groups.


#### Uploads

Users can upload avatar for contacts, it's done with the packages [Arc](https://github.com/stavro/arc "Arc"), [Arc.Ecto](https://github.com/stavro/arc_ecto "Arc Ecto").

Note: Uploads won't work in heroku because I'm using local storage.

---

If you've made it through reading all this, congratulation...now you really should head over to [**_Crm_**](https://elixir-phoenix-crm.herokuapp.com/ "Crm").

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).
