class RemoveAddressColumnsFromAcademy < ActiveRecord::Migration
  def change
    connection = ActiveRecord::Base.connection

    update_existing = <<-SQL
      UPDATE locations
        SET
          type = 'AcademyLocation',
          locatable_type = 'Academy',
          street = a.street,
          unit = a.unit,
          city = a.city,
          us_state = a.us_state,
          postal_code = a.postal_code

        FROM academies a
            INNER JOIN locations l ON (l.locatable_type = 'Academy' AND l.locatable_id = a.id)
        WHERE a.id = locations.locatable_id
          AND locations.locatable_type = 'Academy'
          AND locations.type = 'AcademyLocation'
    SQL


    add_new = <<-SQL
      INSERT INTO locations ( type, locatable_id, locatable_type, street, unit, city, us_state, postal_code )
        SELECT 'AcademyLocation', a.id, 'Academy', a.street, a.unit, a.city, a.us_state, a.postal_code
          FROM academies a
            LEFT JOIN locations l ON (l.locatable_type = 'Academy' AND l.locatable_id = a.id)
          WHERE l.id IS NULL
    SQL

    connection.execute(update_existing)
    connection.execute(add_new)

    remove_column :academies, :street
    remove_column :academies, :unit
    remove_column :academies, :city
    remove_column :academies, :us_state
    remove_column :academies, :postal_code
  end
end
