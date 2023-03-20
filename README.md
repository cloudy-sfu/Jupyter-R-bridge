# Jupyter R Bridge
Convert between R markdown and Jupyter notebook

![](https://shields.io/badge/dependencies-R_4.2-blue)
![](https://shields.io/badge/OS-Windows-lightgrey)

## Differences

This table lists the difference between exporting Jupyter notebook and knitting R markdown.

| Description                                                  | Jupyter notebook | R markdown | Knit |
| ------------------------------------------------------------ | ---------------- | ---------- | ---- |
| `options` method doesn't have effect.<br />It is mainly used to suppress warnings and adjust figure size. Use `{r warning=FALSE}` or `{r fig.width=5,fig.size=5}` to fix it. | ✓                | ✗          | ✗    |
| Cannot preview graphs created by `grid` package in R Studio.<br />Write  `grid.newpage()` at the beginning of each chunk. | ✓                | ✗          | ✓    |
|                                                              |                  |            |      |

## Install R kernel in Jupiter Lab

Install Jupiter Lab. [Reference](https://jupyter.org/install)

1.   Create a python virtual environment at `venv` somewhere. 
2.   Run `pip install jupyterlab` in the environment.

The executive file is at `venv\Scripts\jupyter-lab.exe`.

Install required packages in R. [Reference](https://izoda.github.io/site/anaconda/r-jupyter-notebook/)

1. Run the following script in R terminal. Replace `...` with the absolute path, to make it the path of Python environment.

   ```R
   # Python environment. Use slash '/' only.
   setwd('.../venv/Scripts')
   install.packages("IRkernel")
   IRkernel::installspec()
   ```

2. Create a directory `JupyterLab` somewhere to place projects.

3. Start Jupiter Lab: run the following script. (Replace `...` with absolute paths. They can be different.)

   ```powershell
   netstat -ano | findstr :8888
   cd ...\JupyterLab
   ...\venv\Scripts\jupyter-lab.exe --port 8888
   ```

## R Studio notes

1. Export customized key bindings setting by copying the files in `%APPDATA%/RStudio/keybindings`.

