# encoding: utf-8
#
require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Yaponama2012
  class Application < Rails::Application
    
    # TODO Разобраться более тщательно, т.к. полагаю, что это могут делать подключаемые гемы автоматически
    # Generators
    #config.generators do |g|
    #  g.template_engine :slim
    #  g.test_framework :rspec
    #  g.view_specs false
    #  g.helper_specs false
    #  #g.form_builder :simple_form
    #  g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    #end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/extras)


    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Moscow'
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # config.active_record.whitelist_attributes = true
 
    # Enable the asset pipeline
    config.assets.enabled = true

    # Autoload ckeditor models folder
    # config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    # User
    config.user_creation_reason = { 
      'email' => 'Прислал e-mail',
      'session' => 'Посетил сайт',
      'merge' => 'Образовался в результате объединения',
      'manager' => 'Создан менеджером'
    }

    # Names
    config.user_name_creation_reason = {
      'email' => 'Автоматически заполнено из e-mail',
      'addressee' => 'В процессе оформления заказа (получатель)',
      'self' => 'Представился на сайте'
    }
    # Orders
    config.orders_status = {
      'all' => {
        'real' => false,
        'title' => "Все",
        'hint' => "Все заказы, находящиеся в разных статусах."
      },
      'stock' => {
        'real' => true,
        'title' => "Укомплектован",
        'hint' => "Заказ полностью получен. Необходимо оповестить клиента о возможности забора или необходимо отправить."
      },
      'cancel' => {
        'real' => true,
        'title' => "Недоукомплектован",
        'hint' => "Произошел отказ хотя бы по одной из позиций."
      },
      'complete' => {
        'real' => true,
        'title' => 'Закрыт [TODO]',
        'hint' => 'Заказ выполнен, добавление в заказ товаров невозможно.'
      }

    }

    # Products
    config.products_status = {
      'all' => {
        'real' => false,
        'title' => "Все",
        'hint' => "Все товары, находящиеся в разных статусах.",
        'badge' => ''
      },
      'active' => {
        'real' => false,
        'title' => 'Активн.',
        'hint' => 'Товары по которым необходима дальнейшая работа и фигурируют деньги.',
        'badge' => ''
      },
      'checked' => {
        'real' => false,
        'title' => "Отмеч.",
        'hint' => "Товары, отмеченные галочкой на всех вкладках.",
        'badge' => ''
      },
      'incart' => {
        'real' => true,
        'title' => 'В корзине',
        'action' => 'Переместить в корзину',
        'hint' => 'Товар находится в корзине клиента. Необходимо подтолкнуть клиента к заказу.',
        'badge' => '1'
      },
      'inorder' => { 
        'real' => true,
        'title' => 'Сформ.',
        'action' => 'Сформировать в заказ покупателя',
        'hint' => 'Товар в заказе, но не запущен в работу по причине правила предоплаты. (Выражен в процентах от 0% до 100%).',
        'badge' => '2'
      },
      'ordered' => {
        'real' => true,
        'title' => 'Оплач.',
        'action' => 'Отметить как оплаченный',
        'hint' => 'Заказ запущен, необходимый процент (от 0% до 100%) от суммы товаров заблокирован.',
        'badge' => '3'
      },
      'pre_supplier' => {
        'real' => true,
        'title' => "Заблок.",
        'action' => 'Заблокировать отмену статуса оплаты',
        'hint' => "Необходимо отправить в заказ поставщику. Отказ клиента по этим товарам уже невозможен.",
        'badge' => '4'
      },
      'post_supplier' => {
        'real' => true,
        'title' => "Заказан",
        'action' => 'Отметить как заказанный у поставщика',
        'hint' => "Товар заказан у поставщика, ожидается поступление.",
        'badge' => '5'
      },
      'stock' => {
        'real' => true,
        'title' => "Получ.",
        'action' => 'Получен от поставщика',
        'hint' => "Товар получен от поставщика.",
        'badge' => '6'
      },
      'complete' => {
        'real' => true,
        'title' => "Выдан",
        'action' => "Выдать клиенту",
        'hint' => "Товар выдан клиенту.",
        'badge' => ''
      },
      'cancel' => {
        'real' => true,
        'title' => "Отказ",
        'action' => 'Отказать покупателю',
        'hint' => "Отказ по товару по причине брака, утери, прочей невозможности осуществления реализации. А так же отказ покупателя, отказ поставщика, возврат.",
        'badge' => ''
      }
    }

    # Requests
    config.request_creation_reason = {
      'client_choose' => 'Выбор клиента',
      'official' => 'Подобрана по официальному каталогу',
      'replacement_official' => 'Замена по официальному каталогу',
      'replacement_unofficial' => 'Не официальная замена (этот же производитель)',
      'replacement_non_branded' => 'Не брендированная замена (брендовая компание кладет эту фирму)',
      'analogue_expensive' => 'Качественный аналог', 
      'analogue_cheap' => 'Не рекомендуем, но как вариант',
      'needed_for_parent' => 'Деталь потребуется при установке родительской]'
    }

    config.request_check_needed = {
      'check_needed' => 'Требуется',
      'check_dont_needed' => 'Не требуется'
    }

    config.sanitize_config = {
      :elements => %w[
        a abbr b bdo blockquote br caption cite code col colgroup dd del dfn dl
        dt em figcaption figure h1 h2 h3 h4 h5 h6 hgroup i img ins kbd li mark
        ol p pre q rp rt ruby s samp small strike strong sub sup table tbody td
        tfoot th thead time tr u ul var wbr span div font center
      ],

      :attributes => {
        :all         => ['dir', 'lang', 'title', 'align', 'class'],
        'a'          => ['href', 'target'],
        'blockquote' => ['cite'],
        'col'        => ['span', 'width'],
        'colgroup'   => ['span', 'width'],
        'del'        => ['cite', 'datetime'],
        'img'        => ['alt', 'height', 'src', 'width', 'vspace', 'hspace'],
        'ins'        => ['cite', 'datetime'],
        'ol'         => ['start', 'reversed', 'type'],
        'q'          => ['cite'],
        'table'      => ['summary', 'width', 'height', 'background', 'cellpadding', 'cellspacing', 'border', 'bgcolor'],
        'td'         => ['abbr', 'axis', 'colspan', 'rowspan', 'width', 'height', 'bgcolor', 'valign', 'background'],
        'tr'         => ['height'],
        'th'         => ['abbr', 'axis', 'colspan', 'rowspan', 'scope', 'width'],
        'time'       => ['datetime', 'pubdate'],
        'ul'         => ['type'],
        'font'       => ['face', 'size', 'color']
      },

      :protocols => {
        'table'      => {'background' => ['http', 'https', :relative]},
        'td'         => {'background' => ['http', 'https', :relative]},
        'a'          => {'href' => ['ftp', 'http', 'https', 'mailto', :relative]},
        'blockquote' => {'cite' => ['http', 'https', :relative]},
        'del'        => {'cite' => ['http', 'https', :relative]},
        'img'        => {'src'  => ['http', 'https', :relative]},
        'ins'        => {'cite' => ['http', 'https', :relative]},
        'q'          => {'cite' => ['http', 'https', :relative]}
      }
    }

    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      address:                 "127.0.0.1",
      port:                    25,
      enable_starttls_auto:    true
    }


    # User Order Rule
    config.user_order_rules = {
      'all' => 'Автоматически уйдут в работу только если будет достаточно денег на все товары в заказе',
      'none' => 'Ни один заказ не будет оплачен',
    }
    config.robokassa_integration_modes = {
      'production' => 'Рабочий режим',
      'test' => 'Тестовый режим'
    }

    config.phone_types = {
      'mobile_russia' => 'Мобильный (Россия)',
      'unknown' => 'Городской/Или другие страны'
    }

    config.phone_types_keys = config.phone_types.keys

    config.default_user_role = 'guest'

    ## Default settings for new users
    #config.default_user_attributes = {
    #  'prepayment_percent' => 20,
    #  'discount' => 0,
    #  'order_rule' => 'all',
    #  'role' => 'guest'
    #}
    config.user_roles = {
      'all' => {
        'password_required' => false,
        'real' => false,
        'title' => 'Все',
        'title_plural' => 'Все'
      },
      'admin' => {
        'password_required' => true,
        'real' => true,
        'title' => 'Администратор',
        'title_plural' => 'Администраторы'
      },
      'manager' => {
        'password_required' => true,
        'real' => true,
        'title' => 'Менеджер',
        'title_plural' => 'Менеджеры'
      },
      'user' => {
        'password_required' => true,
        'real' => true,
        'title' => 'Покупатель',
        'title_plural' => 'Покупатели'
      },
      'guest' => {
        'password_required' => false,
        'real' => true,
         'title' => 'Гость',
         'title_plural' => 'Гости'
      }
    }

    # Все роли
    config.user_roles_keys = config.user_roles
      .select{ |k, v| v["real"] == true }
      .keys

    # Роли, где требуется пароль
    config.user_roles_password_required_keys = config.user_roles
      .select{ |k, v| v["real"] == true }
      .select{ |k, v| v["password_required"] == true }
      .keys

    # Роли, где не требуется пароль
    config.user_roles_password_not_required_keys = config.user_roles
      .select{ |k, v| v["real"] == true }
      .select{ |k, v| v["password_required"] == false }
      .keys

    #config.avisosms = {
    #  username: 'username',
    #  password: 'password',
    #  # Доступные варианты: flash sms growl
    #  method: 'flash',
    #  source_address: 'Yaponama',
    #  delivery_report: '1',
    #  flash_message: '0',
    #  validity_period: '10'
    #}

    config.sms_notify_methods = %w(flash sms growl)
  end
end
