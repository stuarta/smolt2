Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "root#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "healthz" => "rails/health#show", as: :rails_health_check
  # Job Dashboard
  mount MissionControl::Jobs::Engine, at: "/jobs"

  scope "/tokens" do
    get "token_json",       to: "legacy/token#token_json"
    get "admin_token_json", to: "legacy/token#admin_token_json"
  end
  scope "/client" do
    post "add_json",            to: "legacy/client#add_json"
    post "delete",              to: "legacy/client#delete"
    get "show",                 to: "legacy/client#show"
    # FIXME: show_all does normally return more data than show
    get "show_all",             to: "legacy/client#show"
    get "pub_uuid",             to: "legacy/client#pub_uuid"
    get "regenerate_pub_uuid",  to: "legacy/client#regenerate_pub_uuid"
  end
  get "reports/recent"
  get "reports/search_profiles"
  get "reports/view_profile"
  get "reports/view_profiles"
  get "reports/search_devices"
  get "reports/view_device"
  get "reports/view_devices"
  get "reports/search"
  get "stats/hosts"
  get "stats/devices"
end
