# remove IPython marks like "In [1]:" in HTML exported from Jupyter notebook
import re

filename = input()

with open(filename, "r", encoding="utf-8") as f:
    html = f.read()
html = re.sub("In&nbsp;\[\d+\]:", "", html)
with open(filename, "w", encoding="utf-8") as f:
    f.write(html)
