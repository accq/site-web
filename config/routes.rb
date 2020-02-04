Rails.application.routes.draw do
  devise_for :users
  root 'home#show'
  get '/accueil', to: "home#show"
  get '/lappel', to: 'events#show', id: 2, as: :lappel
  get '/signez-le-manifeste', to: "home#manifest", as: :manifest
  get '/deuxieme-rencontre-nationale', to: "home#deuxieme_rencontre_nationale"
  get '/constat', to: "home#constat", as: :constat
  get '/nous-joindre', to: "home#nous_joindre", as: :nous_joindre
  get '/mission', to: "home#mission", as: :mission
  get '/mission/notre-vision', to: "home#vision", as: :notre_vision
  get '/mission/notre-moyen', to: "home#moyen", as: :notre_moyen
  get '/mission/nous-rejoindre', to: "home#mission_nous_rejoindre", as: :mission_nous_rejoindre
  get '/education/bibliotheque', to: "home#bibliotheque", as: :bibliotheque
  get '/education/mediatheque', to: "home#mediatheque", as: :mediatheque
  get '/medias/couverture-mediatique', to: "home#media_coverage", as: :media_coverage
  get '/medias/communiques-de-presse', to: "home#press_releases", as: :press_releases
  get '/education/outils-de-promotion', to: "home#promotional_tools", as: :promotional_tools
  get '/education/sondage', to: "home#sondage", as: :sondage
  get '/a-propos', to: "home#a_propos", as: :a_propos
  get '/mumble', to: "home#mumble", as: :mumble
  get '/medias', to: "home#media", as: :media
  get '/devenir-partenaire-actif', to: "home#partenaire_actif", as: :partenaire_actif
  get '/constitution', to: "home#constitution", as: :constitution
  get '/engagement-candidats', to: "home#engagement_candidats", as: :engagement_candidats
  get '/projet-de-loi', to: "home#projet_de_loi", as: :projet_de_loi
  get '/projet-de-loi-v1', to: "home#projet_de_loi_v1", as: :projet_de_loi_v1
  get '/realisations', to: "home#realisations", as: :realisations
  get '/assemblee-virtuelle', to: "home#assemblee_virtuelle", as: :assemblee_virtuelle
  get '/constitution-citoyenne', to: redirect("http://inm.qc.ca/docs/CONSTITUONS/constitution_citoyenne_quebec_INM.pdf?fbclid=IwAR35h7tVwDvpbUZ6vI6jTo65YtPJwHJmH2LrLno5kiQW89z7gg3LWCxDlwA"), as: :constitution_citoyenne_quebec
  get '/constituons', to: "home#constituons", as: :constituons
  get '/rencontres-informatives', to: "home#local_workshops", as: :local_workshops
  get '/obnl', to: "home#obnl", as: :obnl
  get '/statutsetreglements', to: "home#statuts_reglements", as: :statuts_reglements
  get '/download', to: "home#download", as: :download
  get '/pour-devenir-membre', to: "home#pour_devenir_membre", as: :pour_devenir_membre
  resources :workshops, path: "atelier-constituant-virtuel" do
    resources :workshop_registrations, path: "inscriptions"
  end

  resources :acrq, controller: :hives , as: :hives do
    resources :hive_meetings
  end

  resource :organigramme, controller: :structure, as: :structure do
  end

  resources :membres, controller: :members, as: :members, only: :create do

  end

  resources :evenements, controller: :events, as: :events, only: :show do
    resources :participants, only: [:create, :index] do
    end
  end

  get '/signatures-manifeste' => 'members#index', as: :signatures


  resources :circonscriptions, controller: :districts, as: :districts do
    resources :engagements
  end
  resources :engagements, only: :index
  namespace :admin do
    resources :hives, shallow: true do
      resources :hive_contacts
      resources :hive_meetings
    end
    resources :workshops, shallow: true do
      resources :workshop_registrations
    end
    resources :events, shallow: true do
      resources :participants do
      end
    end
    resources :members do
      member do
        put :approve
        put :disapprove
      end
    end

    resources :engagements do

    end

    resources :candidates do
      get :autocomplete_index, on: :collection
    end
    root 'home#show'
  end
end
