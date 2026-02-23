# ML Project

## Dependencies 

Use `uv` to handle virtual environment. Install with `python -m pip install uv` or whatever you want idk look it up

`uv venv` to create venv, then activate with the recommended command. 

`uv pip install --group dev` to install dependencies from pyprokect.toml


## Typst 

We're writing in Typst. The future is now, old man. 

Install Typst, however it's done on your OS. 

Compile with `typst compile path/to/main.typ`, which generates a same-named pdf in the same dir. 

[Tinymist for VSCode](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) is used to generate a live preview in your browser. It should just work. It also provides language server stuff like autocorrect and warnings. Also available on other IDEs or text editors, or you can just constantly recompile I guess.
