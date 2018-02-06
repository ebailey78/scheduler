# scheduler

The goal of scheduler is to make it easier to automate and schedule R scripts.
It uses decorated comments like roxygen2 and plumber to control when a script 
will run. 

## Installation

You shouldn't install scheduler from GitHub yet, but when its ready it can be 
installed with:

``` r
# install.packages("devtools")
devtools::install_github("ebailey78/scheduler")
```

## Setup

After installing `scheduler` run `scheduler::initialize()` to set it up for use.
This will probably create a folder in your home directory (Linux) or your 
My Documents folder (Windows). This folder will have a log folder where the logs
are stored and a scripts folder where your scheduled scripts should live. It will
also probably edit the crontab (Linux) or Taskscheduler (Windows) to start an 
automated task.

## Example

This is an example of a script set to run automatically with scheduler. 

``` r
#* Test Job
#*
#* This is a test job. It is meant to test how the the comment reader works and
#* eventually how well the script runner works.
#*
#* @when wednesday 04:30
#* @when friday 14:30
#* @when 035
#* @when 21
#* @when 10-09
#* @when 02-08-2018
#*
#* @log info

library(clisymbols)
library(crayon)

cat(yellow(symbol$star), bold("Hello World!"), yellow(symbol$star))
```

The first line is the name of the script. This is the name that will appear in 
logs. After this the can be a paragraph describing the task in more detail. This
may be used in future releases.

Each `@when` tag controls when the script runs. In this example the script will
run every Wednesday at 4:30AM, each Friday at 2:30PM, on the 35 day of each year,
the 21st day of each month, on October 9th of each year, and on February 8th, 2018.
If a time isn't specified then it will run at midnight on the day specified. This
could lead to many scripts running so it might be best to always specify a time.

In addition, any logging event of info or above will be logged.
