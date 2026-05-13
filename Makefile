# LaTeX Makefile for flexible compilation
# Usage:
#   make build-tex-full-output DIR=path/to/dir      # Keep all files (default LaTeX behavior)
#   make build-tex-keep-pdf DIR=path/to/dir         # Keep only PDF, clean up auxiliary files
#   make build-tex-keep-pdf-logs DIR=path/to/dir    # Keep PDF and log files, clean up other auxiliary files

# Default to current directory if DIR not specified
DIR ?= .

# Find all .tex files in the specified directory
TEX_FILES := $(shell find $(DIR) -maxdepth 1 -name "*.tex")

# Default target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  build-tex-full-output DIR=path      Keep all files (default LaTeX behavior)"
	@echo "  build-tex-keep-pdf DIR=path         Keep only PDF, clean up auxiliary files"
	@echo "  build-tex-keep-pdf-logs DIR=path    Keep PDF and log files, clean up other auxiliary files"
	@echo "  clean DIR=path                      Clean auxiliary files in specified directory"
	@echo "  format                              Run latexindent over all tracked .tex files"
	@echo "  format-one FILE=path                Format a single .tex file"
	@echo "  format-check                        Fail if formatting diffs are present"

# Compile with full output (keep all files)
.PHONY: build-tex-full-output
build-tex-full-output:
	@for tex_file in $(TEX_FILES); do \
		echo "Compiling $$tex_file with full output..."; \
		cd "$$(dirname "$$tex_file")" && \
		pdflatex -interaction=nonstopmode -halt-on-error "$$(basename "$$tex_file")"; \
	done

# Compile and keep only PDF
.PHONY: build-tex-keep-pdf
build-tex-keep-pdf:
	@for tex_file in $(TEX_FILES); do \
		echo "Compiling $$tex_file and keeping only PDF..."; \
		cd "$$(dirname "$$tex_file")" && \
		pdflatex -interaction=nonstopmode -halt-on-error "$$(basename "$$tex_file")"; \
	done
	@$(MAKE) clean DIR=$(DIR)

# Same as build-tex-keep-pdf but formats all sources first
.PHONY: build-tex-keep-pdf-with-format
build-tex-keep-pdf-with-format: format
	@$(MAKE) --no-print-directory build-tex-keep-pdf DIR=$(DIR)

# Compile and keep PDF and logs
.PHONY: build-tex-keep-pdf-logs
build-tex-keep-pdf-logs:
	@for tex_file in $(TEX_FILES); do \
		echo "Compiling $$tex_file and keeping PDF and logs..."; \
		cd "$$(dirname "$$tex_file")" && \
		pdflatex -interaction=nonstopmode -halt-on-error "$$(basename "$$tex_file")"; \
	done
	@$(MAKE) clean-except-logs DIR=$(DIR)

# Clean all auxiliary files from specified directory
.PHONY: clean
clean:
	@echo "Cleaning auxiliary files in $(DIR)..."
	@find $(DIR) -maxdepth 1 -name "*.aux" -delete
	@find $(DIR) -maxdepth 1 -name "*.log" -delete
	@find $(DIR) -maxdepth 1 -name "*.out" -delete
	@find $(DIR) -maxdepth 1 -name "*.fls" -delete
	@find $(DIR) -maxdepth 1 -name "*.fdb_latexmk" -delete
	@find $(DIR) -maxdepth 1 -name "*.synctex.gz" -delete
	@echo "Cleanup complete in $(DIR)."

# Clean auxiliary files except logs from specified directory
.PHONY: clean-except-logs
clean-except-logs:
	@echo "Cleaning auxiliary files in $(DIR) (keeping logs)..."
	@find $(DIR) -maxdepth 1 -name "*.aux" -delete
	@find $(DIR) -maxdepth 1 -name "*.out" -delete
	@find $(DIR) -maxdepth 1 -name "*.fls" -delete
	@find $(DIR) -maxdepth 1 -name "*.fdb_latexmk" -delete
	@find $(DIR) -maxdepth 1 -name "*.synctex.gz" -delete
	@echo "Cleanup complete in $(DIR) (logs preserved)."

# Gather all version-controlled TeX sources (excluding potential backup files)
TEX_SOURCES := $(shell git ls-files '*.tex')

.PHONY: format
format:
	@echo "Formatting TeX sources with latexindent...";
	@for f in $(TEX_SOURCES); do \
	  echo "  $$f"; \
	  latexindent -l=.latexindent.yaml -w "$$f" >/dev/null 2>&1 || { echo "latexindent failed on $$f"; exit 1; }; \
	done
	@echo "Formatting complete."

# Format a single file: make format-one FILE=path/to/file.tex
.PHONY: format-one
format-one:
	@test -n "$(FILE)" || { echo "ERROR: specify FILE=..."; exit 1; }
	@echo "Formatting $(FILE)";
	@latexindent -l=.latexindent.yaml -w "$(FILE)" >/dev/null 2>&1 || { echo "latexindent failed on $(FILE)"; exit 1; }
	@echo "Done."

# CI check: fail if any file would be reformatted
.PHONY: format-check
format-check:
	@echo "Checking formatting..."
	@dirty=0; \
	for f in $(TEX_SOURCES); do \
	  latexindent -l=.latexindent.yaml "$$f" 2>/dev/null | diff -q "$$f" - >/dev/null 2>&1 || { echo "  needs formatting: $$f"; dirty=1; }; \
	done; \
	if [ $$dirty -eq 1 ]; then echo "Formatting check FAILED. Run 'make format' to fix."; exit 1; fi
	@echo "All files formatted correctly."