# math-devcontainer

A devcontainer to build a grad school math course workspace. Opioninated for Python and Latex.

## How to use the devcontainer

I generally use this workspace in one of two ways.

- [Local development on VS Code](https://code.visualstudio.com/docs/devcontainers/tutorial) using either of my machines (Macbook or Linux box)
- [Codespaces](https://github.blog/developer-skills/github/a-beginners-guide-to-learning-to-code-with-github-codespaces/) on Github (which allows me to work on any machine I can login to Github, including my iPad)

## How I structure coursework

I assume that the course is structured in weekly modules and that course work involves some problem set from a textbook and some software assignment.

First, I create a directory called `module-{x}` where `x` is that week's module number.

Then, I create a text file like [assignment-example.md](module-example/assignment-example.md). See the example assignment for more details.

The devcontainer includes a full LaTeX toolchain (TeX Live) plus [ChkTeX](https://www.nongnu.org/chktex/) for linting LaTeX source.

To lint a LaTeX file you can run:

```
chktex assignment-example.tex
```

For any part of the assignment that uses Python, I change directory to the module and then use I use [uv](https://docs.astral.sh/uv/) which is already installed on the devcontainer to set up Python for each module.

1. `cd module-example`
2. `uv init`
3. `uv add numpy matplotlib` or whatever dependencies you need.
4. `uv run software_assignment.py`
5. [Optional for linting] `uv add ruff`
6. [Optional for linting] `uv run -m ruff format`

I then copy the Python code into the assignment and link any images created from a library like `matplotlib`. See the example assignment for more details.
