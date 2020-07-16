FROM us.gcr.io/broad-dsp-gcr-public/terra-jupyter-bioconductor:0.0.14

WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

RUN Rscript -e "devtools::install('.', dependencies=TRUE, build_vignettes=TRUE, repos = BiocManager::repositories())"
