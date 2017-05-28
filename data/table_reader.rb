require 'csv'
DEBUG_MODE = true

# Classification Systems (interested in NCCI, NAICS, and CA)
CA    = 'CA WC'.freeze
NAICS = 'NAICS'.freeze
NCCI  = 'NCCI'.freeze
SIC   = 'SIC'.freeze

systems = [CA, NAICS, NCCI, SIC]

# Description Types
ISO_D = 'ISO Description'.freeze
GEN_D = 'General Description'.freeze

description_types = [ISO_D, GEN_D]

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
  deferred_rows = []
  prev_row = nil
  centered_row = nil
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

    if row[ISO_D].nil?
      puts "no #{ISO_D}"
      deferred_rows.push(row)
    else
      puts "#{ISO_D} exists"
      row[ISO_D].gsub!("\n", " ")

      deffered_rows.length
    end

    description_only = [row[CA], row[NAICS], row[NCCI], row[SIC]].all?(&:nil?)
    if description_only
      # description ran long, append to prev row
      description_types.each do |desc_type|
        str = prev_row[desc_type]
        str << "#{space(str)}#{row[desc_type]}" if row[desc_type]
      end
      # prev_row[GEN_D] << " #{gen_d}" if gen_d
      # prev_row[ISO_D] << " #{iso_d}" if iso_d
    end

    prev_row = row unless description_only
    # cases to account for
    # 1. when a description contains a newline
    #    a. it's either run long
    #    b. or there are multiple descriptions mapping to different codes (should have matching newlines in codes)
    # 2. when a description runs long and occupies a new row by itself
    # 3. when an ISO Description maps to many other codes/descriptions and has white space on top and bottom
  end
end

if DEBUG_MODE
  puts "number of header lines read: #{header_lines} (of 83 expected)"
  puts "number of regular lines read: #{non_header_lines} (of 2768 expected)"
  puts "total lines read: #{lines} (of 2851 expected)"
  p systems
  p description_types
end

# NOTE
# ISO and General Descriptions are never N/A
# some classification systems contain Var.
# some classification systems contain N/A
