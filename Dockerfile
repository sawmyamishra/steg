FROM ubuntu

ENV TZ=Asia

ADD cover.jpg ./cover.jpg
ADD secret.jpg ./secret.jpg
ADD steglsb.py ./steglsb.py

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt install -y golang git curl wget && \
    apt-get install python3-pip -y && \
    apt-get install apache2 -y && \
    apt install -y golang git curl wget && \
    apt-get install nginx -y && \
    pip3 install pillow && \
    apt-get clean

ENV GOPATH /usr/go
RUN mkdir $GOPATH
ENV PATH $GOPATH/bin:$PATH

RUN go get github.com/yudai/gotty
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh


EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]    
