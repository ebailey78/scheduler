#* Test Job
#*
#*This is a test job. It is meant to test how the comment reader works and
#*eventually how well the script runner works.
# @log info

library(clisymbols)
library(crayon)

cat(yellow(symbol$star), bold("Hello World!"), yellow(symbol$star))
