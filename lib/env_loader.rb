require 'env_loader/railtie' if defined?(Rails)
require 'env_loader/version'
require 'env_loader/configurator'
require 'uiux'

module EnvLoader
  # A .monolith-config.yml file must be placed at the root of the monolith
  def self.setup_monolith
    config(config_file: File.join('.monolith-config.yml'), config_subtree_key: environment)
  end

  # A .microservices-config.yml file must be placed at the parent directory of the microservice
  def self.setup_microservice
    subtree_key = environment
    subtree_key += ".#{Rails.application.class.parent_name.underscore}" if defined?(Rails)
    config(config_file: File.join('..', '.microservices-config.yml'), config_subtree_key: subtree_key)
  end

  # DEPRECATED (<= 0.2.0):
  # Legacy setup which will be replaced by the above
  def self.read(config_file = File.join('config', 'env_variables.yml'))
    config(config_file: config_file)
  end

  private

  def self.environment
    Rails.env if defined?(Rails)
  end

  def self.config(config_file: nil, config_content: nil, config_subtree_key: nil)
    configurator = Configurator.new(config_file: config_file, config_content: config_content, config_subtree_key: config_subtree_key)
    configurator.expose_values_as_environment_variables if configurator
  end
end
