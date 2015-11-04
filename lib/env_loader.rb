require 'env_loader/version'
require 'yaml'

module EnvLoader
  def self.read(env_yml_file = File.join('config', 'env_variables.yml'))
    return unless File.exist?(env_yml_file)
    hash = YAML.load_file(env_yml_file)
    if hash
      hash.each do |key, value|
        ENV[key.upcase] = format_value(value) if value
      end
    end
  end

  def self.get(key)
    value = ENV[key.to_s.upcase]
    if value
      if value.match(/^\{.*\}$/)
        JSON.parse(value).with_indifferent_access
      else
        value
      end
    end
  end

  private

  def self.format_value(value)
    value.is_a?(Hash) ? value.to_json : value.to_s
  end
end
