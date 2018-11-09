FROM golang:1.11.2

RUN go get github.com/dvyukov/go-fuzz/...
COPY fuzz.sh /fuzz.sh
CMD ["/fuzz.sh"]
VOLUME /workdir
WORKDIR /workdir
