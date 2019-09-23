#parses r source files, identifies functions, alphabetizes them, and create a new source file with:
#all non function expressions at the top, followed by a blank line, then
#followed by all functions, placed in alphabetical order.

#warning: does not preserve or treat kindly any comments that may be written between functions. 
#this code works best for source files in which everything is wrapped in a function call. 

library(codetools)

make_sorted_source <- function(src_in="", src_out="")
{
  
  current_width= options("width")[[1]]
  options(width=10000)
  
  #I stole these two functions from StackExchange user Konrad Rudolph
  
  is_assign = function (expr)
    as.character(expr) %in% c('<-', '<<-', '=', 'assign')
  
  is_function = function (expr)
    is.call(expr) && is_assign(expr[[1]]) && is.call(expr[[3]]) && expr[[3]][[1]] == quote(`function`)
  
  
  
  r <- parse(src_in)
  meta <- data.frame(id=1:length(r))
  meta$is_function <- FALSE
  meta$function_name <- NA
  meta$code <- NA
 
  
  for(i in 1:nrow(meta))
  {
     the_expression_outer <- r[i]
     the_expression_inner <- r[[i]]
     meta$is_function[i] <- is_function(the_expression_inner)
     
     if(meta$is_function[i])
     {
       the_name <- as.character(lapply(the_expression_outer, `[[`, 2))
       meta$function_name[i] <- the_name
       printed <- capture.output(print(the_expression_outer))
       pasted <- paste(printed, collapse='\n')
       pasted_trimmed <- substr(pasted, start = 12, stop =(nchar(pasted)-1))
       pasted_trimmed_with_extra_newline <- paste(pasted_trimmed, "\n")
       meta$code[i] <- pasted_trimmed_with_extra_newline
     } else {
       printed <- capture.output(the_expression_inner)
       pasted <- paste(printed, collapse='\n')
       meta$code[i] <- printed
     }
  }
  
  #gather and print all non-functions at top
  non_functions <- meta[!meta$is_function,]
  
  #add a blank row after last non-function
  blank_row <- data.frame(id=c(""), is_function=c(""), function_name=c(""), code=c(""))
  non_functions$code[nrow(non_functions)] <- paste(non_functions$code[nrow(non_functions)], "\n")
  
  
  #gather and sort all functions below them alphabetically
  the_functions <- meta[meta$is_function,]
  sorted_functions <- the_functions[order(the_functions$function_name),]
  re_organized_code <- rbind(non_functions, blank_row, sorted_functions)
  
  writeLines(re_organized_code$code, src_out)
  options(width=current_width)
}

get_all_function_names <- function(src_in)
{
  options(width=150)
  is_function = function (expr)
    is.call(expr) && is_assign(expr[[1]]) && is.call(expr[[3]]) && expr[[3]][[1]] == quote(`function`)

  r <- parse(src_in)
  meta <- data.frame(id=1:length(r))
  meta$is_function <- FALSE
  meta$function_name <- NA
  meta$code <- NA

  for(i in 1:nrow(meta))
  {
    the_expression_outer <- r[i]
    the_expression_inner <- r[[i]]
    meta$is_function[i] <- is_function(the_expression_inner)
    
    if(meta$is_function[i])
    {
      the_name <- as.character(lapply(the_expression_outer, `[[`, 2))
      meta$function_name[i] <- the_name
      printed <- capture.output(print(the_expression_outer))
      pasted <- paste(printed, collapse='\n')
      pasted_trimmed <- substr(pasted, start = 12, stop =(nchar(pasted)-1))
      pasted_trimmed_with_extra_newline <- paste(pasted_trimmed, "\n")
      meta$code[i] <- pasted_trimmed_with_extra_newline
    } 
    
  }
  
  the_functions <- meta[meta$is_function,]
  the_function_names <- meta$function_name
  the_function_names <- the_function_names[!is.na(the_function_names)]
  return(the_function_names)
}

