require 'csv'
DEBUG_MODE = true

# Classification Systems (interested in NCCI, NAICS, and CA)
NAICS = 'NAICS'.freeze
NCCI  = 'NCCI'.freeze
SIC   = 'SIC'.freeze
WCIRB = 'CA WC'.freeze

SYSTEMS = [NAICS, NCCI, SIC, WCIRB].freeze

# Description Types
ISO_D = 'ISO Description'.freeze
GEN_D = 'General Description'.freeze

DESCRIPTIONS = [ISO_D, GEN_D].freeze

# Matchers
NA_REGEX  = /N\/A/
VAR_REGEX = /Var\./

header_lines = 0
lines = 0

CSV.foreach('./fastcompclasscodecrossreferenceguide.csv',
            headers: true,
            col_sep: ',',
            row_sep: "\n",
            skip_lines: /\AFastComp\.com/,
            skip_blanks: true) do |row|
  p row if row[ISO_D] && row[ISO_D].match('Alarms and Alarm Systems')

  # p row if row[WCIRB] && row[WCIRB].match(VAR_REGEX)

  header_lines += 1 if row[ISO_D] == ISO_D
  lines += 1

  # cases to account for
  # 1. when a description contains a newline
  #    a. it's either run long
  #    b. or there are multiple descriptions mapping to different codes (should have matching newlines in codes)
  # 2. when a description runs long and occupies a new row by itself
  # 3. when an ISO Description maps to many other codes/descriptions and has white space on top and bottom
end

if DEBUG_MODE
  puts "number of lines read: #{lines}"
  puts "number of header lines read: #{header_lines}"
end

# NOTE
# ISO and General Descriptions are never N/A
# some classification systems contain Var.
# some classification systems contain N/A
