FROM bioconductor/bioconductor_docker:devel

WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/AnVILWorkshop

# Add the Cloud SDK distribution URI as a package source
# Import the Google Cloud public key
# Update the package list and install the Cloud SDK
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
	&& curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
	&& apt-get update \
	&& apt-get -y --no-install-recommends install google-cloud-sdk \
	&& rm -rf /var/lib/apt/lists/*

# Add notedown python package for AnVILPublish
RUN pip3 install notedown
ENV PATH $PATH:/home/rstudio/.local/bin

RUN Rscript -e "devtools::install('.', dependencies=TRUE, build_vignettes=TRUE, repos = BiocManager::repositories())"
