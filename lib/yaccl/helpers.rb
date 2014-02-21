require 'active_support/core_ext'

module YACCL
  module Helpers

    def initialize_properties(raw)
      @properties = get_properties_map(raw)
    end

    def cmis_properties(properties)
      properties.each do |property_name|
        method_name = method_name(property_name)
        class_eval "def #{method_name};@properties['#{property_name}'];end"
        class_eval "def #{method_name}=(value);@properties['#{property_name}']=value;end"
      end
    end

    def update_change_token(r)
      if r['properties']
        @change_token = r['properties']['cmis:changeToken']['value']
      elsif r['succinctProperties']
        @change_token = r['succinctProperties']['cmis:changeToken']
      else
        raise "Unexpected hash: #{r}"
      end
    end

    private

    def method_name(property_name)
      if property_name == 'cmis:objectId'
        'cmis_object_id'
      else
        property_name.gsub('cmis:', '').underscore
      end
    end

    def get_properties_map(raw)
      raw = raw.with_indifferent_access

      if raw['succinctProperties']
        result = raw['succinctProperties']
      elsif raw['properties']
        result = raw['properties'].reduce({}) do |h, (k, v)|
          val = v['value']
          val = v['value'].first if v['value'].is_a?(Array) and v['cardinality'] == 'single'
          val = Time.at(val / 1000) if val and v['type'] == 'datetime'
          h.merge(k => val)
        end
      else
        result = {}
      end

      result.with_indifferent_access
    end

  end
end