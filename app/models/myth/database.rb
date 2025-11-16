class Myth::Database < ApplicationRecord
  belongs_to              :db_version
  belongs_to              :used_engine, class_name: "Myth::DbEngine"
  has_and_belongs_to_many :db_engines
  has_and_belongs_to_many :schemaversions
end
