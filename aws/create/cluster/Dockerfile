FROM cimg/base:stable-20.04

USER root

RUN echo "Installing Ritchie on image"
RUN curl -fsSL https://commons-repo.ritchiecli.io/install.sh | bash

RUN mkdir /rit
COPY . /rit
RUN sed -i 's/\r//g' /rit/set_umask.sh
RUN sed -i 's/\r//g' /rit/run.sh
RUN chmod +x /rit/set_umask.sh

RUN echo "Installing Golang on image"
RUN wget -c https://golang.org/dl/go1.15.2.linux-amd64.tar.gz
RUN shasum -a 256 go1.7.3.linux-amd64.tar.gz
RUN sudo tar -C /usr/local -xvzf go1.15.2.linux-amd64.tar.gz
RUN mkdir -p ~/go_projects/{bin,src,pkg}
RUN cd ~/go_projects
RUN export PATH=$PATH:/usr/local/go/bin
RUN export GOPATH="$HOME/go_projects"
RUN export GOBIN="$GOPATH/bin"
RUN source ~/.bash_profile
RUN go version

RUN echo "Installing Node and NPM on image"
RUN sudo apt install nodejs
RUN node -v
RUN sudo apt install npm
RUN npm -v

RUN echo "Installing Git on image"
RUN sudo apt install git-all
RUN git version

WORKDIR /app
ENTRYPOINT ["/rit/set_umask.sh"]
CMD ["/rit/run.sh"]
