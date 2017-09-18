.PHONY: examples

CC = xelatex
BB = biber
EXAMPLES_DIR = examples
RESUME_DIR = examples/resume
CV_DIR = examples/cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')
TMP_FILES = $(shell find $(EXAMPLES_DIR) -name '*.aux' -or -name '*.bbl' -or -name '*.bcf' -or -name '*.blg' -or -name '*.log' -or -name '*.out' -or -name '*.run.xml')

examples: $(foreach x, coverletter cv resume, $x.pdf)

resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<
	$(BB) -output-directory=$(EXAMPLES_DIR) resume.bcf
	$(CC) -output-directory=$(EXAMPLES_DIR) $<
	$(CC) -output-directory=$(EXAMPLES_DIR) $<
	rm $(EXAMPLES_DIR)/*.{aux,bbl,bcf,blg,log,out,run.xml}

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<
	rm $(EXAMPLES_DIR)/*.{aux,log,out}

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	$(CC) -output-directory=$(EXAMPLES_DIR) $<
	rm $(EXAMPLES_DIR)/*.{aux,log,out}

clean:
	rm $(EXAMPLES_DIR)/*.pdf
