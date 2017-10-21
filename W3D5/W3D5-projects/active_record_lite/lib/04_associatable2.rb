require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_opts = self.class.assoc_options[through_name]
      source_opts = through_opts.model_class.assoc.options[source_name]

      through_table = through_opts.table_name
      through_primary = through_opts.primary_key
      through_foreign  = through_opts.foreign_key

      source_table = source_opts.table_name
      source_primary = source_opts.primary_key
      source_foreign = source_opts.foreign_key

      key_val = self.send(through_foreign)

      results = DBConnection.execute(<<-SQL, key_val)
        SELECT
          *
        FROM
          #{through_table}
        JOIN
          #{source_table} ON
            #{source_table}.#{source_primary} = #{through_table}.#{source_foreign}
        WHERE
          #{through_table}.#{through_primary} = ?
      SQL

      source_opts.model_class.parse_all(results).first
    end
  end
end
