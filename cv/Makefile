# /Qompass/Latex/cv/Makefile
# Qompass AI Latex CV Makefile
# Copyright (C) 2025 Qompass AI, All rights reserved
####################################################
.PHONY: all clean
CC = xelatex
OUT_DIR = out
EXAMPLES_DIR = examples
RESUME_DIR = resume
CV_DIR = cv
RESUME_SRC = $(EXAMPLES_DIR)/resume.tex $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRC     = $(EXAMPLES_DIR)/cv.tex     $(shell find $(CV_DIR)     -name '*.tex')
COVERLETTER_SRC = $(EXAMPLES_DIR)/coverletter.tex
all: resume.pdf cv.pdf coverletter.pdf
resume.pdf: $(RESUME_SRC)
	@mkdir -p $(OUT_DIR)
	$(CC) -output-directory=$(OUT_DIR) $(EXAMPLES_DIR)/resume.tex
cv.pdf: $(CV_SRC)
	@mkdir -p $(OUT_DIR)
	$(CC) -output-directory=$(OUT_DIR) $(EXAMPLES_DIR)/cv.tex
coverletter.pdf: $(COVERLETTER_SRC)
	@mkdir -p $(OUT_DIR)
	$(CC) -output-directory=$(OUT_DIR) $(TEMPLATES_DIR)/coverletter.tex
clean:
	rm -rf $(OUT_DIR)/*.pdf
