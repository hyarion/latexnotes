
DATEFORMAT      := "+%Y-%m-%d"
DATE            := `date ${DATEFORMAT}`
NOTE_DIR    := notes
NOTE_PREFIX :=
NOTE_SUFIX  := .tex
NOTE_NAME   := ${NOTE_PREFIX}${DATE}${NOTE_SUFIX}
NOTE_PATH   := ${NOTE_DIR}/${NOTE_NAME}

NOTES       := $(wildcard ${NOTE_DIR}/${NOTE_PREFIX}*${NOTE_SUFIX})

LATEX := pslatex
DVI2PDF := dvipdf

all: notes.pdf

test:
	echo $(NOTE_DIR)
	echo $(NOTE_PREFIX)
	echo $(DATE)
	echo $(NOTE_SUFIX)
	echo ${NOTE_DIR}/${NOTE_PREFIX}\*${NOTE_SUFIX}
	echo $(NOTES)

$(NOTE_DIR):
	mkdir $(NOTE_DIR)

#notes.pdf: notes.ps
#	ps2pdf notes.ps
#
#notes.ps: notes.dvi
#	dvips notes.dvi

notes.pdf: notes.dvi
	$(DVI2PDF) notes.dvi
notes.dvi: notes.toc notes.tex
	${LATEX} notes.tex

notes.toc: notes.tex
	${LATEX} notes.tex

notes.tex: header.tex Makefile gencontent.sh ${NOTES}
	echo ${NOTES}
	cat header.tex > notes.tex
	bash ./gencontent.sh
	echo \\end{document} >> notes.tex

new: $(NOTE_DIR)
	test -e ${NOTE_PATH} || echo \\def\\date{${DATE}} > ${NOTE_PATH} && \
	                        cat    notetemplate.tex >> ${NOTE_PATH}

clean:
	rm -f notes.*
