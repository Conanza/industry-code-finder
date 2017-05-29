require 'csv'

class TableReader
  CA    = CaCode.to_label
  NAICS = NaicsCode.to_label
  NCCI  = NcciCode.to_label
  SIC   = SicCode.to_label
  ISO_D = IsoDescription.to_label
  GEN_D = GeneralDescription.to_label

  def initialize
    @descriptions = [IsoDescription, GeneralDescription]
    @systems = [CaCode, NaicsCode, NcciCode, SicCode]

    @description_labels = @descriptions.map(&:to_label)
    @system_labels = @systems.map(&:to_label)
    @all_headers = [@description_labels, @system_labels].reduce([], :concat)

    @header_lines = 0
    @non_header_lines = 0
    @total_lines = 0
    @errors = 0
  end

  def output_performance_stats
    puts "number of header lines read: #{@header_lines} (of 83 expected)"
    puts "number of regular lines read: #{@non_header_lines} (of 2768 expected)"
    puts "total lines read: #{@total_lines} (of 2851 expected)"
    puts "total errors in seeding db: #{@errors} errors"
  end

  def parse_csv(path_to_csv)
    completed_rows = []
    deferred_rows = []
    prev_row = nil
    row_with_iso = nil

    CSV.foreach(path_to_csv,
                headers: true,
                col_sep: ',',
                row_sep: "\n",
                skip_blanks: true,
                skip_lines: /\AFastComp\.com/) do |row|
      @total_lines += 1
      if header_line?(row)
        @header_lines += 1
        next
      end
      @non_header_lines += 1

      # description ran long, append to prev row
      if description_only_row?(row)
        @description_labels.each do |desc|
          str = prev_row[desc]
          str << "#{space(str)}#{row[desc]}" if row[desc]
        end

        next
      end

      if iso_description_empty?(row)
        if row_with_iso.nil?
          deferred_rows.push(row)
        else
          row[ISO_D] = row_with_iso[ISO_D]
          completed_rows << row
        end
      else
        if deferred_rows.empty?
          row_with_iso = nil
        else
          row_with_iso = row
          deferred_rows.each do |deferred_row|
            deferred_row[ISO_D] = row_with_iso[ISO_D]

            completed_rows << deferred_row
          end
          deferred_rows = []
        end

        completed_rows << row
      end

      prev_row = row
    end

    completed_rows.each do |row|
      clean_up(row).each do |clean_row|
        begin
          create_mapping(clean_row)
        rescue # TODO should only catch ActiveRecord errors
          @errors += 1
        end
      end
    end
  end

  private

  def clean_up(row)
    rows = []
    row[ISO_D].gsub!("\n", " ")

    max_lines = 1
    multilined = false
    @system_labels.each do |label|
      next if row[label].nil?
      num_lines = row[label].split("\n").length

      if num_lines > 1
        multilined = true
        max_lines = num_lines > max_lines ? num_lines : max_lines
      end
    end

    if multilined
      # create max_lines # of rows
      max_lines.times do |i|
        fields = []
        @all_headers.each do |hdr|
          lines = row[hdr].split("\n") if row[hdr]
          if lines && lines.length > 1
            if hdr == GEN_D && lines.length > max_lines && i == max_lines - 1
              fields.push(lines[i..-1].join(' '))
            else
              fields.push(lines[i])
            end
          else
            fields.push(row[hdr])
          end
        end

        rows.push(CSV::Row.new(@all_headers, fields))
      end

      rows
    else
      row[GEN_D].gsub!("\n", " ")
      [row]
    end
  end

  def create_mapping(row)
    @systems.each do |sys|
      var_name = "@#{sys.name.underscore}_id"
      code_number = row[sys.to_label]

      id = if code_number == 'N/A' || code_number.nil?
             nil
           else
             sys.find_or_create_by!(code_number: code_number).id
           end
      instance_variable_set(var_name, id)
    end

    @descriptions.each do |desc|
      var_name = "@#{desc.name.underscore}_id"
      description = row[desc.to_label]
      id = if description.nil?
             nil
           else
             desc.find_or_create_by!(description: description).id
           end
      instance_variable_set(var_name, id)
    end

    Mapping.create!(
      ca_code_id: @ca_code_id,
      ncci_code_id: @ncci_code_id,
      naics_code_id: @naics_code_id,
      sic_code_id: @sic_code_id,
      general_description_id: @general_description_id,
      iso_description_id: @iso_description_id
    )
  end

  def description_only_row?(row)
    @systems.all? { |sys| row[sys.to_label].nil? }
  end

  def header_line?(row)
    row[ISO_D] == ISO_D
  end

  def iso_description_empty?(row)
    row[ISO_D].nil?
  end

  def space(str)
    str[-1] == '-' ? '' : ' '
  end
end
