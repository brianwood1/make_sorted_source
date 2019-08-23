# make_sorted_source
This software will read in and parse an R source file and re-organize it such that all functions appear in the source code alphabetically. 

# Description
I write my R code in a manner where everything I do is wrapped in a function call. This means I have source files that are replete with hundreds of functions. 
This makes it easy for me to 'plug in' my code to RMarkdown or other formats, but it does pose challenges when I am navigating my source files, looking for a particular function. Of course, one can just search a source file, but it is also nice if all the functions are alphabetically ordered, I find. RStudio has a nice 'table of contents' option that lets you browse your code by function name, but again, I would love for there to exist an option to have all those function be in alphabetical order. Not finding such a solution anywhere, I wrote the code in this repository.

# Functions

## make_sorted_source(src_in="", src_out="")
#### This code parses the source code in src_in, identifies what the functions are, alphabetizes them, and then creates a new source file. In the new source file, all non-function expressions will be at the top of the file, followed by all functions. 

## get_all_function_names(src_in="")
#### This code is just a utility function that will read in all the source file, and then give you a print out of all the functions identified in that source code.

# Warnings
This code has not been tested on R code that includes S3 or S4 object-oriented programming expressions. This code has also not been tested with R code that includes function calls in other programming languages. This code works well for my functional programming style and that is all I can vouch for. In the future, I'd like to test this code and make improvements suited to more use-cases.
