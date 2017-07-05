defmodule Crm.Repo do
  use Ecto.Repo, otp_app: :crm
  use Kerosene, per_page: 10
end
