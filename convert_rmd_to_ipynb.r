format_cell <- function(cell_type, source) {
  if (cell_type == "code") {
    return(list(cell_type = cell_type, execution_count = "", metadata = "", outputs = "", source = source))
  } else {
    return(list(cell_type = cell_type, metadata = "", source = source))
  }
}

format_cells <- function(cells) {
  x <- list(cells = unname(cells),
            metadata = list(
              "anaconda-cloud" = "",
              "kernelspec" = list(
                "display_name" = "R",
                "langauge" = "R",
                "name" = "ir"),
              "language_info" = list(
                "codemirror_mode" = "r",
                "file_extension" = ".r",
                "mimetype" = "text/x-r-source",
                "name" = "R",
                "pygments_lexer" = "r",
                "version" = "4.3.0")
            ),
            "nbformat" = 4,
            "nbformat_minor" = 1)
  jsonlite::toJSON(x, auto_unbox = TRUE)
}

x <- choose.files(multi = FALSE, filters = c("R markdown (*.rmd)", "*.rmd"))
if (length(x) == 1) {
  # rmd2jupyter function: https://github.com/mkearney/rmd2jupyter
  save_as <- gsub("\\.Rmd", ".ipynb", x)
  con <- file(x)
  x <- readLines(con, warn = FALSE)
  close(con)
  ## strip yaml
  if (grepl("^---", x[1])) {
    yaml_end <- grep("^---", x)[2]
    x <- x[(yaml_end + 1L):length(x)]
  }
  chunks <- grep("^```", x)
  if (length(chunks) == 0L) {
    lns <- c(1L, length(x))
    chunks <- matrix(lns, ncol = 2, byrow = TRUE)
    chunks <- data.frame(chunks)
    names(chunks) <- c("start", "end")
    chunks$cell_type <- "markdown"
  } else {
    lns <- sort(c(
      1L, length(x), chunks,
      chunks[seq(1, length(chunks), 2)] - 1L,
      chunks[seq(2, length(chunks), 2)] + 1L
    ))
    lns <- lns[lns > 0 & lns <= length(x)]
    if (chunks[length(chunks)] == length(x)) {
      lns <- lns[-length(lns)]
    }
    if (chunks[1L] == 1L) {
      lns <- lns[-1]
    }
    chunks <- matrix(lns, ncol = 2, byrow = TRUE)
    chunks <- data.frame(chunks)
    names(chunks) <- c("start", "end")
    codes <- grep("^```", x)
    codes <- codes[seq(1, length(codes), 2)]
    chunks$cell_type <- ifelse(chunks$start %in% codes, "code", "markdown")
    x <- gsub("^```.*", "", x)
  }
  for (i in seq_len(nrow(chunks))) {
    s <- paste0(x[(chunks$start[i]):(chunks$end[i])], "\n")
    ## trim top and bottom blank lines
    while (s[1] == "\n" & length(s) > 1L) {
      s <- s[-1]
    }
    while (s[length(s)] == "\n" & length(s) > 1L) {
      s <- s[-length(s)]
    }
    chunks$source[i] <- I(list(s))
  }
  cells <- Map(format_cell, chunks$cell_type, chunks$source)
  x <- jsonlite::prettify(format_cells(cells))
  x <- gsub("count\": \"\"", "count\": null", x)
  x <- gsub("metadata\": \"\"", "metadata\": {}", x)
  x <- gsub("outputs\": \"\"", "outputs\": []", x)
  cat(x, file = save_as)
  message(paste("file saved as", save_as))
}
