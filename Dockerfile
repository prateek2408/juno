from ubuntu:focal
RUN apt-get update && apt-get install -y git vim curl build-essential manpages-dev make curl-config wget

#Install go.
RUN curl -XGET https://dl.google.com/go/go1.15.2.linux-amd64.tar.gz -o /opt/go.tar.gz 
RUN tar -xzvf /opt/go.tar.gz -C /usr/local && rm -rf /opt/go.tar.gz

#Installing vim-go plugin.
RUN git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go

#Installing pathogen.
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#Installing vim-sensible.
RUN cd ~/.vim/bundle && \
git clone https://github.com/tpope/vim-sensible.git

#Copy vimrc for all users
ADD vimrc /etc/vim/vimrc.local

#Creating dirs for go.
RUN mkdir -p /root/go/src && mkdir -p /root/go/bin

#Setup env vars.
ENV GOPATH /root/go
ENV PATH $PATH:/usr/local/go/bin:/root/go/bin

#Install Go basic modules.
#Currently it is skipped as it eats up the terminal,
#Trying to make it non interactive.
#RUN vim -T dumb -c GoInstallBinaries

#Install Delve the debbuger for Go.
RUN go get github.com/go-delve/delve/cmd/dlv

WORKDIR /root
CMD ["/bin/bash"]
