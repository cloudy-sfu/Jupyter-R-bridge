library(rmarkdown)
library(xfun)

ipynb_path <- choose.files(multi = FALSE, filters = c("Jupyter notebook (*.ipynb)", "*.ipynb"))
if_render <- FALSE

if (length(ipynb_path) == 1) {
    # convert R markdown to Jupyter notebook
    rmd_path = with_ext(ipynb_path, 'Rmd')
    convert_ipynb(input=ipynb_path, output=rmd_path)
    # fix duplicate titles
    rmd_file = readLines(rmd_path)
    rmd_file[2] = 'title: \"\"'
    writeLines(rmd_file, rmd_path)

    # render R markdown
    if (if_render) {
        html_path = with_ext(ipynb_path, 'html')
        html_path = gsub("\\\\", "\\", html_path) 
        render(rmd_path, output_file = html_path)
    }
}
