require 'env_loader/version'
require 'yaml'

module EnvLoader

  def self.read(env_yml_file = File.join('config', 'env_variables.yml'))
    if File.exists? env_yml_file
      if hash = YAML.load_file(env_yml_file)
        hash.each do |key, value|
          if value
            ENV[key.upcase] = format_value(value)
          end
        end
      end
    end
  end

  def self.get(key)
    if value = ENV[key.to_s.upcase]
      if value.match(/^\{.*\}$/)
        JSON.parse(value).with_indifferent_access
      else
        value
      end
    end
  end

  private

  def self.format_value(value)
    if value.is_a? Hash
      value = value.to_json
    else
      value = value.to_s
    end
  end
end

