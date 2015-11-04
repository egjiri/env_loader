require 'yaml'
require 'json'

module EnvLoader
  class Configurator
    attr_reader :raw_config

    def initialize(config_file: nil, config_content: nil, config_subtree_key: nil)
      if config_file
        @raw_config = config_from_file(config_file, config_subtree_key)
      elsif config_content
        @raw_config = config_from_content(config_content, config_subtree_key)
      end
    end

    def config
      raw_config.each_with_object({}) do |hash, new_hash|
        key, value = hash
        value = value.is_a?(Hash) ? value.to_json : value.to_s unless value.nil?
        new_hash[key.upcase] = value
      end
    end

    def expose_values_as_environment_variables
      config.each { |key, value| ENV[key] = value }
    end

    private

    def config_from_file(config_file, config_subtree_key = nil)
      return {} unless File.exist?(config_file)
      config_content = File.read(config_file)
      config_from_content(config_content, config_subtree_key)
    end

    def config_from_content(config_content, config_subtree_key = nil)
      global_config = YAML.load(config_content)
      return global_config unless config_subtree_key
      extract_subhash_from_hash_and_keys(global_config, config_subtree_key.to_s.split('.'))
    end

    def extract_subhash_from_hash_and_keys(hash, subhash_keys)
      key = subhash_keys.shift
      return unless key
      return hash[:default] || {} unless hash.key?(key)
      return hash[key] if subhash_keys.empty?
      extract_subhash_from_hash_and_keys(hash[key], subhash_keys)
    end
  end
end
