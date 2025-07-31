# /qompassai/latex/Makefile
# Qompass AI Latex Makefile
# Copyright (C) 2025 Qompass AI, All rights reserved
# ----------------------------------------
.PHONY: all clean
CC = xelatex
CV_DIR = cv
OUT_DIR = out
RESUME_DIR = resume
TEMPLATES_DIR= templates
RESUME_SRC = $(TEMPLATES_DIR)/resume.tex $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRC     = $(TEMPLATES)/cv.tex     $(shell find $(CV_DIR)     -name '*.tex')
COVERLETTER_SRC = $(TEMPLATES_DIR)/coverletter.tex
all: resume.pdf cv.pdf coverletter.pdf
resume.pdf: $(RESUME_SRC)
	@mkdir -p $(OUT_DIR)
	$(CC) -output-directory=$(OUT_DIR) $(TEMPLATES_DIR)/resume.tex
cv.pdf: $(CV_SRC)
	@mkdir -p $(OUT_DIR)
	$(CC) -output-directory=$(OUT_DIR) $(TEMPLATES_DIR_DIR)/cv.tex
coverletter.pdf: $(COVERLETTER_SRC)
	@mkdir -p $(OUT_DIR)
	$(CC) -output-directory=$(OUT_DIR) $(TEMPLATES_DIR)/coverletter.tex
clean:
	rm -rf $(OUT_DIR)/*.pdf
