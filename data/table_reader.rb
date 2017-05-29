require 'csv'
DEBUG_MODE = true

# Classification Systems (interested in NCCI, NAICS, and CA)
CA    = 'CA WC'.freeze
NAICS = 'NAICS'.freeze
NCCI  = 'NCCI'.freeze
SIC   = 'SIC'.freeze

# Description Types
ISO_D = 'ISO Description'.freeze
GEN_D = 'General Description'.freeze

# Matchers
NA_REGEX  = /N\/A/
VAR_REGEX = /Var\./

# Helpers
def space(str)
  str[-1] == '-' ? '' : ' '
end

header_lines = 0
lines = 0
non_header_lines = 0
CSV.open('./writer_test.csv', 'wb') do |csv|
  completed_rows = []
  deferred_rows = []
  prev_row = nil
  row_with_iso = nil
  CSV.foreach('./fastcompclasscodecrossreferenceguide.csv',
              headers: true,
              col_sep: ',',
              row_sep: "\n",
              skip_lines: /\AFastComp\.com/,
              skip_blanks: true) do |row|
    lines += 1
    if row[ISO_D] == ISO_D
      header_lines += 1
      next
    end
    non_header_lines += 1

    description_only_row = [row[CA], row[NAICS],
                            row[NCCI], row[SIC]].all?(&:nil?)
    iso_empty = row[ISO_D].nil?

    # description ran long, append to prev row
    if description_only_row
      [ISO_D, GEN_D].each do |desc_type|
        str = prev_row[desc_type]
        str << "#{space(str)}#{row[desc_type]}" if row[desc_type]
      end

      next
    end

    if iso_empty
      if row_with_iso.nil?
        deferred_rows.push(row)
      else
        row[ISO_D] = row_with_iso[ISO_D]
        completed_rows << row
      end
    else
      row[ISO_D].gsub!("\n", " ")

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
    # cases to account for
    # 1. when a description contains a newline
    #    a. it's either run long
    #    b. or there are multiple descriptions mapping to different codes (should have matching newlines in codes)
    # 2. when a description runs long and occupies a new row by itself
    # 3. when an ISO Description maps to many other codes/descriptions and has white space on top and bottom
  end

  completed_rows.each do |row|
    csv << row
  end
end

if DEBUG_MODE
  puts "number of header lines read: #{header_lines} (of 83 expected)"
  puts "number of regular lines read: #{non_header_lines} (of 2768 expected)"
  puts "total lines read: #{lines} (of 2851 expected)"
end

# NOTE
# ISO and General Descriptions are never N/A
# some classification systems contain Var.
# some classification systems contain N/A
