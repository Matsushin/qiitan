require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
module RougeConfig
  class RougeRender < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end
end