RailsAdmin.config do |config|
  ### Popular gems integration

  config.authorize_with do |controller|
    unless current_frontend_user.try(:is_admin?)
      flash[:error] = 'У Вас недостаточно прав'
      redirect_to '/'
    end
  end

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :frontend_user
  end
  config.current_user_method(&:current_frontend_user)


  config.main_app_name = ['Админка', 'управляй:)']

  config.actions do
    dashboard # mandatory
    index # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    dropzone do
      only %w(News Tournament Team Post)
    end
    nested_set do
      visible do
        %w( Category NewsCategory TournamentCategory StaticPage ).include? bindings[:abstract_model].model_name
      end
    end

  end

  config.model 'Category' do
    visible false
    label 'Категория'
    label_plural 'Категории'
    navigation_icon 'icon-folder-open'
  end

  config.model 'Attachment' do
    visible false
  end

  config.model 'Banner' do
    visible false
    label 'Баннер'
    label_plural 'Баннеры'
  end

  config.model 'Ckeditor::Picture' do
    visible true
    label 'Картинка'
    label_plural 'Картинки'
    include_all_fields
  end

  config.model 'Ckeditor::Picture' do
    visible true
    label 'Картинка'
    label_plural 'Картинки'
    include_all_fields
    exclude_fields :type, :created_at, :updated_at
  end

  config.model 'NewsCategory' do
    object_label_method :title
    label 'Категория новостей'
    label_plural 'Категории новостей'
    navigation_icon 'icon-folder-open'

    field :content, :ck_editor

    field :has_nesting do
      visible false
    end

    field :parent do
      visible false
    end

    field :children do
      visible false
    end

    list do
      field :name
    end
    include_fields :name, :parent, :children, :slug, :main_image, :content
  end

  config.model 'StaticPage' do
    object_label_method :title

    label 'Статическая страница'
    label_plural 'Статические страницы'
    navigation_icon 'icon-folder-open'

    field :parent do
      visible false
    end

    field :children do
      visible false
    end

    field :content, :ck_editor

    list do
      field :name
    end

    include_fields :name, :slug, :main_image, :parent, :children, :has_nesting, :template
  end

  config.model 'Impression' do
    visible false
  end

  config.model 'Role' do
    parent User
    label 'Роль'
    label_plural 'Роли'
    navigation_icon 'icon-folder-open'
    include_all_fields
    exclude_fields :created_at, :updated_at
  end

  config.model 'Career' do
    parent Player
    label 'Карьера'
    label_plural 'Карьеры'
    navigation_icon 'icon-folder-open'
    include_all_fields
    exclude_fields :created_at, :updated_at
  end

end
