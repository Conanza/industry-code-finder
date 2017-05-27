require 'csv'
DEBUG_MODE = true

# Classification Systems (interested in NCCI, NAICS, and CA)
NAICS = 'NAICS'.freeze
NCCI  = 'NCCI'.freeze
SIC   = 'SIC'.freeze
WCIRB = 'CA WC'.freeze

# Description Types
ISO_D = 'ISO Description'.freeze
GEN_D = 'General Description'.freeze

header_lines = 0
lines = 0

CSV.foreach('./fastcompclasscodecrossreferenceguide.csv',
            headers: true,
            col_sep: ',',
            row_sep: "\n",
            skip_lines: /\AFastComp\.com/,
            skip_blanks: true) do |row|
  if row['ISO Description'] && row['ISO Description'].match('Adhesive Mfg.')
    p row
  end

  if row['ISO Description'] == 'ISO Description'
    # p row
    header_lines += 1
  end
  lines += 1
end

if DEBUG_MODE
  puts "number of lines read: #{lines}"
  puts "number of header lines read: #{header_lines}"
end
