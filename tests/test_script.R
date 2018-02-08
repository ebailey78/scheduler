#* Test Job
#*
#*This is a test job. It is meant to test how the comment reader works and
#*eventually how well the script runner works.
#*
#* @when wednesday 04:30
#* @when friday 01:30
#* @when 035
#* @when 21
#* @when 10-09
#* @when 2018-02-08
#*
#* @log info

library(clisymbols)
library(crayon)

cat(yellow(symbol$star), bold("Hello World!"), yellow(symbol$star))
