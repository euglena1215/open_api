module OpenApi
  # https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md#parameterObject
  class Parameter
    attr_accessor :name, :in, :description, :required, :deprecated, :allow_empty_value

    def initialize(name:, in:, description: nil, required: nil, deprecated: nil, allow_empty_value: nil, **other_fields_hash)
      self.name = name
      self.in = binding.local_variable_get(:in) # `in` is reserved keyword
      self.required = required
      self.deprecated = deprecated
      self.allow_empty_value = allow_empty_value
      self.other_fields_hash = other_fields_hash.with_indifferent_access

      other_fields_hash.keys.each do |key|
        define_singleton_method(key) do
          other_fields_hash[key]
        end
        define_singleton_method("#{key}=") do |value|
          other_fields_hash[key] = value
        end
      end
    end

    private

    attr_accessor :other_fields_hash
  end
end