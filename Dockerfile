FROM ubuntu:19.10
RUN apt-get update
RUN apt-get --assume-yes install pkg-config libcurl4-openssl-dev libjson-c-dev cmake binutils make

#Build the telegram bot library
COPY ./telebot/ /telebot/
WORKDIR /telebot/
RUN mkdir -p Build 
WORKDIR /telebot/Build
RUN cmake ../
RUN make
RUN make install

ENV C_INCLUDE_PATH=${C_INCLUDE_PATH}:/telebot/Build/include/
ENV LD_PATH=${LD_PATH}:/telebot/Build/

COPY ./client/ /teleclient/
WORKDIR ./teleclient/
RUN mkdir -p Build
WORKDIR /teleclient/Build
RUN cmake ../
RUN make
RUN make install
