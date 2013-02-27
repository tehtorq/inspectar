require "active_record"
require "inspectar/version"

module Inspectar

  class Connectar < ActiveRecord::Base; end

  def self.attach(params)
    ActiveRecord::Base.configurations["inspectar"] = params
    Connectar.establish_connection params
    connection_handle = Connectar.connection
    define_classes
  end

  def self.tables
    fetch.map{|datum| datum[:table_name]}
  end

  def self.models
    fetch.map{|datum| datum[:model_name]}
  end

  def self.class_definition(table_data)
    %Q{
class #{table_data[:model_name]} < ActiveRecord::Base
  establish_connection "inspectar"
  self.table_name = '#{table_data[:table_name]}'
  self.inheritance_column = :_type_disabled

  def method_missing(method_id, *args)
    hash = {}

    self.class.column_names.each do |v|
      hash[v] = v
      hash[v.downcase] = v
    end

    if hash.has_key?(method_id.to_s)
      send hash[method_id.to_s].to_sym
    elsif hash.has_key?(method_id.to_s + "=")
      send (hash[method_id.to_s] + "=").to_sym, args
    else
      super
    end
  end
end
}
  end

  def self.define_classes
    eval(class_definitions)
  end

  def self.class_definitions
    fetch.map do |datum|
      class_definition(datum)
    end.join("")
  end

  def self.fetch
    Connectar.connection.tables.map{|table| {table_name: table, model_name: table.tableize.camelize.singularize}}
  end
  
end