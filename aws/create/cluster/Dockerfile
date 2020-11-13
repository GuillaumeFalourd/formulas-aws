FROM ritclizup/rit-shell-bat-runner

USER root

RUN mkdir /rit
COPY . /rit
RUN sed -i 's/\r//g' /rit/set_umask.sh
RUN sed -i 's/\r//g' /rit/run.sh
RUN chmod +x /rit/set_umask.sh

RUN echo "Installing Golang on image"
RUN apk add --no-cache git make musl-dev go
# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin
# Install Glide
RUN go get -u github.com/Masterminds/glide/...
WORKDIR $GOPATH
CMD ["make"]
RUN go version

RUN echo "Installing Node and NPM on image"
RUN apk add --update nodejs nodejs-npm
RUN node -v
RUN npm -v

RUN echo "Installing Git on image"
RUN apk add git
RUN git version

WORKDIR /app
ENTRYPOINT ["/rit/set_umask.sh"]
CMD ["/rit/run.sh"]
