# make_sorted_source
This software will read in and parse an R source file and re-organize it such that all functions appear in the source code alphabetically. 

# Description
I write my R code in a manner where everything I do is wrapped in a function call (e.g. get_mean_height_males(), plot_male_height_hist(); fit_and_save_linear_model_of_height_by_age()). This means I have source files that are replete with hundreds of functions. 

I like organizing my analyses this way, because it makes it easy for me to replicate my analyses, and to 'plug in' my code into RMarkdown or other formats, but it does pose challenges when I am navigating my source files, looking for a particular function. Of course, one can just search a source file, but it is also nice if all the functions are alphabetically ordered, allowing you to scroll through nearby functions which have similar logic, by virtue of their name (e.g. get_female_height_mean(), get_female_height_sd()). RStudio has a nice 'table of contents' option that lets you browse your code by function name, but again, I would love for there to exist an option to have all those functions be in alphabetical order. 

Not finding such a solution anywhere, I wrote the code in this repository. 

# Functions

```
make_sorted_source(src_in="", src_out="")
```

This code parses the source code in src_in, identifies the functions, alphabetizes them, and then creates a new source file. In the new source file, all non-function expressions will be at the top of the file, followed by all functions.

```
get_all_function_names(src_in="")
```

This is a utility function that will read in the source file, and then print out of all the functions identified in that source code.

### Warnings
This code has not yet been tested on R code that includes S3 or S4 object-oriented programming expressions. This code has also not been tested with R code that includes function calls in other programming languages. This code works well for my functional programming style and that is all I can vouch for. In the future, I'd like to test this code and make improvements suited to more general use-cases.
