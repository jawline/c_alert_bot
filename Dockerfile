FROM ubuntu:19.10
RUN apt-get update
RUN apt-get --assume-yes install pkg-config libcurl4-openssl-dev libjson-c-dev cmake binutils make

#Build the telegram bot library
COPY ./telebot/ /telebot/
WORKDIR /telebot/
RUN cmake .
RUN make
#RUN rm /telebot/*.in
RUN make install

COPY ./client/ /teleclient/
WORKDIR /teleclient/
RUN cmake ./
RUN make
ENV LD_LIBRARY_PATH=/telebot/
CMD /teleclient/alertbot
