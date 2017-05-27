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
  # if row['ISO Description'] && row['ISO Description'].match('Adhesive Mfg.')
  #   p row
  # end

  p row if row[WCIRB] && row[WCIRB].match(VAR_REGEX)

  header_lines += 1 if row[ISO_D] == ISO_D
  lines += 1

  # cases to account for
end

if DEBUG_MODE
  puts "number of lines read: #{lines}"
  puts "number of header lines read: #{header_lines}"
end

# NOTE
# ISO and General Descriptions are never N/A
# some classification systems contain Var.
# some classification systems contain N/A
