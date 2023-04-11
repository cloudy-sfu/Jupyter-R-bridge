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

## Install R kernel in Jupyter Lab

### Windows

1. Create a python virtual environment. Denote the location is `$venv`.
2. Run `pip install jupyterlab` in Python environment to install Jupyter Lab. [Reference](https://jupyter.org/install)
   There should be an executive file `$venv\Scripts\jupyter-lab.exe`.
3. Run the following script in R terminal, where `$venv` should be absolute path. (i.e. `C:\Users\Administrator\PycharmProjects\R\venv`)
   It should only use slash `/` and avoid backslash `\`. [Reference](https://izoda.github.io/site/anaconda/r-jupyter-notebook/)

   ```R
   # Python environment. Use slash '/' only.
   setwd('$venv/Scripts')
   install.packages("IRkernel")
   IRkernel::installspec()
   ```

4. Create a directory to save your projects. Denote the location is `$JupyterLab`.
5. Run the following script to start Jupyter lab.

   ```powershell
   netstat -ano | findstr :8888
   cd $JupyterLab
   $venv\Scripts\jupyter-lab.exe --port 8888
   ```

### Ubuntu 20.04

1. Run the following command to install R 4.x.

   ```bash
   sudo apt install --no-install-recommends software-properties-common dirmngr
   wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
   sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
   sudo apt install --no-install-recommends r-base
   ```

2. If you have `conda`, run the following command. 

   ```bash
   conda create -n R python=3.11
   pip install jupyterlab
   cd ~/.conda/envs/R/bin/
   R
   ```
   
   Otherwise, please use `pip install jupyterlab` in Python environment and locate to `jupyter-lab` executive file. You can use `which python` to locate Python
   installation path (denoted as `$venv`) and browse to `$venv/bin/`.

3. In R command line, run the following command to install R kernel for Jupyter lab.

   ```R
   install.packages("IRkernel")
   IRkernel::installspec()
   quit()
   ```

4. If you access Ubuntu machine by SSH, run the following command to start Jupyter lab.

   ```bash
   cd ~
   jupyter-lab --port 6007 --no-browser --ip 0.0.0.0
   ```
   
   You can customize the port `6007`, but should not modify IP address `0.0.0.0`.
   
   If you use Ubuntu machine and access Jupyter lab locally (without SSH), run the following command to start Jupyter lab.
   
   ```bash
   cd ~
   jupyter-lab --port 6007
   ```
   
   In this case, you have done all the steps.
   
5. Start a SSH tunnel:

   ```
   Local port forwarding
   Remote server: 0.0.0.0
   Remote port: 6007
   Forwarded port: 6007
   ```
   
   SSH server is different according to how you connect to Ubuntu machine.
   

## R Studio notes

1. Export customized key bindings setting by copying the files in `%APPDATA%/RStudio/keybindings`.

## Acknowledge

We use [rmd2jupyter](https://github.com/mkearney/rmd2jupyter) to convert `*.Rmd` to `*.ipynb`. The script is modified.
