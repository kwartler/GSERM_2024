library(tesseract)
library(pdftools)

setwd("~/Desktop/GSERM_2024/personalFiles")
pdfFile <- file.path(R.home("doc"), "NEWS.pdf")
ocrResults <- pdf_ocr_text(pdfFile)
pdf_text(pdfFile, opw = "", upw = "")
