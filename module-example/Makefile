# Makefile for building assignment-example.pdf and generating the figure via Python
# Usage examples:
#   make            (run python to generate figure, then build PDF)
#   make pdf        (just build the PDF; assumes figure already exists)
#   make python     (run the python script to (re)generate the figure)
#   make clean      (remove build artifacts)
#   make distclean  (also remove the generated figure)

# ---- Config ----
TEX      := assignment-example.tex
PDF      := $(TEX:.tex=.pdf)
PYTHON   ?= python3
PY       := main.py
FIG      := software-assignment.png
LATEX    := pdflatex
LATEXFLAGS := -interaction=nonstopmode -halt-on-error

# Dependencies (basic – install target will pip install these)
PY_DEPS := matplotlib numpy

.PHONY: all python pdf clean distclean install

all: python pdf

# Run the python script to (re)generate the figure
python: $(FIG)

$(FIG): $(PY)
	@echo "[PY] Generating figure via $(PYTHON) $(PY)"
	$(PYTHON) $(PY)
	@echo "[PY] Figure generated: $(FIG)"

# Build the PDF (runs pdflatex twice for stable refs even if not strictly needed here)
pdf: $(PDF)

$(PDF): $(TEX) $(FIG)
	@echo "[TEX] First pass: $(LATEX) $(LATEXFLAGS) $(TEX)"
	$(LATEX) $(LATEXFLAGS) $(TEX)
	@echo "[TEX] Second pass: $(LATEX) $(LATEXFLAGS) $(TEX)"
	$(LATEX) $(LATEXFLAGS) $(TEX)
	@echo "[TEX] Built $(PDF)"

# Simple install of Python dependencies (no virtualenv management here)
install:
	@echo "[PIP] Installing Python dependencies: $(PY_DEPS)"
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install $(PY_DEPS)

clean:
	@echo "[CLEAN] Removing LaTeX aux files"
	@rm -f *.aux *.log *.out *.toc *.fls *.fdb_latexmk *.synctex.gz

# Remove everything generated (except the PDF if you want to keep it; adjust as desired)
distclean: clean
	@echo "[CLEAN] Removing PDF and generated figure"
	@rm -f $(PDF) $(FIG)

# Convenience target to force rebuild
.PHONY: rebuild
rebuild: clean all
