from ubuntu:focal
#Adding UID/GID in Docker container to prevent running as root inside docker.
ENV USER=devel
ENV USER_DIR=/home/devel

RUN groupadd --gid 1000 ${USER} && \
    useradd --uid 1000 --gid 1000 \
    --create-home --shell /bin/bash \
    ${USER}

#Install all dependent packages.
RUN apt-get update && apt-get install -y git vim curl build-essential manpages-dev make wget libasound2-dev alsa-base pulseaudio

#Install go.
RUN curl -XGET https://dl.google.com/go/go1.15.2.linux-amd64.tar.gz -o /opt/go.tar.gz 
RUN tar -xzvf /opt/go.tar.gz -C /usr/local && rm -rf /opt/go.tar.gz

#Installing vim-go plugin.
RUN git clone https://github.com/fatih/vim-go.git ${USER_DIR}/.vim/pack/plugins/start/vim-go

#Installing pathogen.
RUN mkdir -p ${USER_DIR}/.vim/autoload ${USER_DIR}/.vim/bundle && \
curl -LSso ${USER_DIR}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#Installing vim-sensible.
RUN cd ${USER_DIR}/.vim/bundle && \
git clone https://github.com/tpope/vim-sensible.git

#Copy vimrc for all users
ADD vimrc /etc/vim/vimrc.local

#Creating dirs for go.
RUN mkdir -p /${USER}/go/src && mkdir -p /${USER}/go/bin

#Setup env vars.
ENV GOPATH /${USER}/go
ENV PATH $PATH:/usr/local/go/bin:/${USER}/go/bin

#Install Go basic modules.
#Currently it is skipped as it eats up the terminal,
#Trying to make it non interactive.
#RUN vim -T dumb -c GoInstallBinaries

#Install Delve the debbuger for Go.
RUN go get github.com/go-delve/delve/cmd/dlv

WORKDIR ${USER_DIR}
CMD ["/bin/bash"]
