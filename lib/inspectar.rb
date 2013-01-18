require "active_record"
require "inspectar/version"

module Inspectar

  def self.attach(params)
    ActiveRecord::Base.establish_connection params
    connection_handle = ActiveRecord::Base.connection
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
  self.table_name = '#{table_data[:table_name]}'
  self.inheritance_column = :_type_disabled
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
    conn = ActiveRecord::Base.connection
    tables = conn.execute("show tables").map { |r| r[0] }
    tables.map{|table| {table_name: table, model_name: table.tableize.camelize.singularize}}
  end
  
end
