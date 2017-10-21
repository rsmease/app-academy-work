require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_k = params.keys.map { |key| "#{key} = ?" }.join(" AND ")
    where_v = params.values
    results = DBConnection.execute(<<-SQL, where_v)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_k}
    SQL
    self.parse_all(results)
  end
end

class SQLObject
  extend Searchable
end


# def self.find(id)
#   results = DBConnection.execute(<<-SQL, id)
#     SELECT
#       *
#     FROM
#       #{self.table_name}
#     WHERE
#       id = ?
#   SQL
#   self.parse_all(results).first
# end
